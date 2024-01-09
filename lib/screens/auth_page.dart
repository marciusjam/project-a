import 'package:agilay/models/ModelProvider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../amplifyconfiguration.dart';

import '../widgets/login.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
    final _authPlugin = AmplifyAuthCognito();
    try {
      if (!Amplify.isConfigured) {
        await Amplify.addPlugins([_authPlugin, _dataStorePlugin, _apiPlugin]);
        await Amplify.configure(amplifyconfig);
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
        backgroundColor: Colors.white,
        body: Center(
          child: _amplifyConfigured ? Login() : CircularProgressIndicator(),
        ));
  }
}
