import 'dart:async';
import 'dart:convert';

import 'package:Makulay/models/Post.dart';
import 'package:Makulay/models/PostStatus.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Makulay/models/ModelProvider.dart';

class Story {
  final String imageUrl;
  final String username;

  Story({required this.imageUrl, required this.username});
}

class InterestsPage extends StatefulWidget {
  const InterestsPage({Key? key}) : super(key: key);

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  late final Function onIconTap;
  late Future<List<Post?>> _posts;
  List<Widget> allPosts = [];
  bool _isSynced = false;
  bool _listeningToHub = true;
  late StreamSubscription<DataStoreHubEvent> hubSubscription;
  List<String> _postStreamingData = <String>[];
  late Stream<SubscriptionEvent<Post>> postStream;
  void listenToHub() {
    setState(() {
      hubSubscription = Amplify.Hub.listen(HubChannel.DataStore, (msg) {
        print(msg.type);
        if (msg.type == DataStoreHubEventType.networkStatus) {
          print('Network status message: $msg');
          return;
        }
        //print(msg);
      });
      _listeningToHub = true;
    });
  }

  void stopListeningToHub() {
    hubSubscription.cancel();
    setState(() {
      _listeningToHub = false;
    });
  }

  final List<Story> stories = [
    Story(imageUrl: 'assets/story_image_1.jpg', username: 'John'),
    Story(imageUrl: 'assets/story_image_2.jpg', username: 'Naruto'),
    Story(imageUrl: 'assets/story_image_3.jpg', username: 'Sasuke'),
    Story(imageUrl: 'assets/story_image_4.jpg', username: 'Goku'),
    Story(imageUrl: 'assets/story_image_5.jpg', username: 'Luffy'),
  ];

  List<Widget> list = [
    /*AspectRatio(
      aspectRatio: (9 / 16) * 2,
      child: Image.network(
          'https://terrigen-cdn-dev.marvel.com/content/prod/1x/axejudgement2022001_cover.jpg',
          //height: 200, //widget._tabController.index == 1 ? 16 : 12,
          //width: double.infinity, //widget._tabController.index == 1 ? 16 : 12,
          filterQuality: FilterQuality.medium,
          fit: BoxFit.cover),
    ),*/
    PostCard('textPost', '', []),
    PostCard('series', '', []),
    PostCard('image-Horizontal', '', []),
    PostCard('image-Vertical', '', []),
    PostCard('video-Horizontal', '', []),
    PostCard('series', '', []),
    PostCard('video-Vertical', '', []),
    PostCard('textPost', '', []),
  ];

  Future<List<Widget>> fetchAllPosts() async {
    try {
      final request = ModelQueries.list(Post.classType);
      final response = await Amplify.API.query(request: request).response;
      debugPrint('response,data');
      debugPrint(response.data.toString());
      String? gatheredPosts = response.data?.items.toString().replaceAll("\n","");
      debugPrint('Posts: $gatheredPosts');

      if (gatheredPosts == null) {
        safePrint('errors: ${response.errors}');
        return const [];
      }

      List mainMap = json.decode(gatheredPosts);
      //List<Post> currentPosts = mainMap;
      List<String> contentList = [];

      for (var eachPosts in mainMap) {
        // do something
        //Map valueMap = json.decode(eachPosts.toString());
        debugPrint('eachPosts');
        debugPrint(eachPosts.toString());
        debugPrint(eachPosts['description']);
        debugPrint(eachPosts['content']);
        
        String description = eachPosts['description'];
        
        String content = eachPosts['content'];

        if(content != '' && content != "null" && content != null){
          contentList.add(content.toString());
          //var contentList = json.decode(content).cast<String>().toList();
          //if S3 data == photo > Check resolution > If vert == Image Vert
          //if S3 data == photo > Check resolution > If horiz == Image Horizontal
          //if S3 data == video > Check resolution > If vert == Video Horizontal
          //if S3 data == video > Check resolution > If horiz == Video Horizontal 
          //if S3 data == multiple vert videos == Series
          setState(() {
            allPosts.add(PostCard('image-Vertical', description, contentList));
          });
        }else{ //if S3 data == null == Text Post
          setState(() {
            allPosts.add(PostCard('textPost', description, []));
          });
        }

        
      }
      //debugPrint(allPosts.toString());
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

  _columnView() {
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
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 5);
    super.initState();
    listenToHub();
    debugPrint('fetchAllPosts');
    fetchAllPosts();
    debugPrint('allTodos');
    debugPrint(allPosts.toString());
    debugPrint('ulala');
    //debugPrint(_postStreamingData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /*Switch(
            value: _listeningToHub,
            onChanged: (value) {
              if (_listeningToHub) {
                stopListeningToHub();
              } else {
                listenToHub();
              }
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),*/
          /*Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 50, 0, 10),
                child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Interests",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    )),
              )
            ],
          ),*/
          Expanded(child: _pageView(allPosts))
        ],
      ),
    );
  }
}
