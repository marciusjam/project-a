import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/models/Model_Series.dart';
import 'package:Makulay/models/Post.dart';
import 'package:Makulay/models/PostStatus.dart';
import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/discover_page.dart';
import 'package:Makulay/screens/live_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:Makulay/screens/shop_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:Makulay/widgets/post_widgets/series.dart';
import 'package:Makulay/widgets/post_widgets/trending_card.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Makulay/models/ModelProvider.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class Stories {
  List<String> users;
  String emojistatus;
  String profilepicture;
  Stories(this.users, this.emojistatus, this.profilepicture);
}

class InterestsPage extends StatefulWidget {
  final Function onIconTap;
  final List<CameraDescription> cameras;
  final String profilepicture;
  final String username;
  final String userid;
  final int selectedPageIndex;
  const InterestsPage(
      {Key? key,
      required this.onIconTap,
      required this.cameras,
      required this.profilepicture,
      required this.username,
      required this.userid,
      required this.selectedPageIndex})
      : super(key: key);

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage>
    with
        AutomaticKeepAliveClientMixin<InterestsPage>,
        SingleTickerProviderStateMixin {
  List<Stories> storyArray = [
    Stories(['1'], '🤪', 'assets/profile-jam.jpg'),
    Stories(
      ['1', '2', '3', '4', '5', '6'],
      '😇',
      'assets/profile-shaye.jpg',
    ),
    Stories(
      [],
      '🥶',
      'assets/story_image_2.jpg',
    ),
    Stories(
      ['1', '2', '3', '4', '5', '6'],
      '💍',
      'assets/story_image_4.jpg',
    ),
    Stories(
      [],
      '🍒',
      'assets/story_image_5.jpg',
    ),
    Stories(
      [],
      '🍑',
      '',
    ),
    Stories(
      [],
      '🌪️',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
    Stories(
      [],
      '🌚',
      '',
    ),
  ];

  TabController? _tabController;

  final List<String> categories = ['Discover', 'Shop', 'Live', 'Podcasts'];

  String selectedCategory = 'Home';

  String selectedMessageTab = 'Messages';

  String selectedSubCategory = 'Stories';

  final List<String> messages = List.generate(20, (index) => "Message $index");

  final List<String> emojis = [
    '😊',
    '🤔',
    '🚀',
    '🔥',
    '💡',
    '🎉',
    '😎',
    '🙌',
    '✨',
    '🌟',
    '💤',
    '❤️',
    '🍒',
    '🍑',
    '🎒',
    '🎧'
  ];
  // Account holder's story (index -1 to represent the account holder)
  int accountHolderStory = -1;

  // Function to get a random emoji
  String getRandomEmoji() {
    final random = Random();
    return emojis[random.nextInt(emojis.length)];
  }

  bool userHasStory(int index) {
    // Return true if the index is even (for demo purposes)
    return index % 2 == 0;
  }

  bool shouldShowEmojiBubble(int index) {
    // Show the emoji bubble for the account holder and a few other random users
    return index == -1 ||
        (index > -1 && Random().nextBool() && userHasStory(index));
  }

  late String? profileUrl;
  late final Function onIconTap;
  late Future<List<Post?>> _posts;
  List<Widget> allPosts = [];
  List<Widget> allTrend = [];
  List<Widget> allPodcasts = [];
  List<Widget> allLiveHoriz = [];
  bool _isSynced = false;
  bool _listeningToHub = true;
  late StreamSubscription<DataStoreHubEvent> hubSubscription;
  List<String> _postStreamingData = <String>[];
  late Stream<SubscriptionEvent<Post>> postStream;
  var _scrollController;
  var _scrollController1;
  var _scrollController2;
  static final customCacheManager = CacheManager(Config(
    'customCacheKey',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 100,
  ));

  String? _selectedItem1 = 'Following';
  final list = ['Following', 'Trends', 'Streams', 'Podcasts'];
  List<DropdownMenuItem<String>> _createList() {
    return list
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
        .toList();
  }

  Future<String> getFileUrl(String fileKey) async {
    try {
      final result = await Amplify.Storage.getUrl(
        key: fileKey,
        options: const StorageGetUrlOptions(
          accessLevel: StorageAccessLevel.guest,
          pluginOptions: S3GetUrlPluginOptions(
            expiresIn: Duration(days: 1),
          ),
        ),
      ).result;
      //debugPrint('result ' + result.url.toString());
      _precacheImage(result.url.toString(), fileKey);
      return result.url.toString();
    } catch (e) {
      throw e;
    }
  }

  Future<void> _precacheImage(String imageUrl, String key) async {
    /*await DefaultCacheManager().putFile(
      {key,

      }
    )*/
    final imageProvider = CachedNetworkImageProvider(imageUrl,
        cacheKey: key, cacheManager: customCacheManager);
    precacheImage(imageProvider, context);
    //_preloadedImages.add(imageProvider);
  }

  /*Future<void> getPost() async {
    String postId = '13780803-626c-4965-83fc-031659318725';
    var postData = getPostByPostId(postId);
    safePrint('Jammy Response: $postData');
  }*/

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  Future<List<Widget>> fetchAllPosts() async {
    try {
      /*final request = ModelQueries.list<Post>(
        Post.classType,
        
      );
      final response = await Amplify.API.query(request: request).response;*/

      /*
      Add following label
      setState(() {
        allPosts.add(
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                Text(
              '❤️ Following',
              style: new TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      });*/

      await Amplify.DataStore.clear();
      //var response = await searchPostSortByDate();
      var response = await descendingByUserId();

      //debugPrint('response,data');
      //debugPrint(response.data.toString());
      PaginatedResult<Post>? gatheredPosts = response.data;
      //String? gatheredPosts = response.data?.items.toString().replaceAll("\n","");
      //debugPrint('Posts: $gatheredPosts');

      if (gatheredPosts == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      for (var eachPosts in gatheredPosts.items) {
        //debugPrint('eachPosts');
        //debugPrint(eachPosts.toString());

        String description = eachPosts!.description;
        String? orientation = eachPosts.orientation;

        TemporalDateTime? createddate = eachPosts!.createdAt;
        final datecreated = DateTime.parse(createddate.toString());
        final datenow = DateTime.now();
        int postage = daysBetween(datecreated, datenow); // Works!
        //debugPrint('postage '+ postage.toString());

        String? contenttype = eachPosts.contenttype;
        String? username = eachPosts.user!.username;

        String? content = eachPosts.content;
        Map<String, String> contentList = {};
        await getFileUrl(eachPosts.user!.profilePicture.toString())
            .then((value) => {
                  if (content != '' && content != "null" && content != null)
                    {
                      getFileUrl(content.toString()).then((contentvalue) {
                        //_precacheImage(value, content);
                        contentList[content] = contentvalue;

                        if (orientation == 'vertical') {
                          if (contenttype == 'image') {
                            setState(() {
                              allPosts.add(PostCard(
                                  'image-Vertical',
                                  description,
                                  contentList,
                                  username,
                                  value,
                                  postage,
                                  false,
                                  null,
                                  null));
                            });
                          } else {
                            setState(() {
                              allPosts.add(PostCard(
                                  'video-Vertical',
                                  description,
                                  contentList,
                                  username,
                                  value,
                                  postage,
                                  false,
                                  null,
                                  null));
                            });
                          }
                        } else {
                          if (contenttype == 'image') {
                            setState(() {
                              allPosts.add(PostCard(
                                  'image-Horizontal',
                                  description,
                                  contentList,
                                  username,
                                  value,
                                  postage,
                                  false,
                                  null,
                                  null));
                            });
                          } else {
                            setState(() {
                              allPosts.add(PostCard(
                                  'video-Horizontal',
                                  description,
                                  contentList,
                                  username,
                                  value,
                                  postage,
                                  false,
                                  null,
                                  null));
                            });
                          }
                        }
                      })
                    }
                  else
                    {
                      //if S3 data == null == Text Post
                      setState(() {
                        allPosts.add(PostCard('textPost', description, {},
                            username, value, postage, false, null, null));
                      })
                    }
                });
      }

      return allPosts;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<List<Widget>> fetchTrendingPosts() async {
    try {
      var loopOnly = 10;
      var currLoop = 0;
      /*final request = ModelQueries.list<Post>(
        Post.classType,
        
      );
      final response = await Amplify.API.query(request: request).response;*/
      await Amplify.DataStore.clear();
      //var response = await searchPostSortByDate();
      var response = await descendingByUserId();

      //debugPrint('response,data');
      //debugPrint(response.data.toString());
      PaginatedResult<Post>? gatheredPosts = response.data;
      //String? gatheredPosts = response.data?.items.toString().replaceAll("\n","");
      //debugPrint('Posts: $gatheredPosts');

      if (gatheredPosts == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      for (var eachPosts in gatheredPosts.items) {
        //debugPrint('eachPosts');
        //debugPrint(eachPosts.toString());
        currLoop++;
        String description = eachPosts!.description;
        String? orientation = eachPosts.orientation;

        TemporalDateTime? createddate = eachPosts!.createdAt;
        final datecreated = DateTime.parse(createddate.toString());
        final datenow = DateTime.now();
        int postage = daysBetween(datecreated, datenow); // Works!
        //debugPrint('postage '+ postage.toString());

        String? contenttype = eachPosts.contenttype;
        String? username = eachPosts.user!.username;

        String? content = eachPosts.content;
        Map<String, String> contentList = {};
        await getFileUrl(eachPosts.user!.profilePicture.toString())
            .then((value) => {
                  if (content != '' && content != "null" && content != null)
                    {
                      getFileUrl(content.toString()).then((contentvalue) {
                        //_precacheImage(value, content);
                        contentList[content] = contentvalue;
                        setState(() {
                          allTrend.add(PostCard(
                              'trends',
                              description,
                              contentList,
                              username,
                              value,
                              postage,
                              false,
                              null,
                              null));
                        });
                      })
                    }
                  else
                    {
                      //if S3 data == null == Text Post
                      setState(() {
                        allTrend.add(PostCard('trends', description, {},
                            username, value, postage, false, null, null));
                      })
                    }
                });

        if (currLoop == loopOnly) {
          continue;
        }
      }

      return allTrend;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<List<Widget>> fetchPodcasts() async {
    try {
      var loopOnly = 10;
      var currLoop = 0;
      /*final request = ModelQueries.list<Post>(
        Post.classType,
        
      );
      final response = await Amplify.API.query(request: request).response;*/
      await Amplify.DataStore.clear();
      //var response = await searchPostSortByDate();
      var response = await descendingByUserId();

      //debugPrint('response,data');
      //debugPrint(response.data.toString());
      PaginatedResult<Post>? gatheredPosts = response.data;
      //String? gatheredPosts = response.data?.items.toString().replaceAll("\n","");
      //debugPrint('Posts: $gatheredPosts');

      if (gatheredPosts == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      for (var eachPosts in gatheredPosts.items) {
        //debugPrint('eachPosts');
        //debugPrint(eachPosts.toString());
        currLoop++;
        String description = eachPosts!.description;
        String? orientation = eachPosts.orientation;

        TemporalDateTime? createddate = eachPosts!.createdAt;
        final datecreated = DateTime.parse(createddate.toString());
        final datenow = DateTime.now();
        int postage = daysBetween(datecreated, datenow); // Works!
        //debugPrint('postage '+ postage.toString());

        String? contenttype = eachPosts.contenttype;
        String? username = eachPosts.user!.username;

        String? content = eachPosts.content;
        Map<String, String> contentList = {};
        await getFileUrl(eachPosts.user!.profilePicture.toString())
            .then((value) => {
                  if (content != '' && content != "null" && content != null)
                    {
                      getFileUrl(content.toString()).then((contentvalue) {
                        //_precacheImage(value, content);
                        contentList[content] = contentvalue;
                        setState(() {
                          allPodcasts.add(PostCard(
                              'podcasts',
                              description,
                              contentList,
                              username,
                              value,
                              postage,
                              false,
                              null,
                              null));
                        });
                      })
                    }
                  else
                    {
                      //if S3 data == null == Text Post
                      setState(() {
                        allPodcasts.add(PostCard('podcasts', description, {},
                            username, value, postage, false, null, null));
                      })
                    }
                });

        if (currLoop == loopOnly) {
          continue;
        }
      }

      return allPodcasts;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  Future<List<Widget>> fetchLiveHoriz() async {
    try {
      var loopOnly = 10;
      var currLoop = 0;
      /*final request = ModelQueries.list<Post>(
        Post.classType,
        
      );
      final response = await Amplify.API.query(request: request).response;*/
      await Amplify.DataStore.clear();
      //var response = await searchPostSortByDate();
      var response = await descendingByUserId();

      //debugPrint('response,data');
      //debugPrint(response.data.toString());
      PaginatedResult<Post>? gatheredPosts = response.data;
      //String? gatheredPosts = response.data?.items.toString().replaceAll("\n","");
      //debugPrint('Posts: $gatheredPosts');

      if (gatheredPosts == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }
      for (var eachPosts in gatheredPosts.items) {
        //debugPrint('eachPosts');
        //debugPrint(eachPosts.toString());
        currLoop++;
        String description = eachPosts!.description;
        String? orientation = eachPosts.orientation;

        TemporalDateTime? createddate = eachPosts!.createdAt;
        final datecreated = DateTime.parse(createddate.toString());
        final datenow = DateTime.now();
        int postage = daysBetween(datecreated, datenow); // Works!
        //debugPrint('postage '+ postage.toString());

        String? contenttype = eachPosts.contenttype;
        String? username = eachPosts.user!.username;

        String? content = eachPosts.content;
        Map<String, String> contentList = {};
        await getFileUrl(eachPosts.user!.profilePicture.toString())
            .then((value) => {
                  if (content != '' && content != "null" && content != null)
                    {
                      getFileUrl(content.toString()).then((contentvalue) {
                        //_precacheImage(value, content);
                        contentList[content] = contentvalue;
                        setState(() {
                          allLiveHoriz.add(PostCard(
                              'live-horiz',
                              description,
                              contentList,
                              username,
                              value,
                              postage,
                              false,
                              null,
                              null));
                        });
                      })
                    }
                  else
                    {
                      //if S3 data == null == Text Post
                      setState(() {
                        allPodcasts.add(PostCard('live-horiz', description, {},
                            username, value, postage, false, null, null));
                      })
                    }
                });

        if (currLoop == loopOnly) {
          continue;
        }
      }

      return allLiveHoriz;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  _pageView(List myList) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      //controller: _scrollController,
      itemCount: myList.length,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        /*if (index == 0) {
          return Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 25),
              child: navHeader(context));
        } else if (index == 1) {
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: trendsRow(context));
        } else if (index == 2) {
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: podcastsRow(context));
        } else if (index == 3) {
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: liveRow(context));
        } else*/
        if (index % 3 == 0 && index != 0) {
          return Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: sharesRow(context));
        } else {
          return myList[index];
        }
      },
    );
  }

  /*_columnView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //SizedBox(height: 10),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.amber,
                          width: 3,
                        ),
                        image: DecorationImage(
                          image: AssetImage(stories[index].imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      stories[index].username,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        //SizedBox(height: 10),
        Container(child: _pageView(list)),
      ],
    );
  }*/

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    fetchAllPosts().then((value) => {_refreshController.refreshCompleted()});
    //debugPrint(value.toString()),
    //debugPrint('allPosts')});
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    //_tabController = TabController(vsync: this, length: 5);

    super.initState();
    /*_scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
// scroll has reach end, now load more images.
            loadMore();
          }
        });*/
    setState(() {
      selectedCategory = 'Home';
      selectedMessageTab = 'Messages';
    });

    //debugPrint('fetchAllPosts');
    if (!Amplify.isConfigured) {
      debugPrint('not yet configured!!!');
    }
    /*setState(() {
      allPosts.add(navHeader(context));
    });*/

    //Working

    fetchTrendingPosts();
    fetchPodcasts();
    fetchLiveHoriz();
    fetchAllPosts();
    //Deprecated
    //getAllPosts();
    //getPost();

    //debugPrint('ulala');
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);
    //debugPrint(_postStreamingData.toString());
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget navHeader(BuildContext context) {
    return Card(
        elevation: 0,
        surfaceTintColor: Colors.white, //IOS
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          side: new BorderSide(color: Colors.white12, width: .3),
          borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                //width: MediaQuery.sizeOf(context).width - 10,
                child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding:
                                    //faves[index].chatType == 'group'
                                    //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                    //:
                                    EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              widget.profilepicture),
                                    ),
                                    Positioned(
                                      bottom:
                                          4, // Position it at the bottom right corner
                                      right: 4,
                                      child: Container(
                                        width:
                                            10, // Size of the online indicator
                                        height: 10,
                                        decoration: BoxDecoration(
                                          //color: isOnline ? Colors.green : Colors.grey, // Green for online, grey for offline
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors
                                                .white, // Border color to separate from the avatar
                                            width: .7,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 2, 0),
                                      child: Text(
                                        widget.username,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 2, 5, 0),
                                        child: Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: Colors.amber,
                                        )),
                                    /*Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child:Text(
                                            '🇵🇭',
                                            //'Social',
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 17,
                                            ),
                                          ),
                                    ),*/
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            'John Marcius Tolentino',
                                            //'Social',
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 17,
                                            ),
                                          ),
                                          //Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0), child: Icon(Icons.edit, color: Colors.amber, size: 15,),)
                                        ],
                                      ),
                                    )),
                              ],
                            ),

