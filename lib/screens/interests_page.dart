import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/models/Post.dart';
import 'package:Makulay/models/PostStatus.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Makulay/models/ModelProvider.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({Key? key}) : super(key: key);

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> with AutomaticKeepAliveClientMixin<InterestsPage>{
 
  late final Function onIconTap;
  late Future<List<Post?>> _posts;
  List<Widget> allPosts = [];
  bool _isSynced = false;
  bool _listeningToHub = true;
  late StreamSubscription<DataStoreHubEvent> hubSubscription;
  List<String> _postStreamingData = <String>[];
  late Stream<SubscriptionEvent<Post>> postStream;
  final _scrollController = ScrollController();
  static final customCacheManager = CacheManager(Config('customCacheKey',
    stalePeriod: const Duration(days: 15),maxNrOfCacheObjects: 100,));
  

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
    final imageProvider = CachedNetworkImageProvider(imageUrl, cacheKey: key, cacheManager: customCacheManager);
    precacheImage(imageProvider, context);
    //_preloadedImages.add(imageProvider);
  }

  
  Future<void> getPost() async {
    String postId = '13780803-626c-4965-83fc-031659318725';
    var postData = getPostByPostId(postId);
    safePrint('Jammy Response: $postData');
  }

  Future<List<Widget>> fetchAllPosts() async {
    try {
      final request = ModelQueries.list(Post.classType);
      final response = await Amplify.API.query(request: request).response;
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
        debugPrint('eachPosts');
        debugPrint(eachPosts.toString());
        
        String description = eachPosts!.description;
        String? orientation = eachPosts.orientation;
        String? contenttype = eachPosts.contenttype;
        String? username = eachPosts.user!.username;
        String? profilepicture = eachPosts.user!.profilePicture;
        String profilepictureUrl ='';
        getFileUrl(profilepicture.toString()).then((value) {
            profilepictureUrl = value;
        });
        String? content = eachPosts.content;
        Map<String, String> contentList = {};
        if(content != '' && content != "null" && content != null){
          
          getFileUrl(content.toString()).then((value) {
            //_precacheImage(value, content);
            contentList[content] = value;

            if(orientation == 'vertical'){
            if(contenttype == 'image'){
              setState(() {
                allPosts.add(PostCard('image-Vertical', description, contentList, username, profilepictureUrl ));
              });
            }else{
              setState(() {
                allPosts.add(PostCard('video-Vertical', description, contentList, username, profilepictureUrl));
              });
            }
          }else{
            if(contenttype == 'image'){
              setState(() {
                allPosts.add(PostCard('image-Horizontal', description, contentList, username, profilepictureUrl));
              });
            }else{
              setState(() {
                allPosts.add(PostCard('video-Horizontal', description, contentList, username, profilepictureUrl));
              });
            }
          }
          });
          
        }else{ //if S3 data == null == Text Post
          setState(() {
            allPosts.add(PostCard('textPost', description, {}, username, profilepictureUrl));
          });
        }
      }
      
      return allPosts;
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
      return const [];
    }
  }

  _pageView(List myList) {
    return ListView.builder(
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

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    fetchAllPosts().then((value) => {
      debugPrint(value.toString()),
      debugPrint('allPosts')
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    //items.add((items.length+1).toString());
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    //_scrollController = ScrollController();
    //_tabController = TabController(vsync: this, length: 5);
    
    super.initState();
    /*_scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
// scroll has reach end, now load more images.
            loadMore();
          }
        });*/
    

    debugPrint('fetchAllPosts');
    if(!Amplify.isConfigured){
      debugPrint('not yet configured!!!');
    }
    fetchAllPosts().then((value) => {
      //debugPrint(value.toString()),
      debugPrint('allPosts')
    });
//getAllPosts();
    //getPost();
    
    
    debugPrint('ulala');
    //debugPrint(_postStreamingData.toString());
  }

 

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Container(
      child: Column(
        children: [
          Expanded(child: SmartRefresher(
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
        child:_pageView(allPosts)
          ))
        ],
      ),
    );
  }

   @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
