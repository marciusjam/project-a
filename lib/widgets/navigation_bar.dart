import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar(this.username, this.profilepicture, this.cameras,
      {Key? key, required this.selectedPageIndex, required this.onIconTap})
      : super(key: key);
  final int selectedPageIndex;
  final Function onIconTap;
  final String username;
  final String profilepicture;
  final List<CameraDescription> cameras;

  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.of(context).size.height * 0.05;
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11);

    return Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
                height: 50.0,
                color: Colors.white,//Color.fromRGBO(00, 00, 00, 0.7),
                /*margin: const EdgeInsets.only(bottom: 7.0), //Same as `blurRadius` i guess
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Image.asset(
                        //'assets/agila-logo.png',
                        'assets/makulay.png',
                        height:
                            40, //widget._tabController.index == 1 ? 16 : 12,
                        width: 40, //widget._tabController.index == 1 ? 16 : 12,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                    /*profilepicture != ''
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: InkWell(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                            username, profilepicture)),
                                  )
                                },
                                child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  profilepicture) /*AssetImage(
                                                    'assets/profile-jam.jpg'),*/
                                          ),
                                    
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewPostPage(
                                            username: username, 
                                            profilepicture: profilepicture,
                                            cameras: cameras,
                                          )),
                                )
                              },
                              child: Icon(Icons.person,
                                  size: 35.0, color: Colors.black),
                            ),
                          ),*/
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPostPage(
                                      username: username, 
                                            profilepicture: profilepicture,
                                            cameras: cameras,
                                            preselectedAssets: [],
                                            preentityPaths: [],
                                            descriptionController: new TextEditingController(),
                                    )),
                          )
                        },
                        child: Icon(Icons.home,
                            size: 35.0, color: Colors.black),
                      ),
                    ),*/
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPostPage(
                                      username: username, 
                                            profilepicture: profilepicture,
                                            cameras: cameras,
                                            preselectedAssets: [],
                                            preentityPaths: [],
                                            descriptionController: new TextEditingController(),
                                    )),
                          )
                        },
                        child: Stack(children: [
                          Icon(Icons.web_stories_outlined,
                            size: 30.0, color: Colors.black),
                          /*Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0), child: Icon(Icons.keyboard_arrow_down_rounded,
                            size: 22.0, color: Colors.white),)*/
                          
                            
                            ],) 
                      ),
                    ),*/
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPostPage(
                                      username: username, 
                                            profilepicture: profilepicture,
                                            cameras: cameras,
                                            preselectedAssets: [],
                                            preentityPaths: [],
                                            descriptionController: new TextEditingController(),
                                    )),
                          )
                        },
                        child: Icon(Icons.add,
                            size: 35.0, color: Colors.black),
                      ),
                    ),*/

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(username)),
                          )
                        },
                        child: Icon(Icons.local_fire_department_outlined,
                            size: 36.0, color: Colors.black87),
                      ),
                    ),
                    Stack(
                      children: [
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
                            child: Image.asset('assets/chat.png', height: 28, width: 28, filterQuality: FilterQuality.high, color: Colors.black87,))
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
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
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(username)),
                          )
                        },
                        child: Image.asset('assets/chat.png', height: 30, width: 30, filterQuality: FilterQuality.high,))
                        /*Icon(Icons.qr_code_2_rounded,
                            size: 33.0, color: Colors.black),
                      ),*/
                    ),*/
                    
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage(username)),
                          )
                        },
                        child: Icon(Icons.search_rounded,
                            size: 30.0, color: Colors.black),
                      ),
                    ),*/
                    

                    /*Stack(children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
      child:GestureDetector(
        onTap: () => {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ActivitiesPage()),
        )},
        child: Icon(Icons.dynamic_feed_sharp, size: 32.0, color: Colors.white),),
           
          ),
          Padding(
                  padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 20.0, color: Colors.amber),
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

                    Stack(
                      children: [
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
                            child: Icon(Icons.notifications_none_rounded,
                                size: 33.0, color: Colors.black87),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(17, 0, 0, 0),
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
                  ],
                ))));
  }
}