                            /*Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                        child:Stack(children: [
                          Icon(Icons.messenger_outline_sharp,
                            size: 40.0, color: Colors.black),
                            Positioned(
                              bottom: 10,
                              left: 7,
                              child: Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Icon(Icons.mode_edit_rounded,
                            size: 27.0, color: Colors.black),)),
                          
                          
                            
                            ],) )*/
                            /*Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 0, 5),
                                          child: Container(
                                              width: 50,
                                              child: CustomVideoPlayer(
                                                  'fade',
                                                  'assets/series_2.mp4',
                                                  9 / 16,
                                                  'description',
                                                  'username',
                                                  'profilepicture',
                                                  2,
                                                  null,
                                                  false))),*/
                          ]),
                    ],
                  )),
            )),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            '100 ✴️',
                            //'Social',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          //Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0), child: Icon(Icons.edit, color: Colors.amber, size: 15,),)
                        ],
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            '5 🏆',
                            //'Social',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          //Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0), child: Icon(Icons.edit, color: Colors.amber, size: 15,),)
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ));
  }

  Widget trendsRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '🔥 Trending',
                style: new TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            /*Spacer(),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                'View more',
                style: new TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
            )*/
          ],
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 5.5,
              width: MediaQuery.sizeOf(context).width,
              child: //Row(
                  //children: [
                  ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                      itemBuilder: (BuildContext contextt, int index) {
                        return Container(
                          width: 380,
                          //height: 100,
                          child: //AspectRatio(
                              //aspectRatio: 9 / 16,
                              //child:
                              allTrend[index],
                          //),
                        );
                      }),
              //],
            ),
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '❤️ Following',
                style: new TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Latest',
                    style: new TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade400,
                    ))
              ],
            )
          ],
        ),*/
        //)
      ],
    );
  }

  Widget podcastsRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '🎙️ Podcasts',
                style: new TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            /*Spacer(),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                'View more',
                style: new TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
            )*/
          ],
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 5.2,
              width: MediaQuery.sizeOf(context).width,
              child: //Row(
                  //children: [
                  ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                      itemBuilder: (BuildContext contextt, int index) {
                        return Container(
                          width: 178,
                          //height: 100,
                          child: //AspectRatio(
                              //aspectRatio: 9 / 16,
                              //child:
                              allPodcasts[index],
                          //),
                        );
                      }),
              //],
            ),
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '❤️ Following',
                style: new TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Latest',
                    style: new TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade400,
                    ))
              ],
            )
          ],
        ),*/
        //)
      ],
    );
  }

  Widget liveRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '🔴 Live',
                style: new TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            /*Spacer(),
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                'View more',
                style: new TextStyle(color: Colors.grey.shade500, fontSize: 15),
              ),
            )*/
          ],
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 5.2,
              width: MediaQuery.sizeOf(context).width,
              child: //Row(
                  //children: [
                  ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                      itemBuilder: (BuildContext contextt, int index) {
                        return Container(
                          width: 338,
                          //height: 100,
                          child: //AspectRatio(
                              //aspectRatio: 9 / 16,
                              //child:
                              allLiveHoriz[index],
                          //),
                        );
                      }),
              //],
            ),
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '❤️ Following',
                style: new TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Latest',
                    style: new TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade400,
                    ))
              ],
            )
          ],
        ),*/
        //)
      ],
    );
  }

  Widget sharesRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                    Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Icon(
                          Icons.compare_arrows_rounded,
                          color: Colors.green,
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        'marciusjam',
                        style: new TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(
                        'shared',
                        style: new TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    )
                  ],
                )),
            //Spacer(),
            /*Container(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                'View more',
                style: new TextStyle(color: Colors.grey.shade400, fontSize: 15),
              ),
            )*/
          ],
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 5.2,
              width: MediaQuery.sizeOf(context).width,
              child: //Row(
                  //children: [
                  ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                      itemBuilder: (BuildContext contextt, int index) {
                        return Container(
                          width: 380,
                          //height: 100,
                          child: //AspectRatio(
                              //aspectRatio: 9 / 16,
                              //child:
                              allTrend[index],
                          //),
                        );
                      }),
              //],
            ),
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: /*Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.red,
                  size: 40,
                )*/
                  Text(
                '❤️ Following',
                style: new TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Latest',
                    style: new TextStyle(color: Colors.grey.shade400, fontSize: 15),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey.shade400,
                    ))
              ],
            )
          ],
        ),*/
        //)
      ],
    );
  }

  /*void _onLeftSwipe(int index) {
    int finalIndex = index;
    widget.onIconTap(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + finalIndex.toString());
  }*/

  Route _routeToNewPost() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NewPostPage(
              username: widget.username,
              profilepicture: widget.profilepicture,
              cameras: widget.cameras,
              preselectedAssets: [],
              preentityPaths: [],
              descriptionController: new TextEditingController(),
              onIconTap: widget.onIconTap,
              selectedPageIndex: widget.selectedPageIndex,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1, 0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  Route _routeToDiscover() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DiscoverPage(
              widget.profilepicture,
              widget.username,
              widget.userid,
              widget.cameras,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  void _centerSelectedChip(int selectedIndex) {
    // Ensure that the selected chip scrolls to the center of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    double chipWidth = 150;
    double scrollPosition =
        (selectedIndex) * chipWidth - (screenWidth / 2) + (chipWidth / 2);

    _scrollController.animateTo(
      scrollPosition,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  final int crossAxisCount = 4; // 4 columns

  double calculateGridHeight(int itemCount, double itemHeight, double spacing) {
    // Calculate the number of rows required
    var itemCountToUse = itemCount;
    if (itemCountToUse < 4) {
      itemCountToUse = 4;
    }
    //double rowValue = itemCountToUse / crossAxisCount;
    int rows = (itemCountToUse / crossAxisCount).ceil();
    //String rows = rowValue.toStringAsFixed(0);
    debugPrint('rows' + rows.toString());
    // Calculate total height based on rows, item height, and spacing
    return (rows * itemHeight) - (5 * (rows - 1));

    //return int.parse(rows) * itemHeight + spacing;
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    super.build(context);
    // Get half the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;

    // Create two lists: one for users with stories, and one for users without
    List<int> usersWithStories = [];
    List<int> usersWithoutStories = [];
    List<int> othersWithStories = [];
    List<int> othersWithoutStories = [];

    // Populate the lists by checking each index (0 to 49)
    for (int index = 0; index < 10; index++) {
      if (userHasStory(index)) {
        usersWithStories.add(index);
      } else {
        usersWithoutStories.add(index);
      }
    }

    for (int index = 0; index < 31; index++) {
      if (userHasStory(index)) {
        othersWithStories.add(index);
      } else {
        othersWithoutStories.add(index);
      }
    }

    // Combine the two lists: first users with stories, then those without
    List<int> favoriteUsers = [
      accountHolderStory,
      ...usersWithStories,
      ...usersWithoutStories
    ];

    List<int> otherUsers = [...othersWithStories, ...othersWithoutStories];

    double gridItemHeight =
        115; // Height of each grid item (CircleAvatar + label)
    double gridSpacing = 0; // Spacing between grid items

    // Calculate the height for pinned users' grid
    double pinnedGridHeight = calculateGridHeight(
      favoriteUsers.length,
      gridItemHeight,
      gridSpacing,
    );

    double otherPinnedGridHeight = calculateGridHeight(
      otherUsers.length,
      gridItemHeight,
      gridSpacing,
    );


    return CustomScrollView(controller: _scrollController2, slivers: [
      SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 70, 20, 15),
            child: //_buildSearchBar(),
                Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      children: [
                        Text(
                          'Ma',
                          style: TextStyle(
                            color: //selectedCategory == 'Makulay' ?
                                Colors.orange
                            //: Colors.grey[400]
                            ,
                            fontSize: 35,
                            fontFamily: 'Gotham-Black',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'kulay',
                          style: TextStyle(
                            color: //selectedCategory == 'Makulay' ?
                                Colors.amber
                            //: Colors.grey[400]
                            ,
                            fontSize: 35,
                            fontFamily: 'Gotham-Black',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    )),
                Spacer(),
                Container(
                  //width: 50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ActivitiesPage()),
                              )
                            },
                            child: Icon(Icons.notifications_none_rounded,
                                size: 33.0, color: Colors.black),
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 20),
                        child: Stack(
                          children: <Widget>[
                            Icon(Icons.brightness_1,
                                size: 20.0, color: Colors.amber),
                            Positioned(
                                top: 3.0,
                                left: 7.0,
                                child: Center(
                                  child: Text(
                                    '4',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
      SliverToBoxAdapter(
          child: Container(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
        child: _buildSearchBar(),
      )),
      SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.fromLTRB(35, 5, 0, 20),
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSubCategory = 'Stories';
                  });
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    alignment: Alignment.centerLeft,
                    //padding: EdgeInsets.only(right: 20),
                    //width: MediaQuery.sizeOf(context).width / 3,
                    child: Row(
                      children: [
                        /*Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                      child: Stack(
                                        children: <Widget>[
                                          Icon(Icons.brightness_1,
                                              size: 20.0, color: Colors.amber),
                                          Positioned(
                                              top: 2.0,
                                              left: 6.0,
                                              child: Center(
                                                child: Text(
                                                  '4',
                                                  style: new TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),*/
                        Text('Stories',
                            style: TextStyle(
                                fontSize:
                                    selectedSubCategory == 'Stories' ? 17 : 15,
                                fontWeight: selectedSubCategory == 'Stories'
                                    ? FontWeight.bold
                                    : null)),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSubCategory = 'Posts';
                  });
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  //width: MediaQuery.sizeOf(context).width / 3,
                  child: Text(
                    'Posts',
                    style: TextStyle(
                        fontSize: selectedSubCategory == 'Posts' ? 17 : 15,
                        fontWeight: selectedSubCategory == 'Posts'
                            ? FontWeight.bold
                            : null),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSubCategory = 'Requests';
                  });
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                  alignment: Alignment.centerRight,
                  //width: MediaQuery.sizeOf(context).width / 3,
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.amber),
                          Positioned(
                              top: 2.0,
                              left: 6.0,
                              child: Center(
                                child: Text(
                                  '4',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.mail,
                      size: 25,
                      color: selectedSubCategory == 'Requests'
                          ? Colors.black
                          : Colors.grey.shade400,
                    )
                    /*Text(
                  'Requests',
                  style: TextStyle(
                    fontSize: selectedSubCategory == 'Requests' ? 17 : 15,
                    fontWeight: selectedSubCategory == 'Requests' ? FontWeight.bold : null
                    ),
                ),*/
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
      if (selectedSubCategory == 'Stories')
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            height:
                pinnedGridHeight, // Grid height is set to 1/3 of screen height
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //physics: BouncingScrollPhysics(), // Makes the grid independently scrollable
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 5 columns
                crossAxisSpacing: 0, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 1, // Square grid items
              ),
              itemBuilder: (BuildContext context, int index) {
                int userIndex =
                    favoriteUsers[index]; // Get user index from the sorted list
                bool isAccountHolder = userIndex ==
                    accountHolderStory; // Check if this is the account holder
                bool hasStory = isAccountHolder ||
                    userHasStory(
                        userIndex); // Account holder always has a story
                final gender = index % 2 == 0 ? 'men' : 'women';
                final int randomNumber = Random().nextInt(100);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Stack to position the thought bubble on top-right of the CircleAvatar
                    Stack(
                      children: [
                        // Container with a conditional border (outer layer)
                        Container(
                          padding:
                              EdgeInsets.all(3), // Space for the outer border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Conditional border: gradient if user has a story, grey if not
                            gradient: hasStory
                                ? LinearGradient(
                                    colors: [Colors.orange, Colors.amber],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: hasStory ? null : Colors.grey[100],
                          ),
                          child: Container(
                          padding:
                              EdgeInsets.all(3), // Space for the outer border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Conditional border: gradient if user has a story, grey if not
                            gradient: hasStory
                                ? LinearGradient(
                                    colors: [Colors.white, Colors.white],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: hasStory ? null : Colors.grey[100],
                          ),
                          child: CircleAvatar(
                            radius: 30, // Adjusted size of the avatar
                            backgroundColor: Colors.black,
                            backgroundImage: isAccountHolder
                                ? CachedNetworkImageProvider(
                                    widget.profilepicture)
                                : CachedNetworkImageProvider('https://randomuser.me/api/portraits/$gender/$randomNumber.jpg'),
                            /*child: isAccountHolder
                                ? null
                                : Text('S$userIndex',
                                    style: TextStyle(color: Colors.white)),*/
                          ),
        )),
                        // Positioned thought bubble with a random emoji conditionally shown
                        //if (shouldShowEmojiBubble(userIndex)) // Show emoji bubble conditionally
                        if(index < 6)
                          /*Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Text(
                                getRandomEmoji(), // Display random emoji
                                style: TextStyle(fontSize: 16),
                              ),
                            ),*/
                            Positioned(
                            right: 0,
                            top: 0,
                            child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.black),
                          Positioned(
                              top: 2.0,
                              left: 7.0,
                              child: Center(
                                child: Text(
                                  '4',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      ),
                    ),
                          
                      ],
                    ),
                    SizedBox(height: 2), // Spacing between avatar and text
                    // Story label below the avatar
                    Text(
                      isAccountHolder ? 'marciusjam' : 'Story $userIndex',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis, // Handle long text
                    ),
                  ],
                );
              },
              itemCount: favoriteUsers.length, // Number of grid items (stories)
            ),
          ),
        ),
      if (selectedSubCategory == 'Stories')
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
          child: Divider(
            color: Colors.grey.shade200,
          ),
        )),
      if (selectedSubCategory == 'Posts')
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index != 0 && index % 4 == 0) {
                return Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    color: Colors.white,
                    child: sharesRow(context));
              } else if (index == 0) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: allPosts[index]);
              } else {
                return allPosts[index];
              }
            },
            childCount: allPosts.length, // Example list item count
          ),
        ),
      if (selectedSubCategory == 'Stories')
        SliverToBoxAdapter(
          child: Container(
            height: otherPinnedGridHeight + 100,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //physics: BouncingScrollPhysics(), // Makes the grid independently scrollable
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 5 columns
                crossAxisSpacing: 0, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 1, // Square grid items
              ),
              itemBuilder: (BuildContext context, int index) {
                int userIndex =
                    otherUsers[index]; // Get user index from the sorted list
                /*bool isAccountHolder = userIndex ==
                accountHolderStory;*/ // Check if this is the account holder
                bool hasStory = userHasStory(
                    userIndex); // Account holder always has a story
                final gender = index % 2 == 0 ? 'men' : 'women';
                final int randomNumber = Random().nextInt(100);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Stack to position the thought bubble on top-right of the CircleAvatar
                    Stack(
                      children: [
                        // Container with a conditional border (outer layer)
                        Container(
                          padding:
                              EdgeInsets.all(3), // Space for the outer border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Conditional border: gradient if user has a story, grey if not
                            gradient: hasStory
                                ? LinearGradient(
                                    colors: [Colors.orange, Colors.amber],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: hasStory ? null : Colors.grey[100],
                          ),
                          child: Container(
                          padding:
                              EdgeInsets.all(3), // Space for the outer border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Conditional border: gradient if user has a story, grey if not
                            gradient: hasStory
                                ? LinearGradient(
                                    colors: [Colors.white, Colors.white],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                            color: hasStory ? null : Colors.grey[100],
                          ),
                          child: CircleAvatar(
                            radius: 30, // Adjusted size of the avatar
                            backgroundColor: Colors.black,
                            backgroundImage: CachedNetworkImageProvider('https://randomuser.me/api/portraits/$gender/$randomNumber.jpg'),
                            /*child: Text(
                              'S$userIndex',
                              style: TextStyle(color: Colors.white),
                            ),*/
                          ),
                        ),
                        ),
                        // Positioned thought bubble with a random emoji conditionally shown
                        /*if (shouldShowEmojiBubble(userIndex)) // Show emoji bubble conditionally
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Text(
                                getRandomEmoji(), // Display random emoji
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),*/
                        if(index < 6)
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Stack(
                        children: <Widget>[
                          Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.black),
                          Positioned(
                              top: 2.0,
                              left: 7.0,
                              child: Center(
                                child: Text(
                                  '4',
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      ),
                    ),
                      ],
                    ),
                    SizedBox(height: 2), // Spacing between avatar and text
                    // Story label below the avatar
                    Text(
                      'Story $userIndex',
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis, // Handle long text
                    ),
                  ],
                );
              },
              itemCount: otherUsers.length, // Number of grid items (stories)
            ),
          ),
        ),
    ]);
    //),
    //),
    /*SliverToBoxAdapter(
          child: Container(
            height: screenHeight / 2,
            child: Container(
                height: MediaQuery.sizeOf(context).height,
                child: SmartRefresher(
                  scrollController: _scrollController2,
                  scrollDirection: Axis.horizontal,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                  
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: _pageView(allPosts)
                    ))
          ),
        ),*/
    //],

    /*Container(
                height: MediaQuery.sizeOf(context).height,
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    header: WaterDropHeader(),
                  
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: _pageView(allPosts)
                    ))*/

    /*SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index != 0 && index % 4 == 0) {
                return Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    color: Colors.white,
                    child: sharesRow(context));
              } else {
                return allPosts[index];
              }
            },
            childCount: allPosts.length, // Example list item count
          ),
        ),*/

    /*GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! < 0) {
            Navigator.push(context, _routeToDiscover());
          } else {
            Navigator.push(context, _routeToNewPost());
          }
        },
        child: */
    /*ExtendedNestedScrollView(
              pinnedHeaderSliverHeightBuilder: () => 60,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      centerTitle: true,
                       backgroundColor: Colors.transparent,
                        //expandedHeight: 115.0,
                        titleSpacing: 0,
                        toolbarHeight: 60,
                        floating: false,
                        foregroundColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        pinned: true, // Keeps the AppBar visible when scrolled up
                        title:
                          
                          Container(
                          color: Colors.transparent,
                          height: 50,
                          //width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child:  //Row(children: [ 
                            //Container(
                            //padding: EdgeInsets.fromLTRB(MediaQuery.sizeOf(context), 0, 0, 0),
                            //width: MediaQuery.sizeOf(context),
                            //child: //Icon(Icons.add_box_rounded, color: Colors.black, size: 40,)),
                            TabBar(
                              splashFactory: NoSplash.splashFactory,
                              tabAlignment: TabAlignment.center,
                              isScrollable: true,
                              controller: _tabController,
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.transparent,
                              indicatorPadding: EdgeInsets.all(0),
                              labelPadding: EdgeInsets.fromLTRB(7, 0, 7, 0),
                              onTap: (value) {
                                /*setState(() {
                                        selectedCategory == 'Following';
                                      });*/
                                      _tabController?.animateTo(value);
                              },
                              tabs: [
                                Tab(
                                    height: 70,
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 0, 0, 10), child: Row(
                                          children: [
                                            Text(
                                              'ma',
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 30,
                                                fontFamily: 'Gotham-Black',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'kulay',
                                              style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 30,
                                                fontFamily: 'Gotham-Black',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ))),
                                Tab(
                                  child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: ChoiceChip(
                                    label: Text('Discover'),
                                    selected: selectedCategory == 'Discover',
                                    // Change color when selected
                                    side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                    selectedColor: Colors.black,
                                    showCheckmark: false,
                                    backgroundColor: Colors.grey[100],
                                    labelStyle: TextStyle(
                                      color: selectedCategory == 'Discover'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onSelected: (bool selected) {
                                      print(selectedCategory);
                                       setState(() {
                                        selectedCategory == 'Discover';
                                      });
                                      _tabController?.animateTo(1);
                                      
                                    },
                                  ),
                                )),
                                
                                
                                Tab(
                                  child: ChoiceChip(
                                    label: Text('Shop'),
                                    selected: selectedCategory == 'Shop',
                                    // Change color when selected
                                    side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                    selectedColor: Colors.black,
                                    showCheckmark: false,
                                    backgroundColor: Colors.grey[100],
                                    labelStyle: TextStyle(
                                      color: selectedCategory == 'Shop'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onSelected: (bool selected) {
                                      print(selectedCategory);
                                      setState(() {
                                        selectedCategory == 'Shop';
                                      });
                                      _tabController?.animateTo(2);
                                    },
                                  ),
                                ),
                                Tab(
                                  child: ChoiceChip(
                                    label: Text('Live'),
                                    selected: selectedCategory == 'Live',
                                    // Change color when selected
                                    side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                    selectedColor: Colors.black,
                                    showCheckmark: false,
                                    backgroundColor: Colors.grey[100],
                                    labelStyle: TextStyle(
                                      color: selectedCategory == 'Live'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onSelected: (bool selected) {
                                      print(selectedCategory);
                                      setState(() {
                                        selectedCategory == 'Live';
                                      });
                                      _tabController?.animateTo(3);
                                    },
                                  ),
                                ),
                                Tab(
                                    child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: ChoiceChip(
                                    label: Text('Podcasts'),
                                    selected: selectedCategory == 'Podcasts',
                                    // Change color when selected
                                    side: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                    selectedColor: Colors.black,
                                    showCheckmark: false,
                                    backgroundColor: Colors.grey[100],
                                    labelStyle: TextStyle(
                                      color: selectedCategory == 'Podcasts'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onSelected: (bool selected) {
                                      print(selectedCategory);
                                      setState(() {
                                        selectedCategory == 'Podcasts';
                                      });
                                      _tabController?.animateTo(4);
                                    },
                                  ),
                                )),
                              ]),
                               //],)
                        )
                        
                       
                        ),
                  ];
                },
                body: TabBarView(controller: _tabController, children: [
                  GestureDetector(
                    onHorizontalDragEnd: (dragEndDetails) {
                      if (dragEndDetails.primaryVelocity! > 0) {
                        Navigator.push(context, _routeToNewPost());
                      }else{
                        _tabController?.animateTo(1);
                      }
                    },
                    child:CustomScrollView(
                    //controller: _scrollController2,
                    slivers: [
                      SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
              height: screenHeight / 4, // Grid height is set to 1/3 of screen height
              child: GridView.builder(
                physics: BouncingScrollPhysics(), // Makes the grid independently scrollable
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 5 columns
                  crossAxisSpacing: 10, // Spacing between columns
                  mainAxisSpacing: 10, // Spacing between rows
                  childAspectRatio: 1, // Square grid items
                ),
                 itemBuilder: (BuildContext context, int index) {
                  int userIndex = favoriteUsers[index]; // Get user index from the sorted list
                  bool isAccountHolder = userIndex == accountHolderStory; // Check if this is the account holder
                  bool hasStory = isAccountHolder || userHasStory(userIndex); // Account holder always has a story

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Stack to position the thought bubble on top-right of the CircleAvatar
                      Stack(
                        children: [
                          // Container with a conditional border (outer layer)
                          Container(
                            padding: EdgeInsets.all(3), // Space for the outer border
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // Conditional border: gradient if user has a story, grey if not
                              gradient: hasStory
                                  ? LinearGradient(
                                      colors: [Colors.orange, Colors.amber],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: hasStory ? null : Colors.grey[100],
                            ),
                            child: CircleAvatar(
                              radius: 20, // Adjusted size of the avatar
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                isAccountHolder ? 'Me' : 'S$userIndex',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          // Positioned thought bubble with a random emoji conditionally shown
                          if (shouldShowEmojiBubble(userIndex)) // Show emoji bubble conditionally
                            Positioned(
                              right: -4,
                              top: -4,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Text(
                                  getRandomEmoji(), // Display random emoji
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 2), // Spacing between avatar and text
                      // Story label below the avatar
                      Text(
                        isAccountHolder ? 'marciusjam' : 'Story $userIndex',
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis, // Handle long text
                      ),
                    ],
                  );
                },
                itemCount: favoriteUsers.length, // Number of grid items (stories)
              ),
            ),
          ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            if (index != 0 && index % 4 == 0) {
                              return Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  color: Colors.white,
                                  child: sharesRow(context));
                            } else {
                              return allPosts[index];
                            }
                          },
                          childCount:
                              allPosts.length, // Example list item count
                        ),
                      ),

                      
                    ],
                  )),
                   CustomScrollView(
                    controller: _scrollController1,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(height: MediaQuery.sizeOf(context).height, child:  DiscoverPage(
                          widget.profilepicture,
                          widget.username,
                          widget.userid,
                          widget.cameras,
                        ),))]),
                  
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(height: screenHeight,child: ShopPage(),)
                        
                      )
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(height: screenHeight,child: LivePage(),)
                        
                      )
                    ],
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Center(
                          child: Text('Podcasts'),
                        ),
                      )
                    ],
                  )
                ]))*/
    //)
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
