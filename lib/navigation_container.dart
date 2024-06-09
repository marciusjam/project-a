import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Makulay/main.dart';
import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/discover_page.dart';
import 'package:Makulay/screens/home_page.dart';
import 'package:Makulay/screens/interests_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:Makulay/screens/sidemenu_page.dart';
import 'package:Makulay/screens/trending_page.dart';
import 'package:Makulay/widgets/home_bar.dart';
import 'package:Makulay/widgets/login.dart';
import 'package:Makulay/widgets/navigation_bar.dart';
import 'package:Makulay/widgets/post_card.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:Makulay/models/User.dart';
import 'models/ModelProvider.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';

import 'amplifyconfiguration.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';




class NavigationContainer extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String username, userid, profilepicture, email;
  final bool newUser;
  const NavigationContainer(this.cameras, this.username, this.userid, this.profilepicture, this.email, this.newUser, {Key? key}) : super(key: key);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> with TickerProviderStateMixin{
  
  int _selectedBottomTabIndex = 0;
  bool _amplifyConfigured = false;
  
  bool isLoading = false;
  bool fileHasBeenPicked = false;
  
  bool _showAppBar = true;
  

  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final TextEditingController usernameController = TextEditingController();

  List<XFile>? _mediaFileList;
  XFile? _chosenFile = null;
  String _chosenFilePath = '';
  late Future<String?> chosenFile = Future.value(null);
  File? _image;

  String? _retrieveDataError;


  late XFile? globalFile;

  var  _tabController;
  int _selectedPageIndex = 0;

  final int lengthSignedIn = 2;
  final int lengthNotSignedIn = 2;

  var _scrollController;

var tabBarHeight = 60;
      var pinnedHeaderHeight =
          //statusBar height
          20 +
              //pinned SliverAppBar height in header
              kToolbarHeight;


  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  void onIconTap(int index) {
    debugPrint('index ' + index.toString());
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  initState() {
    _scrollController = ScrollController();
    super.initState();
    _tabController = TabController(vsync: this, length: widget.userid != '' ? lengthSignedIn : lengthNotSignedIn, initialIndex: widget.userid != '' ? 0 : 1);
    _tabController.addListener(() {
      setState(() {
        _selectedPageIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
      if(_selectedPageIndex == 0){
        _showAppBar = false;
      }else{
        _showAppBar = true;
      }
    });
    if(widget.userid != ''){
      setState(() {
        _selectedPageIndex = 0;
      });
    }else{
      setState(() {
        _selectedPageIndex = 1;
      });
    }
    //_configureAmplify();
  }

  void _onIconTapped(int index) {
    
    setState(() {
      _selectedPageIndex = index;
    });

    /*f(index == 0){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage(widget.username)),
        );
    }

    if(index == 1){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPostPage(username: widget.username, 
                                            profilepicture: widget.profilepicture,
                                            cameras: widget.cameras,
                                            preentityPaths: [],
                                            preselectedAssets: [],
                                            descriptionController: new TextEditingController())),
        );
    }*/

    /*if(index == 2){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
    }*/

    
  }

  Future<void> getUserByUserIdFunction(String id) async {
    var userData = await getUserByUserId(id);
    debugPrint('getUserByUserIdFunction Response: ' + userData.toString());
  }

  




  Future<void> _createUser(String usernameText, File? imageFile, bool skip) async {
    
      TemporalDateTime dateTimeNow = new TemporalDateTime.withOffset(DateTime.now(), Duration(seconds: 0));
      debugPrint(dateTimeNow.toString());

      /*var uuid = Uuid();
      var v4 = uuid.v4();
      debugPrint(v4.toString());*/
      await Amplify.DataStore.clear();
      debugPrint('skip ' + skip.toString());
      String keyName;
      if(!skip){
        debugPrint('skip ' + skip.toString());
        final awsFile = AWSFilePlatform.fromFile(imageFile!);
        debugPrint('awsFile: '+ awsFile.toString());
        final fileName = DateTime.now().toIso8601String(); 
        final uploadResult = await Amplify.Storage.uploadFile(
          localFile: awsFile,
          key: 'DEV1/' + fileName,
        ).result;
        debugPrint('Uploaded data: ${uploadResult.uploadedItem.key}');
        keyName = uploadResult.uploadedItem.key;
      }else{
        keyName = '';
      }
      
      
      final userData = User(
          id: widget.username,
          userId: widget.userid,
          username: usernameText,
          email: widget.email,
          //phoneNumber: '09190612407',
          //bio:'',
          profilePicture: keyName,
          //backgroundContent: '',
          //createdOn: dateTimeNow
          );
    try {
      await Amplify.DataStore.save(userData);
      //changeSync();
      // Post created successfully, navigate to the next screen or show a success message
      setState(() {
        isLoading = true;
      });

      Future.delayed(const Duration(seconds: 10), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp(widget.cameras)),
          );
      });
    } on DataStoreException catch (e) {
      safePrint('Something went wrong saving model: ${e.message}');
    }
  }

  Future<void> changeSync() async {
    try {
      await Amplify.DataStore.stop();
    } catch (error) {
      debugPrint('Error stopping DataStore: $error');
    }

    try {
      await Amplify.DataStore.start();
    } on Exception catch (error) {
      debugPrint('Error starting DataStore: $error');
    }
  }

  Widget setUsername() {
  return Scaffold(
    appBar: AppBar(backgroundColor: Colors.white,),
      backgroundColor: Colors.white,
      body: Container(
    padding: EdgeInsets.all(30),
    child: 
    Column(
      children: [
      Spacer(),
      Image.asset('assets/welcome.png'),
      Spacer(),
      Text('Give yourself a unique name', style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),),
      SizedBox(height: 20.0),
      TextField(
                  cursorColor: Colors.amber,
                  controller: usernameController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusColor: Colors.amber,
                    labelStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.black12, width: 1.0),
                    ),
                  ),
                ),

                

                SizedBox(height: 20.0),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    primary: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(width: 1.0),
                  ),
                  onPressed: () {
                    debugPrint('Create User: ' +
                        usernameController.text);
              Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => setProfilePicture(null)),
                        );
                    

                    /*Navigator.of(context).pushReplacementNamed(
                                    _isSignedIn ? '/home' : '/confirm',
                                    arguments: _loginData);*/
                  },
                  child: Text('Next') ,
                ),
  ],)));
}

