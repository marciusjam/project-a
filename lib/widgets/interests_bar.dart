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

class InterestsBar extends StatefulWidget {
  final List<CameraDescription> cameras;

  final int selectedPageIndex;
  final Function onIconTap;

  final String profilepicture;
  final String username;
  final String userid;

  InterestsBar(
    {
    Key? key,
    required this.selectedPageIndex,
    required this.onIconTap,
    required this.cameras,
    required this.profilepicture,
    required this.username,
    required this.userid,
  }) : super(key: key);

  @override
  State<InterestsBar> createState() => _InterestsBarState();
}

class _InterestsBarState extends State<InterestsBar> {
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
    widget.onIconTap(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + widget.selectedPageIndex.toString());
  }

  void _onProfileImageTapped() {
    widget.onIconTap(0);
    widget.selectedPageIndex == 0;
    print('Profile Image Tapped');
  }

  void _onLogoTapped() {
    widget.onIconTap(0);
    widget.selectedPageIndex == 0;
    print('Logo Tapped');
  }

  void _onCreateTap() {
    widget.onIconTap(3);
    widget.selectedPageIndex == 3;
    print('Create Tapped');
  }

  int _currentIndex = 0;

  _topBarNavItem(int index, String label) {
    bool isSelected = widget.selectedPageIndex == index;
    //Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;
    Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;

    double defaultHeight = 25;
    double defaultWidth = 25;
    double sizedboxheight = 10;

    debugPrint(widget.selectedPageIndex.toString());
    return GestureDetector(
      onTap: () => {widget.onIconTap(index)},
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
                onChanged: (String? value) => setState(() {
                  _selectedItem1 = value ?? "";
                }),)
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
    if (widget.selectedPageIndex == 1 || widget.selectedPageIndex == 0) {
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
       navHeader(context)

        );
  }
}
