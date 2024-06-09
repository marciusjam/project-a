import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/discover_page.dart';
import 'package:Makulay/screens/following_page.dart';
import 'package:Makulay/screens/interests_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/sidemenu_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String profilePicKey, username, userid;
  const HomePage(this.profilePicKey,this.username,this.userid, this.cameras, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedPageIndex = 0;

  final int lengthSignedIn = 4;
  final int lengthNotSignedIn = 2;

  var  _tabController;
  var _scrollController;

  void onIconTap(int index) {
    debugPrint('index ' + index.toString());
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    
    
    super.initState();
    _scrollController = ScrollController();
    debugPrint('Homepage widget.userid ' + widget.userid);
    
    _tabController = TabController(vsync: this, length: widget.userid != '' ? lengthSignedIn : lengthNotSignedIn, initialIndex: widget.userid != '' ? 1 : 1);
    _tabController.addListener(() {
      setState(() {
        _selectedPageIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
    if(widget.userid != ''){
      setState(() {
        _selectedPageIndex = 0;
      });
    }else{
      setState(() {
        _selectedPageIndex = 1;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: NestedScrollView(
      //floatHeaderSlivers: true,
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
       
            HomeBar(
            onIconTap: onIconTap,
            selectedPageIndex: _selectedPageIndex,
            cameras: widget.cameras,
            profilepicture: widget.profilePicKey,
            username: widget.username,
            userid: widget.userid,
          ),
          
        
          
          
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
    if(widget.userid != '')
      SideMenuPage(widget.profilePicKey, widget.username, widget.userid, widget.cameras, onIconTap: onIconTap,
            selectedPageIndex: _selectedPageIndex,),
   
    if(widget.userid == '')
      Login(widget.cameras),

    /*if(widget.userid != '')
      InterestsPage(profilepicture: widget.profilepicture, username: widget.username, userid: widget.userid, cameras: widget.cameras, selectedPageIndex: _selectedPageIndex, onIconTap:onIconTap),
*/

   
      //DiscoverPage(widget.profilePicKey, widget.username, widget.userid, widget.cameras),


    if(widget.userid != '')
      ChatPage(widget.cameras),
  ],
),
//_pages[_selectedPageIndex]
    ));
  }
}
