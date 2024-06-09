import 'package:Makulay/models/Model_Series.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_widgets/series.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ChatPage(this.cameras, {Key? key}) : super(key: key);

  @override
  MessageUsersListScreen createState() => MessageUsersListScreen();
}

class MessageUsersListScreen extends State<ChatPage> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    final isLoggedIn = await isUserLoggedIn();
    setState(() {
      userIsLoggedIn = isLoggedIn;
    });
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final authUser = await Amplify.Auth.getCurrentUser();

      if (authUser != null) {
        return true; // A user is logged in
      } else {
        return false; // No user is logged in
      }
    } catch (e) {
      print('Error checking if a user is logged in: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return userIsLoggedIn ? MessageUsersList() : Login(widget.cameras);
  }
}

class MessageUsersList extends StatelessWidget {
  final _scrollController2 = ScrollController();
  final List<SeriesModel> seriesList = [
    /*SeriesModel(
        media: 'assets/series_cover.jpg', username: 'John', series_cover: true),*/
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'marciusjam', profilepicture: 'assets/profile-jam.jpg'),
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'shayecrispo', profilepicture: 'assets/profile-shaye.jpg'),
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'Sasuke', profilepicture: 'assets/profile-shaye.jpg'),
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'Goku', profilepicture: 'assets/profile-shaye.jpg'),
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'Luffy', profilepicture: 'assets/profile-shaye.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              //statusBarColor: Colors.black,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Icon(Icons.arrow_back_ios, color: Colors.white,),
            ),
          ),
          actions: <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
          Icons.qr_code_2_rounded,
          size: 30.0,
          color: Colors.white,
        ),
      )
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {},
        child: Icon(
            Icons.settings,
            size: 30.0,
            color: Colors.white,
        ),
      )
    ),
  ],
        ),
        body:*/
        Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            width: double.maxFinite,
            child: Container(
                child: Column(children: [
              /*Container(
                padding: new EdgeInsets.fromLTRB(3, 0, 3, 0),
                height: 515,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController2,
                  padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemBuilder: (BuildContext context, int index) {
                    return /*index == 0 ? Container(width: (MediaQuery.of(context).size.width) -60, child: ,)  :*/
                    Series(
                        seriesList: seriesList[index], indexLine: index, username: 'marciusjam', profilepicture: '', 2); //),
                  },
                )),*/
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 5),
                child: Row(
                  children: [
                    Text(
                      'Favorites',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      'Others',
                      style: TextStyle(fontSize: 15, color: Colors.amber),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 200,
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: _users.length,
                    itemBuilder: (context, i1index) {
                      final user = _users[i1index];
                      return MessageUserItem(user: user);
                    },
                  )),

              /*Container(padding: EdgeInsets.fromLTRB(5, 0, 5, 0) , child: Row(children: [
            Text('Contacts', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
        
        Spacer(),
        //Text('See more', style: TextStyle(fontSize: 15, color: Colors.amber),),

          ],),),
          Container(height:200 ,child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemCount: _users.length,
      itemBuilder: (context, i2ndex) {
        final user = _contacts[i2ndex];
        return ContactsItem(user: user);
      },)) */
            ])));
  }
}

class MessageUserItem extends StatelessWidget {
  final ChatUsers user;

  MessageUserItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      leading: CircleAvatar(
        radius: 28.0,
        // You can set the user's profile picture here.
        backgroundImage: AssetImage(user.profilePicture),
      ),
      title: Text(
        user.username,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(
        user.lastMessage,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Text(
        user.timestamp,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ContactsItem extends StatelessWidget {
  final Contacts user;

  ContactsItem({required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      leading: CircleAvatar(
        radius: 28.0,
        // You can set the user's profile picture here.
        backgroundImage: AssetImage(user.profilePicture),
      ),
      title: Text(
        user.username,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class ChatUsers {
  final String username;
  final String profilePicture;
  final String lastMessage;
  final String timestamp;

  ChatUsers({
    required this.username,
    required this.profilePicture,
    required this.lastMessage,
    required this.timestamp,
  });
}

class Contacts {
  final String username;
  final String profilePicture;

  Contacts({
    required this.username,
    required this.profilePicture,
  });
}

// Sample user data
final List<ChatUsers> _users = [
  ChatUsers(
    username: 'user1',
    profilePicture: 'assets/story_image_2.jpg',
    lastMessage: 'Hello there!',
    timestamp: '2h ago',
  ),
  ChatUsers(
    username: 'user2',
    profilePicture: 'assets/story_image_4.jpg',
    lastMessage: 'Hi!',
    timestamp: '4h ago',
  ),
  ChatUsers(
    username: 'user3',
    profilePicture: 'assets/story_image_5.jpg',
    lastMessage: 'How are you?',
    timestamp: '1d ago',
  ),
  // Add more users as needed
];

final List<Contacts> _contacts = [
  Contacts(
    username: 'user1',
    profilePicture: 'assets/story_image_2.jpg',
  ),
  Contacts(
    username: 'user2',
    profilePicture: 'assets/story_image_4.jpg',
  ),
  Contacts(
    username: 'user3',
    profilePicture: 'assets/story_image_5.jpg',
  ),
  // Add more users as needed
];
