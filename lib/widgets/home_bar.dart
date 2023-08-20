import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBar extends StatelessWidget {
  HomeBar(this._tabController,
      {Key? key, required this.selectedPageIndex, required this.onIconTap})
      : super(key: key);
  final TabController _tabController;
  final int selectedPageIndex;
  final Function onIconTap;

  void _onProfileImageTapped() {
    onIconTap(3);
    selectedPageIndex == 3;
    print('Profile Image Tapped');
  }

  void _onLogoTapped() {
    onIconTap(0);
    selectedPageIndex == 0;
    print('Logo Tapped');
  }

  int _currentIndex = 0;

  _topBarNavItem(int index, String label) {
    bool isSelected = selectedPageIndex == index;
    //Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;
    Color iconAndTextColor = isSelected ? Colors.amber : Colors.white;

    double defaultHeight = 25;
    double defaultWidth = 25;
    double sizedboxheight = 10;

    debugPrint(selectedPageIndex.toString());
    return GestureDetector(
      onTap: () => {onIconTap(index)},
      child: Text(
        label,
        style: TextStyle(
            color: iconAndTextColor, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      pinned: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        //statusBarColor: Colors.white,
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark,
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
                      //'assets/agila-logo.png',
                      'assets/agila-logo-dark.png',
                      height: 30, //widget._tabController.index == 1 ? 16 : 12,
                      width: 30, //widget._tabController.index == 1 ? 16 : 12,
                      filterQuality: FilterQuality.medium,
                    ),
                  ),
                ]),
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
                      _topBarNavItem(1, 'Interests'),
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
                      _topBarNavItem(2, 'Discover'),
                    ],
                  ),
                ),
                /*Row(children: [Text(' ')]),
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
                      _topBarNavItem(2, 'Shorts'),
                    ],
                  ),
                ),*/
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
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [],
    );
  }
}
