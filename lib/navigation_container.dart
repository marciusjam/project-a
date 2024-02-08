import 'dart:convert';
import 'dart:io';

import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/screens/chat_page.dart';
import 'package:Makulay/screens/home_page.dart';
import 'package:Makulay/screens/new_post_page.dart';
import 'package:Makulay/screens/profile_page.dart';
import 'package:Makulay/screens/search_page.dart';
import 'package:Makulay/widgets/navigation_bar.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:Makulay/models/User.dart';
import 'models/ModelProvider.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';

import 'amplifyconfiguration.dart';

String globalEmail = '';
String globalUsername = '';
String globalId = '';
XFile? globalFile;
String globalKey = '';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({Key? key}) : super(key: key);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> with TickerProviderStateMixin{
  late List<CameraDescription> cameras;
  int _selectedBottomTabIndex = 0;
  bool _amplifyConfigured = false;
  bool newUser = false;
  bool isLoading = false;
  bool fileHasBeenPicked = false;
  
  static final customCacheManager = CacheManager(Config('customCacheKey',
    stalePeriod: const Duration(days: 15),maxNrOfCacheObjects: 100,));

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

  late TabController _tabController;


  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    setState(() {}); // Trigger a rebuild to display camera descriptions
  }

  @override
  initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    initializeCameras();
    super.initState();
    fetchCurrentUserAttributes();
    //_configureAmplify();
  }

  void _onIconTapped(int index) {
    
    setState(() {
      _selectedBottomTabIndex = index;
    });

    if(index == 0){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage(globalUsername)),
        );
    }

    if(index == 1){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewPostPage(cameras: cameras,)),
        );
    }

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

  Future<void> getUserByIdFunction(String id) async {
    var userData = await getUserById(id);
    debugPrint('getUserByIdFunction Response: ' + userData.data.toString());
    /*globalUsername = 'shayecrispo';
    globalId = 'id';
    getFileUrl('DEV1/2024-02-01T03:53:58.102735');*/
    
    if(userData.data != null){
      User? userdata = userData.data;

      String username = userdata!.username.toString();
      globalUsername = username;
      debugPrint('username :' + username);

      String profilePicture = userdata.profilePicture.toString();
      getFileUrl(profilePicture);
      debugPrint('profilepicture :' + profilePicture);

          setState(() {
            newUser = false;
          });
        }else{
          setState(() {
            newUser = true;
          });
        }
    
    
  }

  Future<void> fetchCurrentUserAttributes() async {
  try {
    final result = await Amplify.Auth.fetchUserAttributes();
    //String userEmail = result[2].value.toString();
    for (final element in result) {
      safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      if(element.userAttributeKey.toString() == 'email'){
        globalEmail = element.value.toString();
      }else if(element.userAttributeKey.toString() == 'sub'){
        globalId = element.value.toString();
      }
    }
    getUserByUserIdFunction(globalId);
    getUserByIdFunction(globalId);
  } on AuthException catch (e) {
    safePrint('Error fetching user attributes: ${e.message}');
    if(e.message == 'No user is currently signed in'){
      setState(() {
        newUser = false;
        globalUsername = '';
        globalKey = '';
      });
    }
    
  }
}


Future<void> getFileUrl(String fileKey) async {
      try {
        final result = await Amplify.Storage.getUrl(
      key: fileKey,
      options: const StorageGetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
        pluginOptions: S3GetUrlPluginOptions(
          expiresIn: Duration(days: 1),
        ),
      ),
    ).result;
        //debugPrint('result ' + result.url.toString());
        _precacheImage(result.url.toString(), fileKey);
        globalKey = result.url.toString();
      } catch (e) {
        throw e;
      }
    }

  Future<void> _precacheImage(String imageUrl, String key) async {
    
    /*await DefaultCacheManager().putFile(
      {key,

      }
    )*/
    final imageProvider = CachedNetworkImageProvider(imageUrl, cacheKey: key, cacheManager: customCacheManager);
    precacheImage(imageProvider, context);
    //_preloadedImages.add(imageProvider);
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
          id: globalId,
          userId: globalId,
          username: usernameText,
          email: globalEmail,
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

      getFileUrl(keyName);
      Future.delayed(const Duration(seconds: 10), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigationContainer()),
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
    return newUser ? setUsername() : Scaffold(
resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: HomePage(globalKey, globalUsername, globalId),
      bottomNavigationBar: NavigationBottomBar(_tabController ,selectedPageIndex: _selectedBottomTabIndex, onIconTap: _onIconTapped)
    );
    //bottomNavigationBar: NavigationBottomBar( selectedPageIndex: _selectedPageIndex, onIconTap: _onIconTapped));
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);


