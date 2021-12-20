import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar(
      {Key? key, required this.selectedPageIndex, required this.onIconTap})
      : super(key: key);
  final int selectedPageIndex;
  final Function onIconTap;

  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.of(context).size.height * 0.06;
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11);
    return BottomAppBar(
      elevation: 0,
      child: Container(
        height: barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _bottomBarNavItem(0, 'Home', style, 'home'),
            _bottomBarNavItem(1, 'Search', style, 'trending'),
            _bottomBarNavItem(2, 'NewPost', style, 'newpost'),
            _bottomBarNavItem(3, 'Chat', style, 'chat'),
            //_bottomBarNavItem(3, 'Profile', style, 'profile'),
          ],
        ),
      ),
    );
  }

  _bottomBarNavItem(
      int index, String label, TextStyle textStyle, String iconName) {
    bool isSelected = selectedPageIndex == index;
    Color iconAndTextColor = isSelected ? Colors.amber : Colors.black;

    double defaultHeight = 25;
    double defaultWidth = 25;

    if (iconName == 'newpost') {
      defaultHeight = 25;
      defaultWidth = 25;
    }

    return GestureDetector(
        onTap: () => {onIconTap(index)},
        child: Column(
          //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
          children: [
            SizedBox(
              height: 10,
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
