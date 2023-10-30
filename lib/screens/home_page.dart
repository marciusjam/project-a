import 'package:agilay/screens/chat_page.dart';
import 'package:agilay/screens/discover_page.dart';
import 'package:agilay/screens/interests_page.dart';
import 'package:agilay/screens/new_post_page.dart';
import 'package:agilay/screens/profile_page.dart';
import 'package:agilay/screens/sidemenu_page.dart';
import 'package:agilay/widgets/home_bar.dart';
import 'package:agilay/widgets/post_card.dart';
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
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<CameraDescription> cameras;
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    //SideMenuPage(),
    //ProfilePage(),
    InterestsPage(),
    ChatPage(),
    //NewPostPage(cameras: cameras),
    //DiscoverPage(),
    //ProfilePage(),
  ];

  var _scrollController, _tabController;

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
    _tabController = TabController(vsync: this, length: 2);
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
          ),
        ];
      },
      body: _pages[_selectedPageIndex],
    );
  }
}
