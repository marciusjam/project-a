import 'package:agilay/screens/chat_page.dart';
import 'package:agilay/screens/home_page.dart';
import 'package:agilay/screens/new_post_page.dart';
import 'package:agilay/screens/profile_page.dart';
import 'package:agilay/screens/search_page.dart';
import 'package:agilay/widgets/navigation_bar.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({Key? key}) : super(key: key);

  @override
  _NavigationContainerState createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  int _selectedPageIndex = 0;
  final amplify = Amplify;
  bool _amplifyConfigured = false;

  static const List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    NewPostPage(),
    ChatPage(),
    //ProfilePage(),
  ];

  @override
  initState() {
    super.initState();
    _configureAmplify();
  }

  void _onIconTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _configureAmplify() async {
    final _authPlugin = AmplifyAuthCognito();
    try {
      if (!Amplify.isConfigured) {
        await Amplify.addPlugins([_authPlugin]);
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
          child: _pages[_selectedPageIndex],
        ),
        bottomNavigationBar: NavigationBar(
            selectedPageIndex: _selectedPageIndex, onIconTap: _onIconTapped));
  }
}
