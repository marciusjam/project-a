import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/models/Model_Series.dart';
import 'package:Makulay/models/Post.dart';
import 'package:Makulay/models/PostStatus.dart';
import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/discover_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:Makulay/widgets/post_widgets/series.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Makulay/models/ModelProvider.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class InterestsPage extends StatefulWidget {
  final Function onIconTap;
  final List<CameraDescription> cameras;
  final String profilepicture;
  final String username;
  final String userid;
  final int selectedPageIndex;
  const InterestsPage({Key? key, required this.onIconTap, required this.cameras, required this.profilepicture, required this.username, required this.userid, required this.selectedPageIndex}) : super(key: key);

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage>
    with AutomaticKeepAliveClientMixin<InterestsPage> {
  late String? profileUrl;
  late final Function onIconTap;
  late Future<List<Post?>> _posts;
  List<Widget> allPosts = [];
  bool _isSynced = false;
  bool _listeningToHub = true;
  late StreamSubscription<DataStoreHubEvent> hubSubscription;
  List<String> _postStreamingData = <String>[];
  late Stream<SubscriptionEvent<Post>> postStream;
  var _scrollController;
  final _scrollController2 = ScrollController();
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
          child: Text(e, style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),),
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

  Future<void> getPost() async {
    String postId = '13780803-626c-4965-83fc-031659318725';
    var postData = getPostByPostId(postId);
    safePrint('Jammy Response: $postData');
  }

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
      await Amplify.DataStore.clear();
      var response = await searchPostSortByDate();

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

  _pageView(List myList) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      //controller: _scrollController,
      itemCount: myList.length,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        return myList[index];
        /*Column(
          children: [
            Divider(
              height: .5,
              color: Colors.white,
              thickness: .5,
              indent: 0,
              endIndent: 0,
            ),
          ],
        );*/
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
    fetchAllPosts().then(
        (value) => {debugPrint(value.toString()), debugPrint('allPosts')});
    _refreshController.refreshCompleted();
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
    _scrollController = ScrollController();
    //_tabController = TabController(vsync: this, length: 5);

    super.initState();
    /*_scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
// scroll has reach end, now load more images.
            loadMore();
          }
        });*/
    /*setState(() {
      allPosts.add(activities(context));
    });*/

    debugPrint('fetchAllPosts');
    if (!Amplify.isConfigured) {
      debugPrint('not yet configured!!!');
    }
    /*setState(() {
      allPosts.add(navHeader(context));
    });*/

    //Working
    //fetchAllPosts();

    //Deprecated
    //getAllPosts();
    //getPost();

    debugPrint('ulala');
    //debugPrint(_postStreamingData.toString());
  }

  Widget activities(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        width: double.maxFinite,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Row(
                  children: [
                    //Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0), child: Text('Fades', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),),
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/profile-jam.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/story_image_2.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/story_image_3.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/story_image_4.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: InkWell(
                            onTap: () => {},
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircleAvatar(
                                backgroundColor: Colors.amber,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/story_image_5.jpg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),

                    Spacer(),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child: Icon(Icons.remove_red_eye_rounded,
                          size: 20.0, color: Colors.white),
                    ),

                    //Text('View', style: TextStyle(fontSize: 15, color: Colors.amber),),
                  ],
                ),
              ),
              //Expanded(child: ,),
            ],
          ),
        ));
  }


  Widget navHeader(BuildContext context) {
    return Container(
      //color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /**/
              /*Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0), child: 
              Icon(Icons.favorite_border_rounded, size: 28,)
              /*Text(
                'My Fades',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
              )*/,),*/

              /*Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  'Others',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),*/
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child: Icon(Icons.messenger_outline_rounded,
                          size: 27.0, color: Colors.grey.shade900),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Icon(Icons.brightness_1,
                            size: 20.0, color: Colors.amber),
                        Positioned(
                            top: 3.0,
                            left: 7.0,
                            child: Center(
                              child: Text(
                                '9',
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
              /*Padding(
                padding: EdgeInsets.fromLTRB(0, 13, 10, 0),
                child: Text(
                  'Feed',
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),*/
              /*Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivitiesPage()),
                            )
                          },
                          child:
                              Icon(Icons.local_fire_department_rounded, size: 27.0, color: Colors.grey.shade900),
                        ),
                      ),
                      /*Padding(
                        padding: EdgeInsets.fromLTRB(13, 5, 20, 0),
                        child: Stack(
                          children: <Widget>[
                            Icon(Icons.brightness_1,
                                size: 20.0, color: Colors.amber),
                            Positioned(
                                top: 3.0,
                                left: 7.0,
                                child: Center(
                                  child: Text(
                                    '9',
                                    style: new TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                          ],
                        ),
                      )*/
                    ],
                  ),*/
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child:DropdownButtonHideUnderline(
 child:
              DropdownButton(
                hint: Text(_selectedItem1!, style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),),
                items: _createList(),
                onChanged: (String? value) => setState(() {
                  _selectedItem1 = value ?? "";
                }),)
              ),)
               /*Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child: Icon(Icons.travel_explore_rounded,
                          size: 27.0, color: Colors.grey.shade900),
                    ),
                  ),
                  /*Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Icon(Icons.brightness_1,
                            size: 20.0, color: Colors.amber),
                        Positioned(
                            top: 3.0,
                            left: 7.0,
                            child: Center(
                              child: Text(
                                '9',
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    ),
                  )*/
                ],
              ),*/
            ]));
  }

  void _onLeftSwipe(int index) {
    int finalIndex = index;
    widget.onIconTap(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + finalIndex.toString());
  }

  Route _routeToNewPost() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DiscoverPage(
                                      widget.profilepicture,
                                      widget.username, 
                                      widget.userid,
                                      widget.cameras,
                                      ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1,0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
}
  );
}

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return 
    GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0 ) {
      Navigator.push(
                            context,
      _routeToNewPost()
      );
    }else{
      _onLeftSwipe(0);
    } },
      child: SingleChildScrollView(
     //physics: NeverScrollableScrollPhysics(),
      child:  Column(
        children: [
           //SizedBox(height: 40,),
           // navHeader(context),   
          
          
          Container(
            height: MediaQuery.sizeOf(context).height,
              child:
           SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  /*footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
                body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),*/
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: //_pageView(allPosts) 
                  Container(child: Center(child: Text('Posts'),),)
                  )
                  )
        ],)
      
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
