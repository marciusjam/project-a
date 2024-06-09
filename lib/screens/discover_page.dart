import 'package:Makulay/widgets/custom_videoplayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    controller = PageController();
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
      const begin = Offset(-1,0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
}
  );
}

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
    if (dragEndDetails.primaryVelocity! > 0 ) {
      Navigator.pop(context);
    }else{
      //_onLeftSwipe(0);
    } },
      child:
    Scaffold(
      
      body: 
      Stack(
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            onPageChanged: onchahged,
            controller: controller,
            children: [
              CustomVideoPlayer(
                    'verts', 'assets/series_1.mp4', MediaQuery.sizeOf(context).height, '', widget.username, widget.profilepicture, 1, null, true, null),
              CustomVideoPlayer(
                    'verts', 'assets/series_2.mp4', MediaQuery.sizeOf(context).height, '', widget.username, widget.profilepicture, 1, null, true, null),
              
              CustomVideoPlayer(
                    'verts', 'assets/series_3.mp4', MediaQuery.sizeOf(context).height, '', widget.username, widget.profilepicture, 1, null, true, null),
              
            ],
          ),
          Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: double.infinity,
                    height: 105,
                    padding: EdgeInsets.all(13.0),
                    color: Colors.transparent,
                    child: Stack(children: <Widget>[
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
                                /*Image.asset(
                            'assets/images/shutter_1.png',
                            width: 72.0,
                            height: 72.0,
                          ),*/
                                ),
                          ),
                        ),
                      ),)
                      
                    ]))),
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
      ),
      
    ));
  }

  onchahged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}