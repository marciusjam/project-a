import 'package:Makulay/widgets/new_post_widgets/camera_widget.dart';
import 'package:Makulay/widgets/new_post_widgets/description_page.dart';
import 'package:Makulay/widgets/new_post_widgets/media_widget.dart';
import 'package:Makulay/widgets/new_post_widgets/podcast_widget.dart';
import 'package:Makulay/widgets/new_post_widgets/stream_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_manager/photo_manager.dart';

class NewPostPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String username;
  final String profilepicture;
  final List<AssetEntity> preselectedAssets;
   final List<String> preentityPaths;
   final TextEditingController descriptionController;
   final Function? onIconTap;
  final int? selectedPageIndex;
  const NewPostPage({Key? key, required this.username, required this.profilepicture, required this.cameras, required this.preselectedAssets, required this.preentityPaths, required this.descriptionController, required this.onIconTap, required this.selectedPageIndex}) : super(key: key);

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('descriptionController value' + widget.descriptionController.text);
    //
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSwipeRight() {
    _selectedIndex = _currentPage;
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
      _selectedIndex = index;
    });
  }

  void _onRightSwipe(int index) {
    int finalIndex = index;
    widget.onIconTap!(finalIndex);
    widget.selectedPageIndex == finalIndex;
    print('Tab Clicked ' + finalIndex.toString());
  }

  

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
    if (dragEndDetails.primaryVelocity! < 0 ) {
     Navigator.pop(context);
    }},
      child: Scaffold(
     /*appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.black,
              //statusBarColor: Colors.black,
              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
              statusBarBrightness: Brightness.dark),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context, true),
              child: Icon(Icons.close_rounded, color: Colors.white,),
            ),
          ),
        ),*/
      body: /*GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            // Swipe right
            _onSwipeRight();
          }
        },
        child:*/ IndexedStack(
    index: //widget.preselectedAssets.isEmpty || 
    widget.descriptionController.text.isEmpty ? widget.preselectedAssets.isEmpty ? _currentPage : 1 : 1,
    children: [
      //StreamWidget(),
      CameraWidget(widget.cameras),
            TextMediaWidget(widget.username, widget.profilepicture, widget.cameras, widget.preselectedAssets, widget.preentityPaths, widget.descriptionController),
            StreamWidget(),
            PodcastWidget()
            ],
  ),
  /*PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: [
            
          ],
        ),*/
      //),
      bottomNavigationBar: Theme(
    data: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child:
    Container(
      height: 85,
      padding: EdgeInsets.fromLTRB(0,0,0,0),
      child: 
    BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          /*BottomNavigationBarItem(
            icon: Icon(Icons.fiber_new_outlined),
            label: 'Message',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Stream',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Podcast',
          ),
          
        ],
        enableFeedback: false,
        currentIndex: //widget.preselectedAssets.isEmpty || 
        widget.descriptionController.text.isEmpty ? widget.preselectedAssets.isEmpty ? _currentPage : 1 : 1,
        selectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
        unselectedIconTheme: IconThemeData(opacity: 0.0, size: 0),
        unselectedLabelStyle: TextStyle(fontSize: 15),
        selectedLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    )))
    )
    ;
  }
}
