import 'package:Makulay/navigation_container.dart';
import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/auth_page.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class HomeBar extends StatelessWidget {
  final List<CameraDescription> cameras;

  final int selectedPageIndex;
  final Function onIconTap;

  final String profilepicture;
  final String username;
  final String userid;

  HomeBar(
    {
    Key? key,
    required this.selectedPageIndex,
    required this.onIconTap,
    required this.cameras,
    required this.profilepicture,
    required this.username,
    required this.userid,
  }) : super(key: key);

  final List<Widget> _dropdownValues = [];

  final List<Widget> titleBar = [

    
  ];

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


  void _onTabClick(int index) {
    int finalIndex = index;
    onIconTap(finalIndex);
    selectedPageIndex == finalIndex;
    print('Tab Clicked ' + selectedPageIndex.toString());
  }

  void _onProfileImageTapped() {
    onIconTap(0);
    selectedPageIndex == 0;
    print('Profile Image Tapped');
  }

  void _onLogoTapped() {
    onIconTap(0);
    selectedPageIndex == 0;
    print('Logo Tapped');
  }

  void _onCreateTap() {
    onIconTap(3);
    selectedPageIndex == 3;
    print('Create Tapped');
  }

  int _currentIndex = 0;

  _topBarNavItem(int index, String label) {
    bool isSelected = selectedPageIndex == index;
    //Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;
    Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;

    double defaultHeight = 25;
    double defaultWidth = 25;
    double sizedboxheight = 10;

    debugPrint(selectedPageIndex.toString());
    return GestureDetector(
      onTap: () => {onIconTap(index)},
      child: Text(
        label,
        style: TextStyle(
            color: iconAndTextColor, fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  Widget navHeader(BuildContext context) {
    return Container(
      //color: Colors.transparent,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
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
                onChanged: (String? value) => 
                  _selectedItem1 = value ?? "",)
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController postController = TextEditingController();

    var colorToUse = Colors.grey[300];
    if (selectedPageIndex == 1 || selectedPageIndex == 0) {
      colorToUse = Colors.black;
    } else {
      colorToUse = Colors.grey[300];
    }
    //print("Selected Index123: " + _tabController.index.toString());

    return SliverAppBar(
        //excludeHeaderSemantics: true,
        toolbarHeight: 75,
        //expandedHeight: 100,
        //toolbarHeight: 0,
        centerTitle: true,
        //collapsedHeight: 50,
        backgroundColor: Colors.white,
         //selectedPageIndex == 0 ? Colors.transparent: Colors.black,
        //centerTitle: true,
        pinned: false,
        surfaceTintColor: Colors.white,
        floating: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          //statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light,
        ),
        /*bottom: new PreferredSize(
            preferredSize: new Size(0,0.0),
            child: new Container(
              child: new TabBar(
          //MediaQuery.of(context).size.width / 2
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          //isScrollable: true,
          //tabAlignment: TabAlignment.fill,
          onTap: (value) => _onTabClick(value),
          enableFeedback: false,
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
dividerHeight: 0,
          dividerColor: Colors.transparent,
          //indicatorPadding: EdgeInsets.fromLTRB(75, 0, 0, 0),
          controller: _tabController,
          unselectedLabelColor: Colors.grey.shade300,
          //labelPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            //fontFamily: 'Gotham-Black',
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            //if (userid != '')
             
            
            if (userid != '')
              Tab(
                  child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Messages',
                    )
                  ],
                ),
              )),
            if (userid == '')
              Tab(
                  child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Login',
                    )
                  ],
                ),
              )),
            if (userid != '')
              Tab(
                  child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Following',
                    )
                  ],
                ),
              )),
            /*if (userid != '')
              Tab(
                  child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Streams',
                    )
                  ],
                ),
              )),
            if (userid != '')
              Tab(
                  child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Podcasts',
                    )
                  ],
                ),
              )),*/
            Tab(
                child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Discover',
                  )
                ],
              ),
            )),
          ],
        ),
        ))*/
      title: 
      Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                      Container(
                        width: MediaQuery.sizeOf(context).width - 40,
                          child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                                padding:
                                                    //faves[index].chatType == 'group'
                                                    //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                                                    //:
                                                    EdgeInsets.fromLTRB(
                                                        0, 0, 10, 0),
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
                                                  child: InkWell(
                                                    onTap: () => {},
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.amber,
                                                        child: Container(
                                                          height: 45,
                                                          width: 45,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                CachedNetworkImageProvider(
                                                                    profilepicture),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 5, 5),
                                                child: Text(
                                                  username,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 5, 5),
                                                  child: Icon(
                                                    Icons.verified,
                                                    size: 16,
                                                    color: Colors.amber,
                                                  )),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Card(
                                                        margin:
                                                            EdgeInsets.zero,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            new RoundedRectangleBorder(
                                                          side: new BorderSide(
                                                              color: Colors.grey.shade300,
                                                              width: .5),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .all(
                                                                  const Radius
                                                                      .circular(
                                                                      50)),
                                                        ),
                                                        color: Colors.transparent,
                                                        elevation: 0,
                                                        surfaceTintColor:
                                                            Colors.transparent,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                              child: Text(
                                                                //'How are you feeling today?',
                                                                'I kinda feel bad today 😭',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 5, 0),
                                        child: GestureDetector(
                                          onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ActivitiesPage()),
                                            )
                                          },
                                          child: Icon(Icons.qr_code_2_rounded,
                                              size: 35.0, color: Colors.grey.shade900),
                                        ),
                                      ),
                                          /*Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 0, 5),
                                          child: Container(
                                              width: 50,
                                              child: CustomVideoPlayer(
                                                  'fade',
                                                  'assets/series_2.mp4',
                                                  9 / 16,
                                                  'description',
                                                  'username',
                                                  'profilepicture',
                                                  2,
                                                  null,
                                                  false))),*/
                                    ]),
                              ],
                            )),
                      )),
                    
              
              ],
            ))

        );
  }
}
