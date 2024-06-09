import 'dart:async';

import 'package:Makulay/models/CustomGraphQL.dart';
import 'package:Makulay/navigation_container.dart';
import 'package:Makulay/screens/confirm.dart';
import 'package:Makulay/screens/auth_page.dart';
import 'package:Makulay/screens/home_page.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_login/flutter_login.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

import 'screens/auth_page.dart';
import 'screens/confirm.dart';
import 'screens/confirm_reset.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureAmplify();
  final cameras = await availableCameras();
  runApp(MyApp(cameras));
}

Future<void> _configureAmplify() async {
    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    final AmplifyDataStore _dataStorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    final AmplifyStorageS3 _storagePlugin = AmplifyStorageS3();
    final AmplifyAPI _apiPlugin =
        AmplifyAPI(modelProvider: ModelProvider.instance);
    final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();

    if (!Amplify.isConfigured) {
      await Amplify.addPlugins([
        _apiPlugin, // must have
        _authPlugin,
        _storagePlugin,
        _dataStorePlugin
      ]);
      try {
        
        await Amplify.configure(amplifyconfig);
        safePrint('Successfully configured');
      } on Exception catch (e) {
        safePrint('Error configuring Amplify: $e');
      }
      
      
    }
    
    /*await Amplify.addPlugins([_authPlugin, _dataStorePlugin, _apiPlugin, _storagePlugin]);
    

    // Once Plugins are added, configure Amplify
    //await Amplify.configure(amplifyconfig);
    await Amplify.configure(amplifyconfig).then((value) => {
      
    });*/
    
  }



class MyApp extends StatefulWidget {
  late List<CameraDescription> cameras;
  MyApp(this.cameras, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool _amplifyConfigured = false;
static final customCacheManager = CacheManager(Config('customCacheKey',
    stalePeriod: const Duration(days: 15),maxNrOfCacheObjects: 100,));
   late  String globalEmail;
    String? globalUsername;
   late String globalId;
 late  String globalKey;
 late  bool newUser;

  @override
  initState() {
    super.initState();
    debugPrint('running configure Amplify');
    _configureAmplify();
    fetchCurrentUserAttributes();
    
  }

Future<void> getFileUrl(String fileKey) async {
      try {
        await Amplify.Storage.getUrl(
      key: fileKey,
      options: const StorageGetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
        pluginOptions: S3GetUrlPluginOptions(
          expiresIn: Duration(days: 1),
        ),
      ),
    ).result.then((value) => {
      //debugPrint('result ' + result.url.toString());
        _precacheImage(value.url.toString(), fileKey),
        setState(() {
          globalKey = value.url.toString();
          }),
    });
        
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

Future<void> getUserByIdFunction(String id, String email) async {
    await getUserById(id).then((value) async {
    
    debugPrint('getUserByIdFunction Response: ' + value.data.toString());
    
    if(value.data != null){
      User? userdata = value.data;

      String username = userdata!.username.toString();
      
      debugPrint('username :' + username);

      String profilePicture = userdata.profilePicture.toString();
      setState(() {
          newUser = false;
          globalUsername = username;
          globalKey = '';
          globalId = id;
          globalEmail = email;
      });
        
      await getFileUrl(profilePicture);
      debugPrint('profilepicture :' + profilePicture);

      
      
    }else{
      setState(() {
        newUser = true;
        globalUsername = '';
        globalKey = '';
      });
    }
    });
    
  
  }

  Future<void> fetchCurrentUserAttributes() async {
  try {
    late String subid;
    late String email;
    final result = await Amplify.Auth.fetchUserAttributes().then((value) async {
      for (final element in value) {
      safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
      if(element.userAttributeKey.toString() == 'email'){
        //setState(() {
          email = element.value.toString();
          /*globalUsername = '';
          globalKey = '';
          newUser = false;
      })*/
      }else if(element.userAttributeKey.toString() == 'sub'){
        //setState(() {
          subid = element.value.toString();
          
        //})
      }
    }

      await getUserByIdFunction(subid, email);
    });
        
    
  } on AuthException catch (e) {
    safePrint('Error fetching user attributes: ${e.message}');
    if(e.message == 'No user is currently signed in'){
      
     
      setState(() {
        newUser = false;
        globalEmail = '';
        globalUsername = '';
        globalKey = '';
        globalId = '';
      });
    }
    
  }
}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makulay',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primaryColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: //AuthPage(),
          globalUsername != null ?
          NavigationContainer(widget.cameras, globalUsername!, globalId, globalKey, globalEmail, newUser) : Container(color: Colors.white, child: Center( child: CircularProgressIndicator(backgroundColor: Colors.amber.shade900, color: Colors.amber,),),) ,
      onGenerateRoute: (settings) {
        if (settings.name == '/confirm') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                ConfirmScreen(data: settings.arguments as SignupData),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        if (settings.name == '/confirm-reset') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                ConfirmResetScreen(data: settings.arguments as LoginData),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }

        if (settings.name == '/home') {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => NavigationContainer(widget.cameras, globalUsername!, globalId, globalKey, globalEmail, newUser),
            //HomePage(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }
        return MaterialPageRoute(builder: (_) => AuthPage(widget.cameras));
      },
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _amplifyConfigured = false;
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    await Amplify.addPlugins([_dataStorePlugin, _apiPlugin, _authPlugin]);

    // Once Plugins are added, configure Amplify
    //await Amplify.configure(amplifyconfig);

    try {
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return AuthPage();
  }
}*/
