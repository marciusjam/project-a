import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Favorites {
  String chatType;
  List<String> users;
  String chatName;
  List<String> profilepicture;
  List<String> series;
  bool favorite;
  String newCount;
  Favorites(this.chatType, this.users, this.chatName, this.profilepicture,
      this.series, this.favorite, this.newCount);
}

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar(
    this.username,
    this.profilepicture,
    this.cameras, {
    Key? key,
  }) : super(key: key);
  final String username;
  final String profilepicture;
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    List<Favorites> faves = [
      Favorites(
          "private",
          ['shayecrispo'],
          'shayecrispo',
          ['assets/profile-shaye.jpg'],
          [
            'assets/series_3.mp4',
          ],
          true,
          '9'),
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
          true,
          '5'),
    ];
    List<Favorites> others = [
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
          true,
          '9'),
      Favorites(
          "group",
          ['dileth', 'jojie', 'ja', 'mac', 'shayecrispo'],
          'Jojie Family',
          [
            'assets/grid_image_3.png',
            'assets/profile-jam.jpg',
            'assets/story_image_2.jpg',
            'assets/story_image_3.jpg',
            'assets/story_image_4.jpg',
            'assets/story_image_5.jpg'
          ],
          [],
          true,
          '1'),
      Favorites(
          "group",
          ['dileth', 'jojie', 'ja', 'mac', 'shayecrispo'],
          'Jojie Family',
          [
            'assets/grid_image_1.png',
            'assets/profile-jam.jpg',
            'assets/story_image_2.jpg',
            'assets/story_image_3.jpg',
            'assets/story_image_4.jpg',
            'assets/story_image_5.jpg'
          ],
          [],
          true,
          '5'),
      Favorites(
          "group",
          ['dileth', 'jojie', 'ja', 'mac', 'shayecrispo'],
          'Jojie Family',
          [
            'assets/story_image_2.jpg',
            'assets/story_image_3.jpg',
            'assets/story_image_4.jpg',
            'assets/story_image_5.jpg'
          ],
          [],
          true,
          '7'),
      Favorites(
          "group",
          ['dileth', 'jojie', 'ja', 'mac', 'shayecrispo'],
          'Jojie Family',
          [
            'assets/story_image_5.jpg',
            'assets/profile-jam.jpg',
            'assets/story_image_2.jpg',
            'assets/story_image_3.jpg',
            'assets/story_image_4.jpg',
            'assets/story_image_5.jpg'
          ],
          [],
          true,
          '9'),
    ];

    final barHeight = MediaQuery.of(context).size.height * 0.05;
    //final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11);

    List<Widget> tabbarWidgets = [
      Container(
          height: 80,
          //width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(0, 0, 20, 25),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Container(
                  color: Color.fromRGBO(00, 00, 00, 0.5),
                  padding: EdgeInsets.fromLTRB(20, 0, 15, 0),
                  //width: MediaQuery.of(context).size.width,
                  child: Row(children: [
                    Container(
                        //width: MediaQuery.sizeOf(context).width - 145,
                        child: Row(
                      children: [
                        Container(
                          //width: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                  child: GestureDetector(
                                      onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActivitiesPage()),
                                            )
                                          },
                                      child: Image.asset(
                                        'assets/chat.png',
                                        height: 28,
                                        width: 28,
                                        filterQuality: FilterQuality.high,
                                        color: Colors.white,
                                      ))),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 20),
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

                        /*ListView.builder(
                                    itemCount: faves.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    //physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context,
                                            int index) =>*/
                        for (var faveuser in faves)
                          Stack(alignment: Alignment.center, children: [
                            Container(
                                padding:
                                    //faves[index].chatType == 'group'
                                    //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                    //:
                                    EdgeInsets.fromLTRB(5, 0, 20, 0),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: AssetImage(
                                          faveuser.profilepicture[0]),
                                    ),
                                    Positioned(
                                      bottom:
                                          2, // Position it at the bottom right corner
                                      right: 2,
                                      child: Container(
                                        width:
                                            7, // Size of the online indicator
                                        height: 7,
                                        decoration: BoxDecoration(
                                          //color: isOnline ? Colors.green : Colors.grey, // Green for online, grey for offline
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors
                                                .white, // Border color to separate from the avatar
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                              child: Stack(
                                children: <Widget>[
                                  Icon(Icons.brightness_1,
                                      size: 20.0, color: Colors.amber),
                                  Positioned(
                                      top: 3.0,
                                      left: 7.0,
                                      child: Center(
                                        child: Text(
                                          faveuser.newCount,
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ]), //),
                        /*Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text(
                            '•',
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),*/
                        /*ListView.builder(
                                    itemCount: others.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    //physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context,
                                            int index) =>*/
                        /*for (var otheruser in others)
                          Stack(alignment: Alignment.center, children: [
                            Container(
                              padding:
                                  //faves[index].chatType == 'group'
                                  //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                  //:
                                  EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: /*SizedBox(
                                width: 35,
                                height: 35,
                                child: InkWell(
                                  onTap: () => {},
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: */CircleAvatar(
                                          radius: 16,
                                          backgroundImage: AssetImage(
                                              otheruser.profilepicture[0]),
                                        ),
                                      /*),
                                    ),
                                  ),
                                ),
                              ),*/
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(25, 0, 0, 20),
                              child: Stack(
                                children: <Widget>[
                                  Icon(Icons.brightness_1,
                                      size: 20.0, color: Colors.amber),
                                  Positioned(
                                      top: 3.0,
                                      left: 7.0,
                                      child: Center(
                                        child: Text(
                                          otheruser.newCount,
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ],
                              ),
                            )
                          ]) //),
                      */
                      ],
                    ))
                  ]))))
    ];

    return Container(
        height: 85,
        //width:  100,
       color: Colors.transparent,
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              //width: 50,
              child: /*Stack(
                        alignment: Alignment.center,
                        children: [*/
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivitiesPage()),
                          )
                        },
                        child: Text(
                          '🔥',
                          style: new TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent),
                        ),
                      )),
            ),*/
                //Center(
                //child:

                Container(
                    height: 100,
                    width: 200,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Container(
                            color: Color.fromRGBO(00, 00, 00, 0.5),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              Container(
                                //width: 50,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActivitiesPage()),
                                            )
                                          },
                                          child: Icon(
                                              Icons.notifications,
                                              size: 33.0,
                                              color: Colors.white),
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              
                              
                              Container(
                                //width: 50,
                                child: /*Stack(
                        alignment: Alignment.center,
                        children: [*/
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActivitiesPage()),
                                            )
                                          },
                                          child: Icon(Icons.add_circle_rounded,
                                              size: 35.0, color: Colors.white),
                                        )),
                              ),
                              /*Container(
                      //width: 50,
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Image.asset(
                        //'assets/agila-logo.png',
                        'assets/makulay.png',
                        height:
                            40, //widget._tabController.index == 1 ? 16 : 12,
                        width: 40, //widget._tabController.index == 1 ? 16 : 12,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),*/

                              /*Container(
                                padding:
                                    //faves[index].chatType == 'group'
                                    //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                    //:
                                    EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: CachedNetworkImageProvider(
                                      profilepicture),
                                ),
                              ),*/

                              /*Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Stack(
                                      children: [
                                        Icon(Icons.qr_code_2_outlined,
                                            size: 35.0, color: Colors.white),
                                      ],
                                    )),*/
                              
                              Container(
                                //width: 50,
                                child: /*Stack(
                        alignment: Alignment.center,
                        children: [*/
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActivitiesPage()),
                                            )
                                          },
                                          child: Icon(Icons.search,
                                              size: 33.0, color: Colors.white),
                                        )),
                              ),
                            ])))),
                //),
                /*Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              //width: 50,
              child: /*Stack(
                        alignment: Alignment.center,
                        children: [*/
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActivitiesPage()),
                          )
                        },
                        child: Text(
                          '🔥',
                          style: new TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.transparent),
                        ), /*Icon(Icons.local_fire_department,
                                    size: 28.0, color: Colors.red),*/
                      )),
            ),*/
             /*Container(
                    //height: 80,
                    //width: 50,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text('|', style: TextStyle(color: Colors.white, fontSize: 40),),
             ),*/
                /*Container(
                  height: 80,
                  width: 237,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      //controller: _scrollController,'
                      //reverse: true,
                      //scrollDirection: Axis.horizontal,
                      itemCount: tabbarWidgets.length,
                      //padding: new EdgeInsets.fromLTRB(0, 0, 20, 0),
                      itemBuilder: (BuildContext context, int index) {
                        return tabbarWidgets[index];
                      }),
                )*/
              ],
            )
            //)
            );
    //for (var tabby in tabbarWidgets)
    //tabby
  }
}
