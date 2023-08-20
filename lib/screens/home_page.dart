import 'package:agilay/screens/discover_page.dart';
import 'package:agilay/screens/interests_page.dart';
import 'package:agilay/screens/profile_page.dart';
import 'package:agilay/screens/sidemenu_page.dart';
import 'package:agilay/widgets/home_bar.dart';
import 'package:agilay/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
  int _selectedPageIndex = 1;

  List<Widget> _pages = [
    SideMenuPage(),
    InterestsPage(),
    DiscoverPage(),
    ProfilePage(),
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
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          HomeBar(
            _tabController,
            onIconTap: onIconTap,
            selectedPageIndex: _selectedPageIndex,
          ),
        ];
      },
      body: _pages[_selectedPageIndex],
    );
  }
}
