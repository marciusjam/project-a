import 'dart:async';

import 'package:agilay/models/Post.dart';
import 'package:agilay/models/PostStatus.dart';
import 'package:agilay/widgets/home_bar.dart';
import 'package:agilay/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';

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
  List<Post> _posts = [];
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
    PostCard('textPost'),
    PostCard('series'),
    PostCard('image-Horizontal'),
    PostCard('image-Vertical'),
    PostCard('video-Horizontal'),
    PostCard('series'),
    PostCard('video-Vertical'),
    PostCard('textPost'),
  ];

  Future<void> fetchAllPosts() async {
    try {
      /*final postList = await Amplify.DataStore.observeQuery(Post.classType)
          .listen((QuerySnapshot<Post> snapshot) {
        setState(() {
          _posts = snapshot.items;
        });
      });*/
      /*try {
        await Amplify.DataStore.clear();
      } on Exception catch (error) {
        print('Error clearing DataStore: $error');
      }

      try {
        await Amplify.DataStore.start();
      } on Exception catch (error) {
        print('Error starting DataStore: $error');
      }*/

      /*await Amplify.DataStore.start();
      _stream = await Amplify.DataStore.observeQuery(Post.classType,
              where: Post.STATUS.eq(PostStatus.ACTIVE))
          .listen((QuerySnapshot<Post> snapshot) {
        setState(() {
          _posts = snapshot.items;
          _isSynced = snapshot.isSynced;
        });
      });*/

      postStream = Amplify.DataStore.observe(Post.classType);
      postStream.listen((event) {
        _postStreamingData.add('Post: ' +
            (event.eventType.toString() == EventType.delete.toString()
                ? event.item.id
                : event.item.description) +
            ', of type: ' +
            event.eventType.toString());
      }).onError((error) => print('haha $error'));
    } on DataStoreException catch (e) {
      safePrint('Something went wrong querying posts: ${e.message}');
    } catch (e) {
      print("Could not query DataStore: " + e.toString());
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
    fetchAllPosts();
    debugPrint('ulala');
    debugPrint(_postStreamingData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Switch(
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
          ),
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
          Expanded(child: _pageView(list))
        ],
      ),
    );
  }
}
