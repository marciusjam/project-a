import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
//import '../amplifyconfiguration.dart';

import '../widgets/login.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final amplify = Amplify;
  bool _amplifyConfigured = false;

  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    final _authPlugin = AmplifyAuthCognito();
    try {
      if (!Amplify.isConfigured) {
        await Amplify.addPlugins([_authPlugin]);
        //await Amplify.configure(amplifyconfig);
      }

      /*Amplify.Auth.signOut().then((_) {
        Navigator.pushReplacementNamed(context, '/');
      });*/
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: Center(
          child: _amplifyConfigured ? Login() : CircularProgressIndicator(),
        ));
  }
}
