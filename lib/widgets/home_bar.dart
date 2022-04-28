import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBar extends StatefulWidget {
  const HomeBar(this._tabController, {Key? key}) : super(key: key);
  final TabController _tabController;

  @override
  State<HomeBar> createState() => _HomeBarState();
}

void _onProfileImageTapped() {
  print('Profile Image Tapped');
}

void _onLogoTapped() {
  print('Logo Tapped');
}

class _HomeBarState extends State<HomeBar> with SingleTickerProviderStateMixin {
  //late TabController _tabController;
  int _currentIndex = 0;

  _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //_tabController = new TabController(vsync: this, length: 3);
    //_tabController.addListener(_handleTabSelection);
  }

  /*@override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    widget._tabController.addListener(_handleTabSelection);
    //debugPrint('_tabController: ' + widget._tabController.toString());
    return SliverAppBar(
      backgroundColor: Colors.white,
      //pinned: true,
      //toolbarHeight: 50,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  GestureDetector(
                    onTap: () => {_onLogoTapped()},
                    child: Image.asset(
                      'assets/agila-logo.png',
                      height: 30, //widget._tabController.index == 1 ? 16 : 12,
                      width: 30, //widget._tabController.index == 1 ? 16 : 12,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ]),
                /*Row(children: [
                  SvgPicture.asset(
                    'assets/newpost.svg',
                    height: 22, //widget._tabController.index == 2 ? 16 : 12,
                    width: 22, //widget._tabController.index == 2 ? 16 : 12,
                    fit: BoxFit.scaleDown,
                    color: widget._tabController.index == 2
                        ? Colors.amber
                        : Colors.black,
                  ),
                ]),*/
                Row(children: [Text(' ')]),
                Row(children: [Text(' ')]),
                Padding(
                  padding: new EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    children: [
                      /*Icon(
                        Icons.people,
                        color: widget._tabController.index == 0
                            ? Colors.amber
                            : Colors.black12,
                        size: 20, //widget._tabController.index == 0 ? 20 : 13,
                      ),*/
                      Text(
                        ' Following',
                        style: TextStyle(
                            color: widget._tabController.index == 0
                                ? Colors.amber
                                : Colors.black12,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                14), //widget._tabController.index == 0 ? 18 : 13),
                      ),
                    ],
                  ),
                ),
                Row(children: [Text(' ')]),
                Padding(
                  padding: new EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    children: [
                      /*Image.asset('assets/discover.png',
                          height:
                              14, //widget._tabController.index == 1 ? 16 : 12,
                          width:
                              14, //widget._tabController.index == 1 ? 16 : 12,
                          fit: BoxFit.scaleDown,
                          color: widget._tabController.index == 1
                              ? Colors.amber
                              : Colors.black12),*/
                      Padding(
                        padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          ' Discover',
                          style: TextStyle(
                              color: widget._tabController.index == 1
                                  ? Colors.amber
                                  : Colors.black12,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  14), //widget._tabController.index == 1 ? 18 : 13),
                        ),
                      )
                    ],
                  ),
                ),
                Row(children: [Text(' ')]),
                Padding(
                  padding: new EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    children: [
                      /*SvgPicture.asset(
                        'assets/trending.svg',
                        height:
                            22, //widget._tabController.index == 2 ? 16 : 12,
                        width: 22, //widget._tabController.index == 2 ? 16 : 12,
                        fit: BoxFit.scaleDown,
                        color: widget._tabController.index == 2
                            ? Colors.amber
                            : Colors.black12,
                      ),*/
                      Text(
                        ' Trending',
                        style: TextStyle(
                            color: widget._tabController.index == 2
                                ? Colors.amber
                                : Colors.black12,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                14), //widget._tabController.index == 2 ? 18 : 13),
                      ),
                    ],
                  ),
                ),
                Row(children: [Text(' ')]),
                Row(children: [Text(' ')]),
                Padding(
                  padding: new EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () => {_onProfileImageTapped()},
                        child: Container(
                          //padding: EdgeInsets.all(3), // Border width
                          //decoration: BoxDecoration(
                          //color: Colors.red, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(13), // Image radius
                              child: Image.asset('assets/profile-jam.jpg',
                                  height:
                                      13, //widget._tabController.index == 1 ? 16 : 12,
                                  width:
                                      13, //widget._tabController.index == 1 ? 16 : 12,
                                  filterQuality: FilterQuality.medium,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        )),
                    /*Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, //remove this when you add image.
                      ),
                      child: InkWell(
                        onTap: () => {},
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30 / 2,
                          backgroundImage: AssetImage('assets/profile-jam.jpg'),
                        ),
                      ),
                    ),*/
                  ]),
                ),
              ],
            ),
          ),
          /*Padding(
            padding: new EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Text(' ')]),
                Row(children: [Text(' ')]),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: widget._tabController.index == 0
                          ? Colors.amber
                          : Colors.black12,
                      size: 25, //widget._tabController.index == 0 ? 20 : 13,
                    ),
                    Text(
                      ' Following',
                      style: TextStyle(
                          color: widget._tabController.index == 0
                              ? Colors.amber
                              : Colors.black12,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              15), //widget._tabController.index == 0 ? 18 : 13),
                    ),
                  ],
                ),
                Row(children: [Text(' ')]),
                Row(
                  children: [
                    Image.asset('assets/discover.png',
                        height:
                            16, //widget._tabController.index == 1 ? 16 : 12,
                        width: 16, //widget._tabController.index == 1 ? 16 : 12,
                        fit: BoxFit.scaleDown,
                        color: widget._tabController.index == 1
                            ? Colors.amber
                            : Colors.black12),
                    Padding(
                      padding: new EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: Text(
                        ' Discover',
                        style: TextStyle(
                            color: widget._tabController.index == 1
                                ? Colors.amber
                                : Colors.black12,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                15), //widget._tabController.index == 1 ? 18 : 13),
                      ),
                    )
                  ],
                ),
                Row(children: [Text(' ')]),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/trending.svg',
                      height: 22, //widget._tabController.index == 2 ? 16 : 12,
                      width: 22, //widget._tabController.index == 2 ? 16 : 12,
                      fit: BoxFit.scaleDown,
                      color: widget._tabController.index == 2
                          ? Colors.amber
                          : Colors.black12,
                    ),
                    Text(
                      ' Trending',
                      style: TextStyle(
                          color: widget._tabController.index == 2
                              ? Colors.amber
                              : Colors.black12,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              15), //widget._tabController.index == 2 ? 18 : 13),
                    ),
                  ],
                ),
                Row(children: [Text(' ')]),
                Row(children: [Text(' ')]),
              ],
            ),
          ),*/
        ],
      )
      /*Text('agila',
          style: GoogleFonts.lexendDeca(
              color: Colors.amber, fontSize: 25, fontWeight: FontWeight.bold)),*/
      ,

      /*bottom: TabBar(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        labelPadding: EdgeInsets.symmetric(
            //horizontal: 5,
            //vertical: 5,
            ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),

        //isScrollable: false,
        //labelColor: Colors.amber,
        //unselectedLabelColor: Colors.black26,
        indicatorColor: Colors.transparent,
        tabs: [
          Tab(
            child: Container(
              //width: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.people,
                    color: widget._tabController.index == 0
                        ? Colors.amber
                        : Colors.black12,
                    size: 25, //widget._tabController.index == 0 ? 20 : 13,
                  ),
                  Text(
                    ' Following',
                    style: TextStyle(
                        color: widget._tabController.index == 0
                            ? Colors.amber
                            : Colors.black12,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            18), //widget._tabController.index == 0 ? 18 : 13),
                  ),
                ],
              ),
            ),
          ),
          Tab(
            child: Container(
              //width: 30.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/discover.png',
                      height: 16, //widget._tabController.index == 1 ? 16 : 12,
                      width: 16, //widget._tabController.index == 1 ? 16 : 12,
                      fit: BoxFit.scaleDown,
                      color: widget._tabController.index == 1
                          ? Colors.amber
                          : Colors.black12),
                  Padding(
                    padding: new EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                      ' Discover',
                      style: TextStyle(
                          color: widget._tabController.index == 1
                              ? Colors.amber
                              : Colors.black12,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              18), //widget._tabController.index == 1 ? 18 : 13),
                    ),
                  )
                ],
              ),
            ),
          ),
          Tab(
              child: Container(
            //width: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/trending.svg',
                  height: 22, //widget._tabController.index == 2 ? 16 : 12,
                  width: 22, //widget._tabController.index == 2 ? 16 : 12,
                  fit: BoxFit.scaleDown,
                  color: widget._tabController.index == 2
                      ? Colors.amber
                      : Colors.black12,
                ),
                Text(
                  ' Trending',
                  style: TextStyle(
                      color: widget._tabController.index == 2
                          ? Colors.amber
                          : Colors.black12,
                      fontWeight: FontWeight.bold,
                      fontSize:
                          18), //widget._tabController.index == 2 ? 18 : 13),
                ),
              ],
            ),
          )),
        ],
        controller: widget._tabController,
      ),*/
      actions: [
        /*Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, //remove this when you add image.
            ),
            child: InkWell(
              onTap: () => {},
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 30 / 2,
                backgroundImage: AssetImage('assets/profile-jam.jpg'),
              ),
            ),
          ),
        ),*/
      ],
    );
  }
}
