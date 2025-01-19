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

class GroupPostsPage extends StatefulWidget {
  final String profilepicture;
  final String username;
  final String userid;
  const GroupPostsPage(
      {Key? key,
      required this.profilepicture,
      required this.username,
      required this.userid,})
      : super(key: key);

  @override
  State<GroupPostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<GroupPostsPage>
    with
        AutomaticKeepAliveClientMixin<GroupPostsPage>,
        SingleTickerProviderStateMixin {
  
  
  TabController? _tabController;

  final List<String> categories = ['Discover', 'Shop', 'Live', 'Podcasts'];

  String selectedCategory = 'Home';

  String selectedMessageTab = 'Messages';

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

      //await Amplify.DataStore.clear();
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
      //await Amplify.DataStore.clear();
      //var response = await searchPostSortByDate();
      var response = await descendingByUserId();

      debugPrint('response,data');
      debugPrint(response.data.toString());
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

    super.initState();
    

    //debugPrint('fetchAllPosts');
    if (!Amplify.isConfigured) {
      debugPrint('not yet configured!!!');
    }
    /*setState(() {
      allPosts.add(navHeader(context));
    });*/

    //Working

    fetchTrendingPosts();
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

  Widget sharesRow(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 5.2,
              width: MediaQuery.sizeOf(context).width ,
              color: Colors.white,
              child: //Row(
                  //children: [
                  ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      //controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      padding: new EdgeInsets.fromLTRB(0, 0, 15, 0),
                      itemBuilder: (BuildContext context, int index) {
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
        
      ],
    );
  }

  /*void _onLeftSwipe(int index) {
    int finalIndex = index;
    widget.onIconTap(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + finalIndex.toString());
  }*/


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

    // Populate the lists by checking each index (0 to 49)
    for (int index = 0; index < 50; index++) {
      if (userHasStory(index)) {
        usersWithStories.add(index);
      } else {
        usersWithoutStories.add(index);
      }
    }

    // Combine the two lists: first users with stories, then those without
    List<int> sortedUsers = [
      accountHolderStory,
      ...usersWithStories,
      ...usersWithoutStories
    ];

    return CustomScrollView(
      controller: _scrollController2,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: sharesRow(context)
                    
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
