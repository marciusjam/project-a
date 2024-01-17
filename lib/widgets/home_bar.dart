import 'package:agilay/screens/auth_page.dart';
import 'package:agilay/screens/chat_page.dart';
import 'package:agilay/screens/new_post_page.dart';
import 'package:agilay/screens/profile_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

void _signOutAndNavigateToLogin(BuildContext context) async {
  try {
    await Amplify.Auth.signOut();
    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthPage(),
      ),
    );
  } catch (e) {
    print('Error during sign-out: $e');
  }
}

class HomeBar extends StatelessWidget {
  HomeBar(this._tabController,
      {Key? key,
      required this.selectedPageIndex,
      required this.onIconTap,
      required this.cameras})
      : super(key: key);
  final List<CameraDescription> cameras;

  final TabController _tabController;
  final int selectedPageIndex;
  final Function onIconTap;

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
  Widget build(BuildContext context) {
    final TextEditingController postController = TextEditingController();

   

    return SliverAppBar(
      //expandedHeight: 100,
      toolbarHeight: 50,
      //collapsedHeight: 50,
      backgroundColor: Colors.white,
      centerTitle: true,
      pinned: true,
      elevation: 0,
      floating: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        //statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
      bottom: TabBar(
        isScrollable: true,
        onTap: (value) => _onTabClick(value),
        enableFeedback: false,
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        indicatorColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: TabAlignment.start,
        //indicatorPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
        controller: _tabController,
        unselectedLabelColor: Colors.black12,
        //labelPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
          //fontFamily: 'Gotham-Black',
          fontWeight: FontWeight.bold,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 20.0, color: Colors.amber),
                      Positioned(
                          top: 5.0,
                          right: 7.0,
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
                Text(
                  'Messages',
                )
                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
              ],
            ),
          ),
          /*SizedBox(
      width: 35.0,
      child:*///),
          /*SizedBox(
      width: 35.0,
      child:Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.search, size: 30.0, color: Colors.amber),
                      
                    ],
                  ),
                ),
                
                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
            ],
            ),
          ),),*/
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 20.0, color: Colors.amber),
                      Positioned(
                          top: 5.0,
                          right: 7.0,
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
                Text(
                  'Interests',
                )
                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.local_fire_department_sharp, size: 25.0, color: Colors.red),
                      
                    ],
                  ),
                ),
                Text(
                  'Trends',
                )
                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
            ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.music_video_rounded, size: 25.0, color: Colors.blue),
                      
                    ],
                  ),
                ),
                Text(
                  'Podcasts',
                )
                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
            ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 5),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.live_tv_rounded, size: 20.0, color: Colors.green),
                      
                    ],
                  ),
                ),
                Text(
                  'Streams',
                )
                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
            ],
            ),
          ),
        ],
      ),
      title: Padding(
        padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(children: [
                  PopupMenuButton(
                    child: ClipOval(
                      child: SizedBox.fromSize(
                          size: Size.fromRadius(15), // Image radius
                          child: Image.asset('assets/profile-jam.jpg',
                              height:
                                  15, //widget._tabController.index == 1 ? 16 : 12,
                              width:
                                  15, //widget._tabController.index == 1 ? 16 : 12,
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.cover)),
                    ),
                    onSelected: (value) {
                      if (value == "profile") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      } else if (value == "settings") {
                        // add desired output
                      } else if (value == "switch") {
                        // add desired output
                      } else if (value == "logout") {
                        _signOutAndNavigateToLogin(context);
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        value: "profile",
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.person, color: Colors.amber),
                            ),
                            const Text(
                              'View Profile',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "settings",
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.settings, color: Colors.amber),
                            ),
                            const Text(
                              'Settings',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "switch",
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.switch_account,
                                  color: Colors.amber),
                            ),
                            const Text(
                              'Switch Account',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "logout",
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.logout, color: Colors.amber),
                            ),
                            const Text(
                              'Logout',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*GestureDetector(
                      onTap: () => {
                            //_onProfileImageTapped()
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()),
                            )
                          },
                      child: Container(
                        //padding: EdgeInsets.all(3), // Border width
                        /*decoration: BoxDecoration(
                              border: Border.all(
                                  //<-- SEE HERE
                                  width: 3,
                                  color: Colors.amber),
                              shape: BoxShape.circle),*/
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(15), // Image radius
                            child: //Image.asset('assets/profile-jam.jpg',
                                Image.asset('assets/profile-jam.jpg',
                                    height:
                                        15, //widget._tabController.index == 1 ? 16 : 12,
                                    width:
                                        15, //widget._tabController.index == 1 ? 16 : 12,
                                    filterQuality: FilterQuality.medium,
                                    fit: BoxFit.cover),
                          ),
                        ),
                      )),*/
                  /*Padding(
                      padding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                      child: Text('@Marcius',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                              //fontFamily: 'Gotham-Black'
                              ))),*/
                ]),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(children: [
                  GestureDetector(
                      onTap: () => {_onLogoTapped()},
                      child: //Stack(
                          Row(
                        //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
                        children: [
                          Image.asset(
                            //'assets/agila-logo.png',
                            'assets/agila-logo.png',
                            height:
                                36, //widget._tabController.index == 1 ? 16 : 12,
                            width:
                                36, //widget._tabController.index == 1 ? 16 : 12,
                            filterQuality: FilterQuality.medium,
                          ),

                          /*Positioned(
                                left: 30,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(Icons.brightness_1,
                                        size: 20.0, color: Colors.black),
                                    Positioned(
                                        top: 5.0,
                                        right: 7.0,
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
                                )),*/
                        ],
                      ))
                ]),
              ),
              Spacer(),

              /*Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 5, 10),
                child: Row(children: [
                  Container(
                    height: 35.0,
                    width: 50.0,
                    child: GestureDetector(
                        onTap: () => {_onLogoTapped()},
                        child: Stack(
                          //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/search.svg',
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitHeight,
                              color: Colors.black,
                            ),
                            /*Positioned(
                                left: 30,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(Icons.brightness_1, 
                                        size: 20.0, color: Colors.black),
                                    Positioned(
                                        top: 5.0,
                                        right: 7.0,
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
                                )),*/
                          ],
                        )),
                  )
                ]),
              ),*/
              Padding(
                padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: GestureDetector(
                    onTap: () => {
                          //_onCreateTap()
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewPostPage(
                                      cameras: cameras,
                                    )),
                          )
                        },
                    child: Stack(
                      //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/newpost.svg',
                          height: 30,
                          width: 30,
                          fit: BoxFit.fitHeight,
                          color: Colors.black,
                        ),
                        /*Positioned(
                                left: 25,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(Icons.brightness_1,
                                        size: 20.0, color: Colors.black),
                                    Positioned(
                                        top: 5.0,
                                        right: 7.0,
                                        child: Center(
                                          child: Text(
                                            '8',
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ],
                                )),*/
                      ],
                    )),
              )
            ]),
      ),

      /*flexibleSpace: FlexibleSpaceBar(
          background: Stack(children: <Widget>[
        Padding(
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Padding(
                padding: new EdgeInsets.fromLTRB(10, 5, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: 30.0,
                        width: 200.0,
                        child: Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Looking for something?',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                )),*/
                Padding(
                    padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Spacer(),//
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                  child: Stack(
                                    children: <Widget>[
                                      Icon(Icons.brightness_1,
                                          size: 20.0, color: Colors.amber),
                                      Positioned(
                                          top: 5.0,
                                          right: 7.0,
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
                                ),
                                Text(
                                  'Messages',
                                  style: TextStyle(
                                    color: Colors.black12,
                                    fontSize: 20,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: 'Gotham-Black',
                                  ),
                                )
                                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
                              ],
                            )),
                        /*Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Text('|',
                                style: TextStyle(
                                    color: Colors.black12,
                                    fontSize: 20,
                                    fontFamily: 'Gotham-Black'))),*/
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                  child: Stack(
                                    children: <Widget>[
                                      Icon(Icons.brightness_1,
                                          size: 20.0, color: Colors.amber),
                                      Positioned(
                                          top: 5.0,
                                          right: 7.0,
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
                                Text(
                                  'Interests',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    //fontWeight: FontWeight.bold,
                                    fontFamily: 'Gotham-Black',
                                  ),
                                )
                                /*SvgPicture.asset(
                                  'assets/chat.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.grey,
                                ),*/
                              ],
                            )),

                        /*Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Text('|',
                                style: TextStyle(
                                    color: Colors.black12,
                                    fontSize: 20,
                                    fontFamily: 'Gotham-Black'))),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              'Discover',
                              style: TextStyle(
                                  color: Colors.black12,
                                  fontSize: 20,
                                  fontFamily: 'Gotham-Black'),
                            )),*/
                        //Spacer(),
                        /*Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/trending.svg',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.black,
                                ),
                                
                              ],
                            )),*/
                        /*Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              children: [
                                /*Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                  child: Stack(
                                    children: <Widget>[
                                      Icon(Icons.brightness_1,
                                          size: 20.0, color: Colors.amber),
                                      Positioned(
                                          top: 3.0,
                                          right: 7.0,
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
                                ),*/

                                SvgPicture.asset(
                                  'assets/search.svg',
                                  height: 17,
                                  width: 17,
                                  fit: BoxFit.fitHeight,
                                  color: Colors.black,
                                ),
                              ],
                            )),*/
                      ],
                    )),
              ],
            )),
      ])),
      */
      actions: [],
    );
  }
}
