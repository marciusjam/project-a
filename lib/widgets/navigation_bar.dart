import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar(this._tabController,
      {Key? key, required this.selectedPageIndex, required this.onIconTap})
      : super(key: key);
  final int selectedPageIndex;
  final Function onIconTap;
  final TabController _tabController;
  @override
  Widget build(BuildContext context) {
    final barHeight = MediaQuery.of(context).size.height * 0.05;
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11);
    
    return 
   /* Container(
      
      padding: EdgeInsets.fromLTRB(100,50,100,0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50)), 
        child: SizedBox(
          //height: 50,
          //color: Colors.black, 
          child:*/  /*TabBar(
            controller: _tabController,
            tabs: [_bottomBarNavItem(1, 'NewPost', style, 'newpost'),
            _bottomBarNavItem(2, 'Search', style, 'search'),]

            )*/
          
          
          
          BottomAppBar(
      //height: 30,
      height: 45,
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
      color: Colors.black,
      /*shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
    ),*/
      elevation: 0,
      child: Container(
        //height: barHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            //_bottomBarNavItem(0, 'Home', style, 'home'),
            //_bottomBarNavItem(1, 'Search', style, 'trending'),
            _bottomBarNavItem(0, 'Search', style, 'search'),
            _bottomBarNavItem(1, 'NewPost', style, 'newpost'),
            _bottomBarNavItem(2, 'Search', style, 'search'),
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


    
  //,),));
    
   }

  _bottomBarNavItem(
      int index, String label, TextStyle textStyle, String iconName) {
    bool isSelected = selectedPageIndex == index;
    //Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;
    //Color iconAndTextColor = isSelected ? Colors.amber : Colors.black12;

    double defaultHeight = 25;
    double defaultWidth = 25;
    double sizedboxheight = 10;

    if (index == 0) {
      defaultHeight = 25;
      defaultWidth = 25;
      sizedboxheight = 0;
    }

    if (index == 1) {
      defaultHeight = 30;
      defaultWidth = 30;
      sizedboxheight = 0;
    }

    if (index == 2) {
      defaultHeight = 26;
      defaultWidth = 26;
      sizedboxheight = 0;
    }

    return 
    GestureDetector(
        onTap: () => {onIconTap(index)},
        child: Column(
          //children: [SvgPicture.asset('assets/${isSelected ? iconName + '_filled' : iconName}'),],
          children: [
            /*SizedBox(
              height: sizedboxheight,
            ),*/
            if(index == 0) Icon(Icons.search, size: 35.0, color: Colors.white),
            if(index == 1) Icon(Icons.add, size: 35.0, color: Colors.white),
            if(index == 2) Icon(Icons.notifications_none_outlined, size: 35.0, color: Colors.white),
            
            /*SvgPicture.asset(
              'assets/$iconName.svg',
              height: defaultHeight,
              width: defaultWidth,
              fit: BoxFit.fill,
              color: Colors.white,
            ),*/

            /*Text(
              label,
              style: TextStyle(color: Colors.white),
            )*/
          ],
        )); 
  }
}
