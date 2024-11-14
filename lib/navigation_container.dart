import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Makulay/main.dart';
import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/screens/activities_page.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/discover_page.dart';
import 'package:Makulay/screens/home_page.dart';
import 'package:Makulay/screens/interests_page.dart';
import 'package:Makulay/screens/live_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/podcast_page.dart';
import 'package:Makulay/screens/posts_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:Makulay/screens/shop_page.dart';
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

List<String> categories = ["New", "Following", "Discover"];

class NavigationContainer extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String username, userid, profilepicture, email;
  final bool newUser;
  const NavigationContainer(this.cameras, this.username, this.userid,
      this.profilepicture, this.email, this.newUser,
      {Key? key})
      : super(key: key);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer>
    with TickerProviderStateMixin {
  int currentIndex = 1;
  PageController? controller;

  String selectedCategory = "Following";

  final ScrollController _categoryScrollController = ScrollController();

  var _tabbercontroller;

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

  var _tabController;
  int _selectedPageIndex = 0;

  final int lengthSignedIn = 0;
  final int lengthNotSignedIn = 1;

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
    controller = PageController(
      initialPage: 1,
    );
    super.initState();
    _tabbercontroller = TabController(vsync: this, length: 2, initialIndex: 0);
    _tabController = TabController(
        vsync: this,
        length: widget.userid != '' ? lengthSignedIn : lengthNotSignedIn,
        initialIndex: widget.userid != '' ? 1 : 0);
    _tabController.addListener(() {
      setState(() {
        _selectedPageIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
      if (_selectedPageIndex == 0) {
        _showAppBar = false;
      } else {
        _showAppBar = true;
      }
    });
    if (widget.userid != '') {
      setState(() {
        _selectedPageIndex = 0;
      });
    } else {
      setState(() {
        _selectedPageIndex = 1;
      });
    }
    //_configureAmplify();
  }

  @override
  void dispose() {
    controller!.dispose();
    _categoryScrollController.dispose();
    super.dispose();
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

  Future<void> _createUser(
      String usernameText, File? imageFile, bool skip) async {
    TemporalDateTime dateTimeNow =
        new TemporalDateTime.withOffset(DateTime.now(), Duration(seconds: 0));
    debugPrint(dateTimeNow.toString());

    /*var uuid = Uuid();
      var v4 = uuid.v4();
      debugPrint(v4.toString());*/
    await Amplify.DataStore.clear();
    debugPrint('skip ' + skip.toString());
    String keyName;
    if (!skip) {
      debugPrint('skip ' + skip.toString());
      final awsFile = AWSFilePlatform.fromFile(imageFile!);
      debugPrint('awsFile: ' + awsFile.toString());
      final fileName = DateTime.now().toIso8601String();
      final uploadResult = await Amplify.Storage.uploadFile(
        localFile: awsFile,
        key: 'DEV1/' + fileName,
      ).result;
      debugPrint('Uploaded data: ${uploadResult.uploadedItem.key}');
      keyName = uploadResult.uploadedItem.key;
    } else {
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
  //aws account put-contact-information --account-id 306971405788 --contact-information '{"PhoneNumber": "+639190612407", "AddressLine1": "B8 Lot 35-36 Patience St. Brgy. Mabuhay", "City": "Carmona", "CountryCode": "PH", "FullName": "John Marcius Tolentino", "PostalCode": "4116"}'
  //aws account put-contact-information --contact-information '{"PhoneNumber": "+639190612407", "AddressLine1": "B8 Lot 35-36 Patience St. Brgy. Mabuhay", "City": "Carmona", "CountryCode": "PH", "FullName": "John Marcius Tolentino", "PostalCode": "4116"}'
  //aws account put-contact-information --contact-information '{"PhoneNumber": "+639988505037", "AddressLine1": "B8 Lot 35-36 Patience St. Brgy. Mabuhay", "City": "Carmona", "CountryCode": "PH", "FullName": "John Marcius Tolentino", "PostalCode": "4116"}'

  //aws organizations enable-aws-service-access --service-principal account.amazonaws.com

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
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Spacer(),
                Image.asset('assets/welcome.png'),
                Spacer(),
                Text(
                  'Give yourself a unique name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
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
                    //primary: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    side: BorderSide(width: 1.0),
                  ),
                  onPressed: () {
                    debugPrint('Create User: ' + usernameController.text);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => setProfilePicture(null)),
                    );

                    /*Navigator.of(context).pushReplacementNamed(
                                    _isSignedIn ? '/home' : '/confirm',
                                    arguments: _loginData);*/
                  },
                  child: Text('Next'),
                ),
              ],
            )));
  }

  Future<File?> getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => setProfilePicture(_image)),
    );
    return _image;
  }

  Future _onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      debugPrint('pickedFile ' + pickedFile!.path.toString());
      globalFile = pickedFile;
      if (pickedFile != null) {
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
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(backgroundColor: Colors.white, actions: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    //primary: Colors.amber,
                    textStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    debugPrint('Create User: ' + usernameController.text);
                    _createUser(usernameController.text, imagen, true);
                  },
                  child: Text(
                    'Skip',
                  ),
                ),
              )
            ]),
            backgroundColor: Colors.white,
            body: Container(
                padding: EdgeInsets.all(30),
                child: Column(
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
                                        backgroundImage: FileImage(
                                          File(imagen.path.toString()),
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
                    Text(
                      'Show yourself off. Set a Profile Picture.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
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
                        //primary: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        side: BorderSide(width: 1.0),
                      ),
                      onPressed: () {
                        debugPrint('Create User: ' + usernameController.text);
                        //_onImageButtonPressed(ImageSource.gallery, context: context);
                        getImageGallery();
                      },
                      child: Text('Select an Image'),
                    ),
                    if (imagen != null) SizedBox(height: 20.0),
                    if (imagen != null)
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
                          //primary: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          side: BorderSide(width: 1.0),
                        ),
                        onPressed: () {
                          debugPrint('Create User: ' + usernameController.text);
                          _createUser(usernameController.text, imagen, false);
                        },
                        child: Text('Done'),
                      ),
                    SizedBox(height: 20.0),
                  ],
                )));
  }

  void _scrollToSelectedChip(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chipWidth =
        120.0; // Approximate width of each chip, including padding
    double totalChipWidth = chipWidth * categories.length;

    // Calculate the position to scroll so the selected chip appears in the center
    double targetScrollOffset =
        (chipWidth * index) - (screenWidth / 2) + (chipWidth / 2);
    targetScrollOffset =
        targetScrollOffset.clamp(0.0, totalChipWidth - screenWidth);

    _categoryScrollController.jumpTo(
      targetScrollOffset,
    );
  }

  Route _routeToNewPost() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NewPostPage(
              username: widget.username,
              profilepicture: widget.profilepicture,
              cameras: widget.cameras,
              preselectedAssets: [],
              preentityPaths: [],
              descriptionController: new TextEditingController(),
              onIconTap: onIconTap,
              selectedPageIndex: 0,
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

  Route _routeToDiscover() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DiscoverPage(
              widget.profilepicture,
              widget.username,
              widget.userid,
              widget.cameras,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
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
    /*debugPrint('widget.profilepicture ' + widget.profilepicture);
    debugPrint('widget.username ' + widget.username);
    debugPrint('widget.userid ' + widget.userid);
    debugPrint('widget.cameras ' + widget.cameras.toString());*/
    return widget.newUser
        ? setUsername()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            extendBody: selectedCategory != 'Discover' ? true : false,
            extendBodyBehindAppBar:
                selectedCategory == 'Discover' ? true : false,
            /*appBar: AppBar(
              titleSpacing: 0,
              toolbarHeight: 50,
              //expandedHeight: 100,
              centerTitle: true,
              //collapsedHeight: 50,
              backgroundColor: selectedCategory == 'Discover'
                  ? Colors.transparent //Colors.transparent
                  : Colors.white,

              //selectedPageIndex == 0 ? Colors.transparent: Colors.black,
              //centerTitle: true,
              //pinned: false,
              surfaceTintColor: Colors.transparent,
              //floating: true,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                //statusBarColor: Colors.black,
                statusBarIconBrightness: 
                //selectedCategory == 'Discover'
                    //? 
                    Brightness.light,
                    //: Brightness.dark, // For Android (dark icons)
                statusBarBrightness: 
                //selectedCategory == 'Discover'
                    //? 
                    Brightness.dark,
                    //: Brightness.light,
              ),
              title:
                  //currentIndex != 0 ?
                  Container(
                height: 40,
                child: Row(
                    children: [
                      /*categories.asMap().entries.map((entry) {
                                int index = entry.key;
                                String category = entry.value;*/

                      //return category == 'Makulay'
                      //?

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Following';
                          });
                          controller?.jumpToPage(2);
                          //_scrollToSelectedChip(1);
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 5),
                            child: Row(
                              children: [
                                Text(
                                  'ma',
                                  style: TextStyle(
                                    color: //selectedCategory == 'Following' || selectedCategory == 'Shop' || selectedCategory == 'Live' || selectedCategory == 'Podcasts' ? 
                                    Colors.orange 
                                    //: Colors.grey[100]
                                    ,
                                    fontSize: 30,
                                    fontFamily: 'Gotham-Black',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'kulay',
                                  style: TextStyle(
                                    color: //selectedCategory == 'Following' || selectedCategory == 'Shop' || selectedCategory == 'Live' || selectedCategory == 'Podcasts' ? 
                                    Colors.amber 
                                    //: Colors.grey[100]
                                    ,
                                    fontSize: 30,
                                    fontFamily: 'Gotham-Black',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )),
                      ),

                      /*Container(
                          padding:
                              //faves[index].chatType == 'group'
                              //?  profileindex == 0 ? EdgeInsets.fromLTRB(10, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0)
                              //:
                              EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            label: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: CircleAvatar(
                                  radius: 14,
                                  backgroundImage: CachedNetworkImageProvider(
                                      widget.profilepicture),
                                ),), 
                                Text(
                                  'marciusjam',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            surfaceTintColor: Colors.transparent,
                            selected: true,
                            showCheckmark: false,
                            padding: EdgeInsets.all(0),
                          )),*/
                      Spacer(),
                      /*Container(
                        //padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.people_rounded,
                          size: 30,
                          color: selectedCategory == 'Following'
                              ? Colors.amber
                              : Colors.grey[100],
                        ),
                      ),*/

                      /*GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Makulay';
                          });
                          controller?.jumpToPage(2);
                          //_scrollToSelectedChip(1);
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                            child: Row(
                              children: [
                                Text(
                                  'ma',
                                  style: TextStyle(
                                    color: //selectedCategory == 'Makulay' ? 
                                    Colors.orange 
                                    //: Colors.grey[400]
                                    ,
                                    fontSize: 25,
                                    fontFamily: 'Gotham-Black',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'kulay',
                                  style: TextStyle(
                                    color: //selectedCategory == 'Makulay' ? 
                                    Colors.amber 
                                    //: Colors.grey[400]
                                    ,
                                    fontSize: 25,
                                    fontFamily: 'Gotham-Black',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )),
                      ),*/

                      GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ActivitiesPage()),
                                )
                              },
                          child: Container(
                              //padding: const EdgeInsets.only(right: 10.0),
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Image.asset(
                                'assets/discover.png',
                                height: 23,
                                width: 23,
                                filterQuality: FilterQuality.high,
                                color: selectedCategory == 'Discover'
                                    ? Colors.amber
                                    : Colors.grey[100],
                              ))),

                      Container(
                        //padding: const EdgeInsets.only(right: 10.0),
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Icon(
                          Icons.store_mall_directory_rounded,
                          size: 30,
                          color: selectedCategory == 'Shop'
                              ? Colors.amber
                              : Colors.grey[100],
                        ),
                      ),

                      Container(
                        //padding: const EdgeInsets.only(right: 10.0),
                        padding: EdgeInsets.fromLTRB(0, 0, 17, 0),
                        child: Icon(
                          Icons.ondemand_video_rounded,
                          size: 29,
                          color: selectedCategory == 'Live'
                              ? Colors.amber
                              : Colors.grey[100],
                        ),
                      ),

                      Container(
                        //padding: const EdgeInsets.only(right: 10.0),
                        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Icon(
                          Icons.mic,
                          size: 29,
                          color: selectedCategory == 'Podcasts'
                              ? Colors.amber
                              : Colors.grey[100],
                        ),
                      ),

                      /*ChoiceChip(
                                          label: Text(category),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5,
                                          ),
                                          labelStyle: TextStyle(
                                            color: selectedCategory == category
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          selected:
                                              selectedCategory == category,
                                          selectedColor: Colors.black,
                                          showCheckmark: false,
                                          backgroundColor: Colors.grey[100],
                                          onSelected: (bool selected) {
                                            setState(() {
                                              selectedCategory = category;
                                            });
                                            controller?.jumpToPage(index);
                                            //_scrollToSelectedChip(index + 1);
                                          },
                                        ),*/
                    ]),
              )
              //: null
              ,
              /*leading: currentIndex != 0 ? IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  print('Search Icon Tapped');
                },
              ) : null,
              actions: [
                currentIndex != 0 ? IconButton(
                  icon: Icon(Icons.message, color: Colors.black),
                  onPressed: () {
                    print('Message Icon Tapped');
                  },
                ) : IconButton(
                  icon: Icon(Icons.message, color: Colors.transparent),
                  onPressed: () {
                    print('Message Icon Tapped');
                  },
                ),
              ],*/
            ),
            */
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      toolbarHeight: 0,
                      /*leading: Builder(builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    );
                  }),*/

                      surfaceTintColor: Colors.white,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.transparent,
                        //statusBarColor: Colors.black,
                        statusBarIconBrightness: 
                            Brightness.dark,
                        statusBarBrightness: Brightness.light
                      ),
                      pinned: true,
                      floating: false,
                      expandedHeight: 0,
                      backgroundColor: Colors.white
                      /*bottom: selectedCategory == 'Following'
                          ? TabBar(
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              tabs: [
                                Tab(
                                  child: Icon(Icons.favorite_rounded,
                                      size: 30, color: Colors.amber),
                                ),
                                Tab(
                                  child: Icon(Icons.dynamic_feed_sharp,
                                      size: 30, color: Colors.grey.shade400),
                                ),
                              ],
                              controller: _tabbercontroller,
                            )
                          : null,*/

                      //centerTitle: true,

                      /*title: Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = categories[currentIndex - 1];
                                  });
                                  controller?.jumpToPage(currentIndex - 1);
                                  //_scrollToSelectedChip(1);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width / 3 - 15,
                                  //padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    categories[currentIndex] == 'Following'
                                        ? ''
                                        : categories[currentIndex - 1],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: categories[currentIndex] ==
                                                'Discover'
                                            ? Colors.grey.shade100
                                            : Colors.grey.shade400),
                                  ),
                                ),
                              ),
                              Container(
                                  //padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.sizeOf(context).width / 3 - 15,
                                  child: categories[currentIndex] == 'Following'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ma',
                                              style: TextStyle(
                                                color: //selectedCategory == 'Following' || selectedCategory == 'Shop' || selectedCategory == 'Live' || selectedCategory == 'Podcasts' ?
                                                    Colors.orange
                                                //: Colors.grey[100]
                                                ,
                                                fontSize: 29,
                                                fontFamily: 'Gotham-Black',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'kulay',
                                              style: TextStyle(
                                                color: //selectedCategory == 'Following' || selectedCategory == 'Shop' || selectedCategory == 'Live' || selectedCategory == 'Podcasts' ?
                                                    Colors.amber
                                                //: Colors.grey[100]
                                                ,
                                                fontSize: 29,
                                                fontFamily: 'Gotham-Black',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )
                                      : Text(
                                          categories[currentIndex],
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: categories[currentIndex] ==
                                                      'Discover'
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = categories[currentIndex + 1];
                                  });
                                  controller?.jumpToPage(currentIndex + 1);
                                  //_scrollToSelectedChip(1);
                                },
                                child:
                              Container(
                                  alignment: Alignment.center,
                                  //padding: EdgeInsets.only(right: 20),
                                  width:
                                      MediaQuery.sizeOf(context).width / 3 - 15,
                                  child: Text(
                                    categories[currentIndex] == 'Podcasts'
                                        ? ''
                                        : categories[currentIndex + 1],
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: categories[currentIndex] ==
                                                'Discover'
                                            ? Colors.grey.shade100
                                            : Colors.grey.shade400),
                                  ))
                              )
                            ],
                          )
                          /*ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              /*categories.asMap().entries.map((entry) {
                                int index = entry.key;
                                String category = entry.value;*/

                              //return category == 'Makulay'
                              //?

                              /*GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = 'Following';
                              });
                              controller?.jumpToPage(2);
                              //_scrollToSelectedChip(1);
                            },
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'ma',
                                      style: TextStyle(
                                        color: //selectedCategory == 'Following' || selectedCategory == 'Shop' || selectedCategory == 'Live' || selectedCategory == 'Podcasts' ?
                                            Colors.orange
                                        //: Colors.grey[100]
                                        ,
                                        fontSize: 30,
                                        fontFamily: 'Gotham-Black',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'kulay',
                                      style: TextStyle(
                                        color: //selectedCategory == 'Following' || selectedCategory == 'Shop' || selectedCategory == 'Live' || selectedCategory == 'Podcasts' ?
                                            Colors.amber
                                        //: Colors.grey[100]
                                        ,
                                        fontSize: 30,
                                        fontFamily: 'Gotham-Black',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                )),
                          ),*/
                          Container(
                                //padding: const EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Icon(
                                  Icons.favorite_border_rounded,
                                  size: 30,
                                  color: selectedCategory == 'Following'
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                              ),
                          Container(
                                //padding: const EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Icon(
                                  Icons.public,
                                  size: 30,
                                  color: selectedCategory == 'Discover'
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                              ),
                          /*Container(
                            height: 50,
                            child: 
                          
                              ChoiceChip(
                                shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                          label: Text(
                                      'marciusjam',
                                      style: TextStyle(fontSize: 15,),
                                    ),
                                          side: BorderSide(
                                            color: selectedCategory == 'Following'
                                            ? Colors.amber
                                            : Colors.black,
                                            width: 1.5,
                                          ),
                                          labelStyle: TextStyle(
                                            color:  Colors.black,
                                          ),
                                          avatar: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                widget.profilepicture),
                                      ),
                                    ),
                                          selected: true,
                                          selectedColor: Colors.white,
                                          showCheckmark: false,
                                          backgroundColor: Colors.grey[100],
                                          onSelected: (bool selected) {
                                           
                                          },
                                        ),),*/
                             
                              //Spacer(),
                              /*Container(
                        //padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.people_rounded,
                          size: 30,
                          color: selectedCategory == 'Following'
                              ? Colors.amber
                              : Colors.grey[100],
                        ),
                      ),*/

                              /*GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 'Makulay';
                          });
                          controller?.jumpToPage(2);
                          //_scrollToSelectedChip(1);
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                            child: Row(
                              children: [
                                Text(
                                  'ma',
                                  style: TextStyle(
                                    color: //selectedCategory == 'Makulay' ? 
                                    Colors.orange 
                                    //: Colors.grey[400]
                                    ,
                                    fontSize: 25,
                                    fontFamily: 'Gotham-Black',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'kulay',
                                  style: TextStyle(
                                    color: //selectedCategory == 'Makulay' ? 
                                    Colors.amber 
                                    //: Colors.grey[400]
                                    ,
                                    fontSize: 25,
                                    fontFamily: 'Gotham-Black',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            )),
                      ),*/
                              
                              /*GestureDetector(
                                  onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ActivitiesPage()),
                                        )
                                      },
                                  child: Container(
                                      //padding: const EdgeInsets.only(right: 10.0),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Image.asset(
                                        'assets/discover.png',
                                        height: 23,
                                        width: 23,
                                        filterQuality: FilterQuality.high,
                                        color: selectedCategory == 'Discover'
                                            ? Colors.amber
                                            : Colors.black,
                                      ))),*/

                              Container(
                                //padding: const EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Icon(
                                  Icons.storefront,
                                  size: 30,
                                  color: selectedCategory == 'Shop'
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                              ),

                              Container(
                                //padding: const EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.fromLTRB(0, 0, 17, 0),
                                child: Icon(
                                  Icons.ondemand_video_rounded,
                                  size: 30,
                                  color: selectedCategory == 'Live'
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                              ),

                              Container(
                                //padding: const EdgeInsets.only(right: 10.0),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Icon(
                                  Icons.mic,
                                  size: 27,
                                  color: selectedCategory == 'Podcasts'
                                      ? Colors.amber
                                      : Colors.black,
                                ),
                              ),

                              /*ChoiceChip(
                                          label: Text(category),
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.5,
                                          ),
                                          labelStyle: TextStyle(
                                            color: selectedCategory == category
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          selected:
                                              selectedCategory == category,
                                          selectedColor: Colors.black,
                                          showCheckmark: false,
                                          backgroundColor: Colors.grey[100],
                                          onSelected: (bool selected) {
                                            setState(() {
                                              selectedCategory = category;
                                            });
                                            controller?.jumpToPage(index);
                                            //_scrollToSelectedChip(index + 1);
                                          },
                                        ),*/
                            ]),
                      */
                          ),
                    */
                    ),
                  ),
                ];
              },
              body: /*MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child:*/ //NestedScrollView(
                  /*selectedCategory == 'Following'
                      ? TabBarView(controller: _tabbercontroller, children: [
                          InterestsPage(
                              profilepicture: widget.profilepicture,
                              username: widget.username,
                              userid: widget.userid,
                              cameras: widget.cameras,
                              selectedPageIndex: _selectedPageIndex,
                              onIconTap: onIconTap),
                          GestureDetector(
                            onHorizontalDragEnd: (dragEndDetails) {
                              if (dragEndDetails.primaryVelocity! < 0) {
                                setState(() {
                                    selectedCategory = 'Discover';
                                });
                                controller?.jumpTo(1);
                              }
                            },
                            child: LivePage(),
                          )
                        ])
                      :*/
                  PageView(
                scrollDirection: Axis.vertical,
                onPageChanged: onchahged,
                controller: controller,
                children: [
                  if (widget.userid == '') 
                  Login(widget.cameras),
                  /*if (widget.userid != '')
                    NewPostPage(
                      username: widget.username,
                      profilepicture: widget.profilepicture,
                      cameras: widget.cameras,
                      preselectedAssets: [],
                      preentityPaths: [],
                      descriptionController: new TextEditingController(),
                      onIconTap: onIconTap,
                      selectedPageIndex: _selectedPageIndex,
                    ),*/
                  if (widget.userid != '')
                    GestureDetector(
                      onHorizontalDragEnd: (dragEndDetails) {
                        if (dragEndDetails.primaryVelocity! < 0) {
                          Navigator.push(context, _routeToDiscover());
                        } else {
                          Navigator.push(context, _routeToNewPost());
                        }
                      },
                      child: InterestsPage(
                          profilepicture: widget.profilepicture,
                          username: widget.username,
                          userid: widget.userid,
                          cameras: widget.cameras,
                          selectedPageIndex: _selectedPageIndex,
                          onIconTap: onIconTap),
                    ),
                  /*if (widget.userid != '')
                    DiscoverPage(widget.profilepicture, widget.username,
                        widget.userid, widget.cameras),*/
                  /*if (widget.userid != '') ShopPage(),
                            if (widget.userid != '') LivePage(),
                            if (widget.userid != '') PodcastPage(),*/
                ],
              ),
              //),
              /*TabBarView(
              controller: _tabController,
              children: [
              
              ],
            ),*/

              /*if(widget.userid != '')
      ChatPage(widget.cameras),*/
            ),
            /*bottomNavigationBar: widget.userid != ''
                ? //Visibility(visible: _showAppBar, child:
                //currentIndex != 0 ?
                selectedCategory == 'Following' ? NavigationBottomBar(
                    widget.username, widget.profilepicture, widget.cameras)
                //)
                : null : null
            //: null
            ,*/
          );
  }

  onchahged(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) selectedCategory = 'New';
      if (currentIndex == 1) selectedCategory = 'Following';
      if (currentIndex == 2) selectedCategory = 'Discover';
      /*if (currentIndex == 2) selectedCategory = 'Shop';
      if (currentIndex == 3) selectedCategory = 'Live';
      if (currentIndex == 4) selectedCategory = 'Podcasts';*/
      //if (currentIndex == 5) selectedCategory = 'Podcasts';
    });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
