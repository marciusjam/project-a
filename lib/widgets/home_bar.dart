import 'package:Makulay/screens/auth_page.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
   final List<CameraDescription> cameras;

  final TabController _tabController;
  final int selectedPageIndex;
  final Function onIconTap;

  final String profilepicture;
  final String username;
  final String userid;

  

  HomeBar(this._tabController,
   
      {Key? key,
      required this.selectedPageIndex,
      required this.onIconTap,
      required this.cameras,
      required this.profilepicture,
      required this.username,
      required this.userid,
      })
      : super(key: key);
  
  final List<Widget> _dropdownValues = [
    
    
  ];

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

   var colorToUse = Colors.grey[300];
   if(selectedPageIndex == 1 || selectedPageIndex == 0){
      colorToUse = Colors.black;
   }else{
      colorToUse = Colors.grey[300];
   }

    return SliverAppBar(
      
      excludeHeaderSemantics: true,
      toolbarHeight: 0,
      //expandedHeight: 100,
      //toolbarHeight: 50,
      //collapsedHeight: 50,
      backgroundColor: Colors.white,
      //centerTitle: true,
      pinned: true,
      elevation: 0,
      floating: true,
      surfaceTintColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        //statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
      bottom: TabBar(
        padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width / 2, 0),
        isScrollable: true,
        onTap: (value) => _onTabClick(value),
        enableFeedback: false,
        overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        indicatorColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.label,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
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
          /*Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(children: [
                  Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 20.0, color: Colors.amber),
                      Positioned(
                          top: 4.0,
                          right: 6.0,
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
                  'Activities',
                ),
                /*SvgPicture.asset(
                  'assets/chat.svg',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fitHeight,
                  color: colorToUse,
                ),*/
                //Icon(Icons.chat, size: 25.0, color: colorToUse),
                
                ])),
              ],
            ),
          ),*/

          /*Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(children: [
                  Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 20.0, color: Colors.amber),
                      Positioned(
                          top: 4.0,
                          right: 6.0,
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
                ),
                /*SvgPicture.asset(
                  'assets/chat.svg',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fitHeight,
                  color: colorToUse,
                ),*/
                //Icon(Icons.chat, size: 25.0, color: colorToUse),
                
                ])),
              ],
            ),
          ),*/
          
          
          Tab(
            child: Container(padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width / 2, 0),
            //width: 200,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Row(children: [
                 
                          Image.asset(
                            //'assets/agila-logo.png',
                            'assets/makulay.png',
                            height:
                                40, //widget._tabController.index == 1 ? 16 : 12,
                            width:
                                40, //widget._tabController.index == 1 ? 16 : 12,
                            filterQuality: FilterQuality.medium,
                          ),
                      profilepicture != '' ?    Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        
            child: /*DropdownButtonHideUnderline(
          child: DropdownButton(
            items: _dropdownValues
                .map((value) => DropdownMenuItem(
                      child: value,
                      value: value,
                    ))
                .toList(),
            onChanged: ( value) {},
            isExpanded: false,
            value: _dropdownValues.first,
          ),
        ),
      ),*/
      new GestureDetector(
      onTap: (){
        //Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => new ProfilePage()));

        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => ProfilePage(username)),
        );
      },
      child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: CachedNetworkImageProvider(profilepicture)/*AssetImage(
                                                    'assets/profile-jam.jpg'),*/
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child:Text(
                  username, style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          //fontFamily: 'Gotham-Black',
          fontWeight: FontWeight.bold,
        ), 
                ))])
      ),
    ) : Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:Text(
                  'Makulay',style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontFamily: 'Gotham-Black',
          fontWeight: FontWeight.bold,
        ), )),
                          

                ]),
         

              
              ],
            ),)
          ),
          
          
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: SvgPicture.asset(
                  'assets/globe.svg',
                  height: 15,
                  width: 15,
                  fit: BoxFit.fitHeight,
                  //color: Colors.amber,
                ),),*/
                /*Padding
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.local_fire_department_sharp, size: 25.0, color: Colors.red),
                      
                    ],
                  ),
                ),*/
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
                /*Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: SvgPicture.asset(
                  'assets/globe.svg',
                  height: 15,
                  width: 15,
                  fit: BoxFit.fitHeight,
                  //color: Colors.amber,
                ),),*/
                /*Padding
                  padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.local_fire_department_sharp, size: 25.0, color: Colors.red),
                      
                    ],
                  ),
                ),*/
                Text(
                  'World',
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
                /*Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.live_tv_rounded, size: 18.0, color: Colors.red),
                      
                    ],
                  ),
                ),*/
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

          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.music_video_rounded, size: 20.0, color: Colors.green),
                      
                    ],
                  ),
                ),*/
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
        ],
      ),
      title: Padding(
        padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              
            ]),
      ),
      actions: [],
    );
  }
}
