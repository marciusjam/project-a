import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Favorites {
  String chatType;
  List<String> users;
  String chatName;
  List<String> profilepicture;
  List<String> series;
  bool favorite;
  String newCount;
  Favorites(this.chatType, this.users, this.chatName, this.profilepicture,
      this.series, this.favorite, this.newCount);
}

class DiscoverNavigationBottomBar extends StatefulWidget {
  const DiscoverNavigationBottomBar(this.username, this.profilepicture, this.cameras,
      {required this.onTabTapped, Key? key, })
      : super(key: key);
  final String username;
  final String profilepicture;
  final List<CameraDescription> cameras;
  final Function(int) onTabTapped;


  @override
  State<DiscoverNavigationBottomBar> createState() => _DiscoverNavigationBottomBarState();
}

class _DiscoverNavigationBottomBarState extends State<DiscoverNavigationBottomBar> {
  int _selectedIndex = 0;


  static const List<Widget> _widgetOptions = <Widget>[
    Text('Discover'),
    Text('Shop'),
    Text('Live'),
    Text('Podcasts'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabTapped(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
   
    final barHeight = MediaQuery.of(context).size.height * 0.05;
    //final style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 11);

    

    List<Widget> tabbarWidgets = [
      Container(
          height: 85,
          //width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Container(
                  color: Color.fromRGBO(00, 00, 00, 0.5),
                  padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                  //width: MediaQuery.of(context).size.width,
                  child: Row(children: [
                    Container(
                        //width: MediaQuery.sizeOf(context).width - 145,
                        child: Row(
                      children: [
                        Container(
                      //width: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 10, 0),
                              child: GestureDetector(
                                  onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActivitiesPage()),
                                        )
                                      },
                                  child: 
                                  Icon(Icons.add_circle_rounded, color: Colors.white, size: 37,)))
                                  
                        ],
                      ),
                    ),

                    Container(
                      //width: 50,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 10, 0),
                              child: GestureDetector(
                                  onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActivitiesPage()),
                                        )
                                      },
                                  child: 
                                  Icon(Icons.volume_off_rounded, color: Colors.white, size: 35,)))
                                  
                        ],
                      ),
                    ),
                     //),
                      ],
                    ))
                  ]))))
    ];

    return Theme(
    data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child:Container(
      color: Colors.black,
      height: 85,
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Following',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            label: 'Podcasts',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        enableFeedback: false,
        selectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
        unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
        unselectedLabelStyle: TextStyle(fontSize: 11),
        selectedLabelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      
        onTap: _onItemTapped,
      ),)
    
      
      /*ListView.builder(
          //physics: NeverScrollableScrollPhysics()
          //controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: tabbarWidgets.length,
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
          itemBuilder: (BuildContext context, int index) {
            return tabbarWidgets[index];
          }),*/
    )
        //for (var tabby in tabbarWidgets)
        //tabby
        ;
  }
}