Future<File?> getImageGallery() async{
    final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
    Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => setProfilePicture(_image)),
                        );
    return _image;
  }

  Future _onImageButtonPressed (
    ImageSource source, {
    required BuildContext context
  }) async {
          try  {
            final XFile? pickedFile = await _picker.pickImage(
              source: source
            );
            debugPrint('pickedFile ' + pickedFile!.path.toString());
            globalFile = pickedFile;
            if(pickedFile != null){

                setState(() {
                  _chosenFile = pickedFile;
                  //_setImageFileListFromFile(pickedFile);
                  //_chosenFilePath = pickedFile.path;
                  //fileHasBeenPicked = true;
                });
            } 
          } catch (e) {
            setState(() {
              _pickImageError = e;
            });
          }
        
      
    
  }

  
Widget setProfilePicture(File? imagen) {
  return isLoading ? Center(child: CircularProgressIndicator(),) : Scaffold(
    appBar: AppBar(backgroundColor: Colors.white,actions: [Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0), child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.amber,
                      textStyle: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      debugPrint('Create User: ' +
                        usernameController.text);
                      _createUser(usernameController.text, imagen, true);
                    },
                    child: Text(
                      'Skip',
                    ),
                  ),) 
                     ]),
      backgroundColor: Colors.white,
      body: Container(
    padding: EdgeInsets.all(30),
    child: 
    Column(
      children: [
      Spacer(),

      /*!kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    case ConnectionState.done:
                      return _previewImages();
                    case ConnectionState.active:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image/video error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return const Text(
                          'You have not yet picked an image.',
                          textAlign: TextAlign.center,
                        );
                      }
                  }
                },
              )
            : _previewImages(),*/
      
      Center(
            child: imagen == null
                ? const Text('No image selected.')
                : SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: InkWell(
                                        onTap: () => {},
                                        child: Container(
                                          height: 300,
                                          width: 300,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            child: Container(
                                              height: 295,
                                              width: 295,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: FileImage(File(imagen.path.toString()),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
      ),
          ),
      
      Spacer(),
      SizedBox(height: 50.0),
      Text('Show yourself off. Set a Profile Picture.', style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),),
      SizedBox(height: 20.0),
      OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    primary: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(width: 1.0),
                  ),
                  onPressed: () {
                    debugPrint('Create User: ' +
                        usernameController.text);
                  //_onImageButtonPressed(ImageSource.gallery, context: context);
                  getImageGallery();
                  },
                  child: Text('Select an Image') ,),
      
      
      if(imagen != null)
      SizedBox(height: 20.0),
      if(imagen != null)
      OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    primary: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(width: 1.0),
                  ),
                  onPressed: () {
                    debugPrint('Create User: ' +
                        usernameController.text);
                        _createUser(usernameController.text, imagen, false);
                  },
                  child: Text('Done') ,),

      

                SizedBox(height: 20.0),
                
                
  ],)));
}


  @override
  Widget build(BuildContext context) {
    /*debugPrint('widget.profilepicture ' + widget.profilepicture);
    debugPrint('widget.username ' + widget.username);
    debugPrint('widget.userid ' + widget.userid);
    debugPrint('widget.cameras ' + widget.cameras.toString());*/
    return 
    widget.newUser ? setUsername() : Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      extendBody: false,
      
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 0,
        //expandedHeight: 100,
        centerTitle: true,
        //collapsedHeight: 50,
        backgroundColor: Colors.transparent,
         //selectedPageIndex == 0 ? Colors.transparent: Colors.black,
        //centerTitle: true,
        //pinned: false,
        surfaceTintColor: Colors.transparent,
        //floating: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          //statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light,
        ),),
      body: //NestedScrollView(
      
      TabBarView(
        controller: _tabController,
        children: [
    
        /*if(widget.userid != '')
        
          NewPostPage(
                                          username: widget.username, 
                                                profilepicture: widget.profilepicture,
                                                cameras: widget.cameras,
                                                preselectedAssets: [],
                                                preentityPaths: [],
                                                descriptionController: new TextEditingController(),
                                        ),*/
        if(widget.userid != '')
          SideMenuPage(widget.profilepicture, widget.username, widget.userid, widget.cameras, selectedPageIndex: _selectedPageIndex, onIconTap:onIconTap),
      
        if(widget.userid == '')
          Login(widget.cameras),

        if(widget.userid != '')
          InterestsPage(profilepicture: widget.profilepicture, username: widget.username, userid: widget.userid, cameras: widget.cameras, selectedPageIndex: _selectedPageIndex, onIconTap:onIconTap),

          /*TrendingPage(),
          TrendingPage(),*/

          //DiscoverPage(widget.profilepicture, widget.username, widget.userid, widget.cameras),
        ],  
      ),
      
      
      


    /*if(widget.userid != '')
      ChatPage(widget.cameras),*/
  
      bottomNavigationBar: widget.userid != '' ? //Visibility(visible: _showAppBar, child: 
      NavigationBottomBar(selectedPageIndex: _selectedBottomTabIndex, onIconTap: _onIconTapped, widget.username, widget.profilepicture, widget.cameras)
      //) 
      : null
    );
    //bottomNavigationBar: NavigationBottomBar( selectedPageIndex: _selectedPageIndex, onIconTap: _onIconTapped));
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);


