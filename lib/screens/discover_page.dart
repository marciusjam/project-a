import 'package:Makulay/screens/live_page.dart';
import 'package:Makulay/screens/podcast_page.dart';
import 'package:Makulay/screens/posts_page.dart';
import 'package:Makulay/screens/shop_page.dart';
import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:Makulay/widgets/discover_navigation_bar.dart';
import 'package:Makulay/widgets/navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Verts {
  List<String> taggedUsers;
  String username;
  String profilepicture;
  List<String> vert;
  String description;
  String likes;
  String shares;
  String comments;
  Verts(this.taggedUsers, this.username, this.profilepicture, this.vert,
      this.description, this.likes, this.shares, this.comments);
}

class DiscoverPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String profilepicture;
  final String username;
  final String userid;

  const DiscoverPage(
       this.profilepicture, this.username, this.userid, this.cameras,
      {Key? key})
      : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  PageController? controller;
  int currentIndex = 0;
  String dropdownValue = 'Explore';
  int selectedIndex = 0;

  List<Verts> vertsArray = [
    Verts(
        ['shayecrispo'],
        'shayecrispo',
        'assets/profile-shaye.jpg',
        [
          'assets/series_3.mp4',
        ],
        'Ang daming ganap ngayon pero laban lang! 🤍 Minsan mapapagod, pero tuloy-tuloy pa rin ang pangarap. Huwag susuko, kaya mo yan! 💪✨',
        '120',
        '300',
        '10'),
    Verts(
        ['shayecrispo'],
        'marciusjam',
        'assets/profile-jam.jpg',
        [
          'assets/series_1.mp4',
        ],
        'Grabe, sobrang traffic na naman! 😩 Pero okay lang, at least safe tayo. Ingat palagi, mga kaibigan! 🙏🚗💨',
        '1.1k',
        '30',
        '2k'),
    Verts(
        ['shayecrispo'],
        'kapitanamerica',
        'assets/grid_image_2.png',
        [
          'assets/series_2.mp4',
        ],
        'Feeling blessed ngayon kahit sobrang daming trabaho. 😌 Minsan pagod na pero grateful pa rin sa lahat ng opportunities. Hindi laging madali, pero worth it ang lahat ng paghihirap. Salamat sa mga kaibigan at pamilya na laging nandyan para sumuporta. Tuloy lang sa laban, basta huwag kalimutan magpahinga! 💖✨',
        '10m',
        '30.5k',
        '100k'),
  ];

  void handleTabTapped(int index) {
    // Handle the index here
    setState(() {
      selectedIndex = index;
    });
    print("Bottom Navigation Tapped Index: $index");
  }

  @override
  void initState() {
    controller = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  /*void _onLeftSwipe(int index) {
    int finalIndex = index;
    widget.onIconTap(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + finalIndex.toString());
  }*/

  Route _routeToNewPost() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DiscoverPage(
              widget.profilepicture,
              widget.username,
              widget.userid,
              widget.cameras,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1, 0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return 
   
    GestureDetector(
        onHorizontalDragEnd: (dragEndDetails) {
          if (dragEndDetails.primaryVelocity! > 0) {
            Navigator.pop(context);
          } else {
            //_onLeftSwipe(0);
          }
        },
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: selectedIndex == 0 ? true : false,

    backgroundColor:  selectedIndex == 0 ? Colors.black : Colors.white,
          appBar: AppBar(
            toolbarHeight: selectedIndex != 0 ? 0 : 50,
      automaticallyImplyLeading: false, // Removes the default back button
      surfaceTintColor: selectedIndex == 0 ? Colors.transparent : Colors.white,
      backgroundColor: selectedIndex == 0 ? Colors.transparent : Colors.white,
      title: selectedIndex == 0 ? Padding(
        padding: EdgeInsets.only(left: 20), // Adds 20 padding to the left
        child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: Colors.black87, // Background color of dropdown menu
          icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Dropdown icon color
          underline: Container(), // Removes the default underline
          items: <String>['Explore', 'Trending'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.white), // Text color
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
      ) : null,
      centerTitle: false, // Aligns the dropdown to the left
      actions: [selectedIndex == 0 ?
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.white), // Options menu icon
          onSelected: (String choice) {
            // Handle menu item selections here
            switch (choice) {
              case 'Report':
                // Handle the "Report" action
                break;
              case 'Settings':
                // Handle the "Settings" action
                break;
              case 'Help':
                // Handle the "Help" action
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return <String>['Report', 'Settings', 'Help']
                .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ) : Container()
      ],
    ),
          body:  
          
          selectedIndex == 0 ? 
          Stack(
            children: [
              PageView(
                scrollDirection: Axis.vertical,
                onPageChanged: onchahged,
                controller: controller,
                children: [
                  for (var verty in vertsArray)
                    CustomVideoPlayer(
                        'verts',
                        verty.vert[0],
                        MediaQuery.sizeOf(context).height - 85,
                        verty.description,
                        verty.username,
                        verty.profilepicture,
                        1,
                        null,
                        true,
                        null,
                        verty.likes,
                        verty.comments,
                        verty.shares)
                ],
              ),
              
              /*Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: double.infinity,
                    height: 105,
                    padding: EdgeInsets.all(13.0),
                    color: Colors.transparent,
                    child: Stack(
                      children: <Widget>[
                      Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0), 
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                                padding: EdgeInsets.all(4.0),
                                child: Row(children: [
                                  Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ), 
                                ],) 
                               
                                ),
                          ),
                        ),
                      ),)
                      
                      
                    ]))),*/
              //Align(
              //alignment: Alignment.bottomCenter,
              /////POSITIONED

              /*Positioned(
            bottom: 30,
            right: 10,
            child: Column(
              children: [
                Icon(
                  Icons.ac_unit,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.image,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.person_add,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
          )*/
            ],
          ) : selectedIndex == 1 ? 
          ShopPage() : selectedIndex == 2 ? 
          LivePage() : selectedIndex == 3 ? 
          PodcastPage() : Container(),
          
          bottomNavigationBar: DiscoverNavigationBottomBar(
              widget.username, widget.profilepicture, widget.cameras, onTabTapped: handleTabTapped),
          
          //)
        ));
  }

  onchahged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
