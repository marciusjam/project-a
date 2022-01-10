import 'package:agilay/screens/discover_page.dart';
import 'package:agilay/screens/following_page.dart';
import 'package:agilay/screens/trending_page.dart';
import 'package:agilay/widgets/home_bar.dart';
import 'package:agilay/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final double _selectedIndex = 1;

  List<Widget> list = [
    PostCard('textPost'),
    PostCard('image-Horizontal'),
    PostCard('image-Vertical'),
    PostCard('video-Horizontal'),
    PostCard('video-Vertical'),
  ];

  List<Widget> pages = [
    FollowingPage(), DiscoverPage() //, TrendingPage()
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

  /*buildRow(String title) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)));
  }*/

  _pageView(List myList) {
    return ListView.builder(
      itemCount: 5,
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
      itemBuilder: (BuildContext context, int index) {
        return myList[index];
      },
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          HomeBar(_tabController),
        ];
      },
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          _pageView(list),
          _pageView(list),
          _pageView(list),
        ],
      ),
    );
  }
}
