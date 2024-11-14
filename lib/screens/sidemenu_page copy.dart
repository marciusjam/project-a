import 'package:Makulay/main.dart';
import 'package:Makulay/models/Model_Series.dart';
import 'package:Makulay/navigation_container.dart';
import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_card.dart';
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
  final List<CameraDescription> cameras;

  const SideMenuPage(this.cameras, {Key? key}) : super(key: key);

  @override
  State<SideMenuPage> createState() => _SideMenuPageState();
}

class _SideMenuPageState extends State<SideMenuPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SideMenuPage> {
  var _scrollController;
  late final Function onIconTap;

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
    Favorites("private", ['shayecrispo'], 'shayecrispo',
        ['assets/profile-shaye.jpg'], ['assets/series_3.mp4',], true),
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
        ], true),
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
        [], true),
    Favorites(
        "private",
        ['cloudy'],
        'cloudy',
        ['assets/story_image_4.jpg'],
        [
          
        ], false),
    Favorites(
        "private",
        ['ja'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ], false),
        Favorites(
        "private",
        ['mac'],
        'macmac',
        ['assets/story_image_4.jpg'],
        [
          
        ], false),
    Favorites(
        "private",
        ['jr'],
        'jr',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ], false),
        Favorites(
        "private",
        ['mac'],
        'macmac',
        ['assets/story_image_4.jpg'],
        [
          
        ], false),
    Favorites(
        "private",
        ['kc'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ], false),
        Favorites(
        "private",
        ['tim'],
        'macmac',
        ['assets/story_image_4.jpg'],
        [
          
        ], false),
    Favorites(
        "private",
        ['nj'],
        'jamaria',
        ['assets/story_image_2.jpg'],
        [
          'assets/series_4.mp4',
        ], false),
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

  @override
  Widget build(BuildContext context) {
    return //==Padding(padding: EdgeInsets.fromLTRB(30,0,30,30), child:

        SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      //controller: _scrollController,
      child: Column(children: [
        /*Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  'My Faves',
                  style: TextStyle(
                    height: 1.2,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              //Spacer(),
              
              /*Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child: Icon(Icons.dynamic_feed,
                          size: 27.0, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(17, 0, 10, 0),
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
                  )
                ],
              ),*/
              
              /*Padding(padding: EdgeInsets.fromLTRB(0, 7, 0, 0), child: 
              Icon(Icons.people_alt_rounded, size: 27,)
              Text(
                'Others',
                style: TextStyle(fontSize: 15, color: Colors.amber, fontWeight: FontWeight.bold,),
              ),),*/
            ],
          ),
        ),
        */
        Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    padding: EdgeInsets.fromLTRB(0, 13, 10, 0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ActivitiesPage()),
                        )
                      },
                      child:
                          Icon(Icons.people, size: 28.0, color: Colors.black),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 13, 10, 0),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivitiesPage()),
                            )
                          },
                          child:
                              Icon(Icons.call, size: 27.0, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(13, 5, 15, 0),
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
                              size: 27.0, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(22, 5, 15, 0),
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
                ])),

        Container(
            child: ListView.builder(
                itemCount: faves.length,
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) => 
                    
                    Container(
                                color: Colors.white,
                                height:90, 
            child: ListView.builder(
                itemCount: faves[index].series.length +
                                      2, // Adjust the number of horizontal items as nReeded
                                  
                shrinkWrap: true,
                padding:  EdgeInsets.fromLTRB(0, 0, 0, 0),
                                   
                //physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int seriesindex) =>
                seriesindex == 0 ?
                Container(
                  width: MediaQuery.sizeOf(context).width - 50,
                  child:
                    Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 10, 20),
                        child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            shape: new RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: Colors.grey.shade300, width: .3),
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(5.0)),
                            ),
                            color: Colors.white,
                            elevation: 0,
                            surfaceTintColor: Colors.white,
                            child: Column(children: [
                              faves[index].chatType != 'group'
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(children: [
                                        Stack(children: [Container(
                                          height: 70,
                                          width: 70,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(
                                            image: AssetImage(
                                                faves[index].profilepicture[0]),
                                            fit: BoxFit.cover,
                                          ),
                                         
                                        ),
                                        if(faves[index].favorite)
                                        Positioned(
                                          top:3,
                                          left: 3,
                                          child: Container(
                                          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle
          ),
          child:
                                        Icon(Icons.favorite, size: 10, color: Colors.white)))
                                        
                                        ],),
                                        
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 5, 0),
                                                    child: Text(
                                                      faves[index].chatType ==
                                                              'group'
                                                          ? faves[index]
                                                              .chatName
                                                          : faves[index]
                                                              .users[0],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Feeling crazy today! 🤪',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'Hello Musta?',
                                                style: TextStyle(
                                                    color: index < 1
                                                        ? Colors.black
                                                        : Colors.grey,
                                                    fontSize: 13,
                                                    fontWeight: index < 1
                                                        ? FontWeight.bold
                                                        : null),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 5, 0),
                                                child: Text(
                                                  '2hr ago',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      
                                      

                                        /*Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: .5),
                                          shape: BoxShape.rectangle,
                                          // You can use like this way or like the below line
                                          borderRadius: new BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(faves[index]
                                                .profilepicture
                                                .length
                                                .toString()),
                                          ],
                                        ),
                                      ),*/

                                        /*Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: index < 1 ? Colors.amber : Colors.grey.shade300),
              shape: BoxShape.rectangle,
              // You can use like this way or like the below line
              borderRadius: new BorderRadius.all(Radius.circular(10)),
              /*gradient: LinearGradient(
                                                    begin:
                                                        Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.yellow.shade700,
                                                      Colors.yellow.shade900,
                                                    ],
                                                  ),*/
              color: Colors.white,
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(faves[index].profilepicture.length.toString(), style: TextStyle(color: Colors.black),),
              ],
            ),
          ),),*/

                                        /*Icon(
                                      Icons.menu_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),*/
                                      ]),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            /*Padding(
                                      padding:
                                          //faves[index].chatType == 'group'
                                          //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                          //:
                                          EdgeInsets.fromLTRB(0, 0, 10, 0),
                                      child: SizedBox(
                                        width: 45,
                                        height: 45,
                                        child: InkWell(
                                          onTap: () => {},
                                          child: Container(
                                            height: 45,
                                            width: 45,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Container(
                                                height: 40,
                                                width: 40,
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
                                    ),*/
                                            Stack(children: [Container(
                                          height: 70,
                                          width: 70,
                                          padding: EdgeInsets.only(right: 10),
                                          child: Image(
                                            image: AssetImage(
                                                faves[index].profilepicture[0]),
                                            fit: BoxFit.cover,
                                          ),
                                         
                                        ),
                                        if(faves[index].favorite)
                                        Positioned(
                                          top:3,
                                          left: 3,
                                          child: Container(
                                          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle
          ),
          child:
                                        Icon(Icons.favorite, size: 10, color: Colors.white)))
                                        
                                        ],),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        faves[index].chatType ==
                                                                'group'
                                                            ? faves[index]
                                                                .chatName
                                                            : faves[index]
                                                                .users[0],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    'marciusjam: Hello Musta? HAHAHA',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Text(
                                                      '2hr ago',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  )

                                                  /*Container(
                                      height: 65, // Adjust the height as needed
                                      width: MediaQuery.sizeOf(context).width / 1.5 - 15 ,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: ListView.builder(
                                        
                                        itemCount:
                                            faves[index].profilepicture.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context,
                                                int profileindex) =>
                                            Padding(
                                          padding:
                                              //faves[index].chatType == 'group'
                                              //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                              //:
                                              EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: SizedBox(
                                            width: 45,
                                            height: 45,
                                            child: InkWell(
                                              onTap: () => {},
                                              child: Container(
                                                height: 45,
                                                width: 45,
                                                child: CircleAvatar(
                                                  backgroundColor: profileindex <= 2 ?Colors.amber : Colors.grey.shade300,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage:
                                                          AssetImage(faves[
                                                                      index]
                                                                  .profilepicture[
                                                              profileindex]),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),*/
                                                ],
                                              ),
                                            ),
                                            /*Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: index > 1 ? Colors.amber : Colors.grey.shade300),
              shape: BoxShape.rectangle,
              // You can use like this way or like the below line
              borderRadius: new BorderRadius.all(Radius.circular(10)),
              /*gradient: LinearGradient(
                                                    begin:
                                                        Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                    colors: [
                                                      Colors.white,
                                                      Colors.yellow.shade700,
                                                      Colors.yellow.shade900,
                                                    ],
                                                  ),*/
              color: Colors.white,
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(faves[index].profilepicture.length.toString(), style: TextStyle(color: Colors.black),),
              ],
            ),
          ),),*/
                                            

                                            /* Icon(
                                      Icons.menu_rounded,
                                      color: Colors.black,
                                      size: 30,
                                    ),*/
                                          ]),
                                        ],
                                      )),

                              // Add more vertical items with horizontal ListViews.builder as needed
                              //MediaQuery.sizeOf(context).width /2
                              //index + 1 != faves.length ?
                            ]
                                //),
                                )))) : seriesindex == faves[index].series.length + 1
                                       ?
                                       Padding(padding: EdgeInsets.fromLTRB(
                                                    0, 0, 20, 20), child: Container(
                                                  width: 40,
                                                  decoration: BoxDecoration(
            border: Border.all(width: .5, color: Colors.grey.shade300),
            shape: BoxShape.rectangle,
            // You can use like this way or like the below line
            borderRadius: new BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
          ),
                                                  child: Center(child: Icon(Icons.add, size: 20, color: Colors.grey.shade900,))))
                                : Padding(padding: EdgeInsets.fromLTRB(
                                                    0, 0, 10, 0), child: Container(
                                                  
                                                  width: 39,
                                                  child: CustomVideoPlayer(
                                                      'fade',
                                                      faves[index].series[
                                                        seriesindex - 1],
                                                      9 / 16,
                                                      'description',
                                                      'username',
                                                      'profilepicture',
                                                      2,
                                                      null, false, null, '20', '30', '50'))
                                      
                                              
                    
                    ))
                    )),
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
        )]),
    );
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
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 5, 0),
                                                    child: Text(
                                                      user.username,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
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
            style: TextStyle(color: Colors.grey,
                                                          fontSize: 13,
                                                          ),
          ),
          Text(
            user.timestamp,
            style: TextStyle(color: Colors.grey,
                                                          fontSize: 10,),
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
