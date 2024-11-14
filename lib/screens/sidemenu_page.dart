import 'package:Makulay/main.dart';
import 'package:Makulay/models/Model_Series.dart';
import 'package:Makulay/navigation_container.dart';
import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_stack/image_stack.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;

  NotificationItem(
      {required this.title, required this.message, required this.time});
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage(this.messageContent, this.messageType);
}

class Favorites {
  String chatType;
  List<String> users;
  String chatName;
  List<String> profilepicture;
  List<String> series;
  bool favorite;
  Favorites(this.chatType, this.users, this.chatName, this.profilepicture,
      this.series, this.favorite);
}

class SideMenuPage extends StatefulWidget {
  final Function onIconTap;
  final List<CameraDescription> cameras;
  final String profilepicture;
  final String username;
  final String userid;
  final int selectedPageIndex;

  const SideMenuPage(
      this.profilepicture, this.username, this.userid, this.cameras,
      {Key? key, required this.onIconTap, required this.selectedPageIndex})
      : super(key: key);

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SideMenuPage> {
  var _scrollController;

  String? _selectedItem1 = 'Favorites';
  final options = ['Favorites', 'Others', 'Requests'];
List<DropdownMenuItem<String>> _createList() {
  return options
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

  PageController pageController = PageController(initialPage: 0);

  _signOutAndNavigateToLogin(BuildContext context) async {
    try {
      await Amplify.Auth.signOut();
      // Navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(widget.cameras),
        ),
      );
    } catch (e) {
      print('Error during sign-out: $e');
    }
  }

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "New Message",
      message: "You have a new message from John Doe.",
      time: "9:00 AM",
    ),
    NotificationItem(
      title: "Reminder",
      message: "Don't forget to attend the meeting at 2:00 PM.",
      time: "10:30 AM",
    ),
    NotificationItem(
      title: "Update",
      message: "An update for the app is available. Please install it.",
      time: "12:15 PM",
    ),
  ];

  final List<SeriesModel> seriesList = [
    /*SeriesModel(
        media: 'assets/series_cover.jpg', username: 'John', series_cover: true),*/
    SeriesModel(
        media: [],
        username: 'marciusjam',
        profilepicture: 'assets/profile-jam.jpg'),
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
    ], username: 'Naruto', profilepicture: 'assets/story_image_2.jpg'),
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'Sasuke', profilepicture: 'assets/story_image_3.jpg'),
    SeriesModel(media: [
      'assets/series_1.mp4',
      'assets/series_2.mp4',
      'assets/series_3.mp4',
      'assets/series_4.mp4'
    ], username: 'Goku', profilepicture: 'assets/story_image_4.jpg'),
  ];

  List<Widget> list = [
    AspectRatio(
      aspectRatio: (9 / 16) * 3,
      child: Image.network(
          'https://terrigen-cdn-dev.marvel.com/content/prod/1x/axejudgement2022001_cover.jpg',
          //height: 200, //widget._tabController.index == 1 ? 16 : 12,
          //width: double.infinity, //widget._tabController.index == 1 ? 16 : 12,
          filterQuality: FilterQuality.medium,
          fit: BoxFit.cover),
    ),
  ];

  List<ChatMessage> messages = [
    ChatMessage("Hello, Will", "receiver"),
    ChatMessage("How have you been?", "receiver"),
    ChatMessage("Hey Kriss, I am doing fine dude. wbu?", "sender"),
    ChatMessage("ehhhh, doing OK.", "receiver"),
    ChatMessage("Is there any thing wrong?", "sender"),
    ChatMessage("Wala naman", "receiver"),
    ChatMessage("Parang ang angas mo ah", "receiver"),
    ChatMessage("Hindi naman po sir", "sender"),
    ChatMessage("Bat parang ang sungit mo sir", "sender"),
    ChatMessage("Hindi ganito lang ako", "receiver"),
    ChatMessage("Pasensya na po", "sender"),
    ChatMessage("Sige Ok lang", "receiver"),
  ];

  List<Favorites> faves = [
    Favorites(
        "private",
        ['shayecrispo'],
        'shayecrispo',
        ['assets/profile-shaye.jpg'],
        [
          'assets/series_3.mp4',
        ],
        true),
    Favorites(
        "group",
        ['franz', 'derick', 'kirk', 'ivan', 'paul', 'amiel'],
        'MWB',
        [
          'assets/story_image_5.jpg',
          'assets/profile-jam.jpg',
          'assets/story_image_2.jpg',
          'assets/story_image_3.jpg',
          'assets/story_image_4.jpg',
          'assets/story_image_5.jpg',
          'assets/story_image_2.jpg',
          'assets/story_image_3.jpg',
          'assets/story_image_4.jpg',
          'assets/story_image_5.jpg',
        ],
        [
          'assets/series_1.mp4',
          'assets/series_2.mp4',
          'assets/series_3.mp4',
          'assets/series_4.mp4'
        ],
        true),
    Favorites(
        "group",
        ['dileth', 'jojie', 'ja', 'mac', 'shayecrispo'],
        'Jojie Family',
        [
          'assets/grid_image_2.png',
          'assets/profile-jam.jpg',
          'assets/story_image_2.jpg',
          'assets/story_image_3.jpg',
          'assets/story_image_4.jpg',
          'assets/story_image_5.jpg'
        ],
        [],
        true),
  ];

  List<Favorites> nonfaves = [
    Favorites("private", ['cloudy'], 'cloudy', ['assets/story_image_4.jpg'], [],
        false),
    Favorites(
        "private",
        ['ja'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
    Favorites(
        "private", ['ash'], 'macmac', ['assets/story_image_4.jpg'], [], false),
    Favorites(
        "private",
        ['jr'],
        'jr',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
    Favorites(
        "private", ['mac'], 'macmac', ['assets/story_image_4.jpg'], [], false),
    Favorites(
        "private",
        ['kc'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
    Favorites(
        "private", ['tim'], 'macmac', ['assets/story_image_4.jpg'], [], false),
    Favorites(
        "private",
        ['nj'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
        Favorites(
        "private", ['tim'], 'macmac', ['assets/story_image_4.jpg'], [], false),
    Favorites(
        "private",
        ['nj'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
        Favorites(
        "private", ['tim'], 'macmac', ['assets/story_image_4.jpg'], [], false),
    Favorites(
        "private",
        ['nj'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
        Favorites(
        "private", ['tim'], 'macmac', ['assets/story_image_4.jpg'], [], false),
    Favorites(
        "private",
        ['nj'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ],
        false),
  ];

  _notificationList(List myList) {
    return ListView.builder(
      itemCount: notifications.length,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(notifications[index].title),
          subtitle: Text(notifications[index].message),
          trailing: Text(notifications[index].time),
        );
      },
    );
  }



  @override
  void initState() {
    _scrollController = ScrollController();
    //_tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  Widget navHeader(BuildContext context) {
    return 
   Container(
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
              ),),
              Row(children: [
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
                          child:
                              Icon(Icons.call, size: 27.0, color: Colors.grey.shade900),
                        ),
                      ),
                      Padding(
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
                      )
                    ],
                  ),
                  /*Padding(
                    padding: EdgeInsets.fromLTRB(0, 13, 10, 0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child: Icon(Icons.add, size: 28.0, color: Colors.black),
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
                          child: Icon(Icons.mark_as_unread_rounded,
                              size: 27.0, color: Colors.grey.shade900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22, 5, 0, 0),
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
              ],),
              
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

  void _onRightSwipe(int index) {
    int finalIndex = index;
    widget.onIconTap(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + finalIndex.toString());
  }


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
    return //==Padding(padding: EdgeInsets.fromLTRB(30,0,30,30), child:
 GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
    if (dragEndDetails.primaryVelocity! > 0 ) {
      Navigator.push(
                            context,
      _routeToNewPost()
      );
    }else{
      _onRightSwipe(1);
    } },
      child: 
    
    
        SingleChildScrollView(
      //physics: const NeverScrollableScrollPhysics(),
      //controller: _scrollController,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
           //SizedBox(height: 40,),


          

            /*Container(
            padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  /*Padding(
                        padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivitiesPage()),
                            )
                          },
                          child: Icon(Icons.qr_code_2_rounded,
                              size: 28.0, color: Colors.grey.shade900),
                        ),
                      ),*/
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
                          Icon(Icons.people, size: 28.0, color: Colors.grey.shade900),
                    ),
                  ),
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
                          child:
                              Icon(Icons.call, size: 27.0, color: Colors.grey.shade900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(13, 5, 0, 0),
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
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child: Icon(Icons.add, size: 28.0, color: Colors.black),
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
                          child: Icon(Icons.mark_as_unread_rounded,
                              size: 27.0, color: Colors.grey.shade900),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22, 5, 0, 0),
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
                ])),*/
            
            //navHeader(context),

            Container(
                child: ListView.builder(
                    itemCount: faves.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Container(
                        color: Colors.white,
                        height: 80,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: faves[index].series.isNotEmpty
                                      ? MediaQuery.sizeOf(context).width - 5
                                      : MediaQuery.sizeOf(context).width - 5,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 0, 5, 10),
                                      child: /*Card(
                                          margin: EdgeInsets.zero,
                                          clipBehavior: Clip.antiAlias,
                                          shape: new RoundedRectangleBorder(
                                            side: new BorderSide(
                                                color: Colors.grey.shade300,
                                                width: .3),
                                            borderRadius: new BorderRadius.all(
                                                const Radius.circular(5.0)),
                                          ),
                                          color: Colors.white,
                                          elevation: 0,
                                          surfaceTintColor: Colors.white,
                                          child: */Column(children: [
                                            faves[index].chatType != 'group'
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                      /*Stack(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: 70,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  faves[index]
                                                                      .profilepicture[0]),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          if (faves[index]
                                                              .favorite)
                                                            Positioned(
                                                                top: 3,
                                                                left: 3,
                                                                child: Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                3),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .amber,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        size:
                                                                            10,
                                                                        color: Colors
                                                                            .white)))
                                                        ],
                                                      ),*/
                                                      Stack(
                                                            children: [
                                                              
                                                          Container(
                                      padding:
                                          //faves[index].chatType == 'group'
                                          //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                          //:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: InkWell(
                                          onTap: () => {},
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(
                                                      faves[index]
                                                          .profilepicture[0]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                    /*Positioned(
                                                                    top: 2,
                                                                    left: 2,
                                                                    child:
                                                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child:Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                3),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .amber,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        size:
                                                                            10,
                                                                        color: Colors
                                                                            .white)),),),*/
                                                            ]),

                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 7, 0, 0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    faves[index].chatType ==
                                                                            'group'
                                                                        ? faves[index]
                                                                            .chatName
                                                                        : faves[index]
                                                                            .users[0],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            5,
                                                                            0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .verified,
                                                                      size: 16,
                                                                      color: Colors
                                                                          .amber,
                                                                    )),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    '•',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Feeling crazy today! 🤪',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              'Hello Musta?',
                                                              style: TextStyle(
                                                                  color: index <
                                                                          1
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                                  fontSize: 14,
                                                                  fontWeight: index <
                                                                          1
                                                                      ? FontWeight
                                                                          .bold
                                                                      : null),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                              child: Text(
                                                                '2hr ago',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),

                                                      Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
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
                          ),
                                                    ]),
                                                  )
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                          /*Stack(
                                                            children: [
                                                              Container(
                                                                height: 70,
                                                                width: 70,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      faves[index]
                                                                          .profilepicture[0]),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              if (faves[index]
                                                                  .favorite)
                                                                Positioned(
                                                                    top: 3,
                                                                    left: 3,
                                                                    child: Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                3),
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .amber,
                                                                            shape: BoxShape
                                                                                .circle),
                                                                        child: Icon(
                                                                            Icons
                                                                                .favorite,
                                                                            size:
                                                                                10,
                                                                            color:
                                                                                Colors.white)))
                                                            ],
                                                          ),*/
                                                          Stack(
                                                            children: [
                                                              
                                                          Container(
                                      padding:
                                          //faves[index].chatType == 'group'
                                          //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                          //:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: InkWell(
                                          onTap: () => {},
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(
                                                      faves[index]
                                                          .profilepicture[4]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                    /*Positioned(
                                                                    top: 2,
                                                                    left: 2,
                                                                    child:
                                                          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child:Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                3),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .amber,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        size:
                                                                            10,
                                                                        color: Colors
                                                                            .white)),),),*/
                                                            ]),


                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 7, 0, 0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        faves[index].chatType ==
                                                                                'group'
                                                                            ? faves[index].chatName
                                                                            : faves[index].users[0],
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        '•',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Happy Birthday Jam! 🥳',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  'marciusjam: Hello Musta? HAHAHA',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '2hr ago',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
                            child: Stack(
                              children: <Widget>[
                                Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.amber),
                                Positioned(
                                    top: 3.0,
                                    left: 7.0,
                                    child: Center(
                                      child: Text(
                                        '3',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                                                        ]),
                                                      ],
                                                    )),
                                          ]
                                              //),
                                              ))
                                              //)
                                              ),
                              /*faves[index].series.isNotEmpty
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 10, 10),
                                      child: Container(
                                          width: 38,
                                          child: CustomVideoPlayer(
                                              'fade',
                                              faves[index].series[0],
                                              9 / 16,
                                              'description',
                                              'username',
                                              'profilepicture',
                                              2,
                                              null,
                                              false)))
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 10, 10),
                                      child: Container(
                                          width: 38,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: .5,
                                                color: Colors.grey.shade300),
                                            shape: BoxShape.rectangle,
                                            // You can use like this way or like the below line
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                              child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.black,
                                          ))))*/
                            ])))),

            //Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20)),
            /*Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 10), child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
        Text(
                                                    '•',
                                                    style: TextStyle(
                                                      color: Colors.grey.shade400,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold
                                                    ),)
                                                 
        //Divider(thickness: 1, color: Colors.grey.shade100,)
        ],)
        ),*/
            //Container( width: MediaQuery.sizeOf(context).width /2, padding: EdgeInsets.fromLTRB(0, 0, 0, 8), child: Divider(thickness: .3, color: Colors.grey.shade300,),),

            Container(
                child: ListView.builder(
                    itemCount: nonfaves.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Container(
                        color: Colors.white,
                        height: 80,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: nonfaves[index].series.isNotEmpty
                                      ? MediaQuery.sizeOf(context).width -5
                                      : MediaQuery.sizeOf(context).width -5,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 0, 5, 10),
                                      child: /*Card(
                                          margin: EdgeInsets.zero,
                                          clipBehavior: Clip.antiAlias,
                                          shape: new RoundedRectangleBorder(
                                            side: new BorderSide(
                                                color: Colors.grey.shade300,
                                                width: .3),
                                            borderRadius: new BorderRadius.all(
                                                const Radius.circular(5.0)),
                                          ),
                                          color: Colors.white,
                                          elevation: 0,
                                          surfaceTintColor: Colors.white,
                                          child:*/ Column(children: [
                                            nonfaves[index].chatType != 'group'
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Row(children: [
                                                      /*Stack(
                                                        children: [
                                                          Container(
                                                            height: 70,
                                                            width: 70,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  nonfaves[
                                                                          index]
                                                                      .profilepicture[0]),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          if (nonfaves[index]
                                                              .favorite)
                                                            Positioned(
                                                                top: 3,
                                                                left: 3,
                                                                child: Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                                3),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .black,
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child: Icon(
                                                                        Icons
                                                                            .favorite,
                                                                        size:
                                                                            10,
                                                                        color: Colors
                                                                            .white)))
                                                        ],
                                                      ),*/
                                                      
                                                      Container(
                                          
                                      padding:
                                          //faves[index].chatType == 'group'
                                          //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                          //:
                                          EdgeInsets.fromLTRB(10, 10, 10, 0),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: InkWell(
                                          onTap: () => {},
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: AssetImage(
                                                      nonfaves[index]
                                                          .profilepicture[0]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 7, 0, 0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    nonfaves[index].chatType ==
                                                                            'group'
                                                                        ? nonfaves[index]
                                                                            .chatName
                                                                        : nonfaves[index]
                                                                            .users[0],
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                                  child: Text(
                                                                    '•',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Feeling crazy today! 🤪',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(
                                                              'Hello Musta?',
                                                              style: TextStyle(
                                                                  color: index <
                                                                          1
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .grey,
                                                                  fontSize: 14,
                                                                  fontWeight: index <
                                                                          1
                                                                      ? FontWeight
                                                                          .bold
                                                                      : null),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          5,
                                                                          0),
                                                              child: Text(
                                                                '2hr ago',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 11,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 5, 0),
                            child: Stack(
                              children: <Widget>[
                                Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.amber),
                                Positioned(
                                    top: 3.0,
                                    left: 7.0,
                                    child: Center(
                                      child: Text(
                                        '1',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                                                    ]),
                                                  )
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Column(
                                                      children: [
                                                        Row(children: [
                                                          Stack(
                                                            children: [
                                                              Container(
                                                                height: 70,
                                                                width: 70,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Image(
                                                                  image: AssetImage(
                                                                      nonfaves[
                                                                              index]
                                                                          .profilepicture[0]),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                              if (nonfaves[
                                                                      index]
                                                                  .favorite)
                                                                Positioned(
                                                                    top: 3,
                                                                    left: 3,
                                                                    child: Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                3),
                                                                        decoration: BoxDecoration(
                                                                            color: Colors
                                                                                .black,
                                                                            shape: BoxShape
                                                                                .circle),
                                                                        child: Icon(
                                                                            Icons
                                                                                .favorite,
                                                                            size:
                                                                                10,
                                                                            color:
                                                                                Colors.white)))
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 0),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        nonfaves[index].chatType ==
                                                                                'group'
                                                                            ? nonfaves[index].chatName
                                                                            : nonfaves[index].users[0],
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              0,
                                                                              5,
                                                                              0),
                                                                      child:
                                                                          Text(
                                                                        '•',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Happy Birthday Jam! 🥳',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  'marciusjam: Hello Musta? HAHAHA',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    '2hr ago',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          11,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),

Spacer(),
                                                      Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                            child: Stack(
                              children: <Widget>[
                                Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.amber),
                                Positioned(
                                    top: 3.0,
                                    left: 7.0,
                                    child: Center(
                                      child: Text(
                                        '6',
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            ),
                          ),

                                                        ]),
                                                      ],
                                                    )),
                                          ]
                                              //),
                                              ))
                                              //)
                                              ),
                              /*nonfaves[index].series.isNotEmpty
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 10, 10),
                                      child: Container(
                                          width: 38,
                                          child: CustomVideoPlayer(
                                              'fade',
                                              nonfaves[index].series[0],
                                              9 / 16,
                                              'description',
                                              'username',
                                              'profilepicture',
                                              2,
                                              null,
                                              false)))
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 0, 10, 10),
                                      child: Container(
                                          width: 38,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: .5,
                                                color: Colors.grey.shade300),
                                            shape: BoxShape.rectangle,
                                            // You can use like this way or like the below line
                                            borderRadius: new BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                              child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.black,
                                          ))))*/
                                          
                            ])))),
            /*Padding(padding: EdgeInsets.fromLTRB(80, 5, 80, 0), child: Divider(thickness: 1, color: Colors.grey.shade200,),),

        Container(
            height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              itemCount: _users.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i1index) =>
              Column(children:[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: MessageUserItem(user: _users[i1index]),
                ),
                Padding(padding: EdgeInsets.fromLTRB(80, 0, 80, 0), child: Divider(thickness: 1, color: Colors.grey.shade200,),),
              
              ])
                
            )),*/
          ]),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ChatUsers {
  final String username;
  final String profilePicture;
  final String status;
  final String lastMessage;
  final String timestamp;

  ChatUsers({
    required this.username,
    required this.profilePicture,
    required this.status,
    required this.lastMessage,
    required this.timestamp,
  });
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
      leading: SizedBox(
        width: 45,
        height: 45,
        child: InkWell(
          onTap: () => {},
          child: Container(
            height: 45,
            width: 45,
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Container(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(user.profilePicture),
                ),
              ),
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: Text(
              user.username,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            user.status,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.lastMessage,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          Text(
            user.timestamp,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
      trailing: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(width: .5, color: Colors.amber),
            shape: BoxShape.rectangle,
            // You can use like this way or like the below line
            borderRadius: new BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('2'),
            ],
          ),
        ),
      ),
    );
  }
}

final List<ChatUsers> _users = [
  ChatUsers(
    username: 'jorge',
    profilePicture: 'assets/story_image_2.jpg',
    status: 'Looking to play golf today!',
    lastMessage: 'Hoy!',
    timestamp: '2h',
  ),
  ChatUsers(
    username: 'cloudyboy',
    profilePicture: 'assets/story_image_4.jpg',
    status: 'Chilling on my bed 😴',
    lastMessage: 'Arfffff',
    timestamp: '4h',
  ),
  ChatUsers(
    username: 'skyegirl',
    profilePicture: 'assets/story_image_5.jpg',
    status: 'IM SCARED!!!',
    lastMessage: 'Bowwowww',
    timestamp: '1d',
  ),
  // Add more users as needed
];
