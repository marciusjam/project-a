import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/discover_page.dart';
import 'package:Makulay/screens/following_page.dart';
import 'package:Makulay/screens/interests_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/sidemenu_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class HomePage extends StatefulWidget {
  final String profilePicKey, username, userid;
  const HomePage(this.profilePicKey,this.username,this.userid, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<CameraDescription> cameras;
  int _selectedPageIndex = 2;


  var  _tabController;
  var _scrollController;

  SliverList _getSlivers(List myList, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return myList[index];
        },
        childCount: myList.length,
      ),
    );
  }

  void onIconTap(int index) {
    debugPrint('index ' + index.toString());
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 5, initialIndex: 0);
    _tabController.addListener(() {
      setState(() {
        _selectedPageIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });
    initializeCameras();
    super.initState();
  }



  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    setState(() {}); // Trigger a rebuild to display camera descriptions
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
       
            HomeBar(
            _tabController,
            onIconTap: onIconTap,
            selectedPageIndex: _selectedPageIndex,
            cameras: cameras,
            profilepicture: widget.profilePicKey,
            username: widget.username,
            userid: widget.userid,
          ),
          
        
          
          
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
    //SideMenuPage(),
   
    ChatPage(),
    InterestsPage(),
    DiscoverPage(),
    //ProfilePage(),
    SideMenuPage(),
    DiscoverPage(),
    //NewPostPage(cameras: cameras),
    //DiscoverPage(),
    //ProfilePage(),
  ],
),
//_pages[_selectedPageIndex]
    );
  }
}
