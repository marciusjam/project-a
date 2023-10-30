import 'package:agilay/navigation_container.dart';
import 'package:agilay/screens/confirm.dart';
import 'package:agilay/screens/auth_page.dart';
import 'package:agilay/screens/home_page.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

import 'screens/auth_page.dart';
import 'screens/confirm.dart';
import 'screens/confirm_reset.dart';

void main() {
  //await configureAmplify();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agilay',
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
          NavigationContainer(),
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
            pageBuilder: (_, __, ___) => NavigationContainer(),
            //HomePage(),
            transitionsBuilder: (_, __, ___, child) => child,
          );
        }
        return MaterialPageRoute(builder: (_) => AuthPage());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
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
}
