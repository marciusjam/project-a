import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar(
      {Key? key, required this.selectedPageIndex, required this.onIconTap})
      : super(key: key);
  final int selectedPageIndex;
  final Function onIconTap;

  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.of(context).size.height * 0.06;
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11);
    return BottomAppBar(
      color: Colors.black,
      elevation: 0,
      child: Container(
        height: barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /*GestureDetector(
                onTap: () => {onIconTap(0)},
                child: Column(
                    //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("agila",
                          style: GoogleFonts.lexendDeca(
                              color: Colors.amber,
                              fontSize: 23,
                              fontWeight: FontWeight.bold)),
                    ])),*/
            _bottomBarNavItem(0, 'Home', style, 'home'),
            //_bottomBarNavItem(1, 'Search', style, 'trending'),
            _bottomBarNavItem(1, 'NewPost', style, 'newpost'),
            _bottomBarNavItem(2, 'Chat', style, 'chat'),
            /*GestureDetector(
                onTap: () => {onIconTap(3)},
                child: Column(
                    //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
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
                            backgroundImage:
                                AssetImage('assets/profile-jam.jpg'),
                          ),
                        ),
                      ),
                    ]))*/
            //_bottomBarNavItem(3, 'Profile', style, 'profile'),
          ],
        ),
      ),
    );
  }

  _bottomBarNavItem(
      int index, String label, TextStyle textStyle, String iconName) {
    bool isSelected = selectedPageIndex == index;
    //Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;
    Color iconAndTextColor = isSelected ? Colors.amber : Colors.white;

    double defaultHeight = 25;
    double defaultWidth = 25;
    double sizedboxheight = 10;

    if (iconName == 'newpost') {
      defaultHeight = 25;
      defaultWidth = 25;
    }

    if (iconName == 'chat') {
      defaultHeight = 21;
      defaultWidth = 21;
      sizedboxheight = 13;
    }

    return GestureDetector(
        onTap: () => {onIconTap(index)},
        child: Column(
          //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
          children: [
            SizedBox(
              height: sizedboxheight,
            ),
            SvgPicture.asset(
              'assets/$iconName.svg',
              height: defaultHeight,
              width: defaultWidth,
              fit: BoxFit.scaleDown,
              color: iconAndTextColor,
            ),

            /*Text(
              label,
              style: textStyle.copyWith(color: iconAndTextColor),
            )*/
          ],
        ));
  }
}
