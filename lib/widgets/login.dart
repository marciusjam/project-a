import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SignupData _signUpData;
  late LoginData _loginData;
  late String method;
  late bool _isSignedIn;
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Agilay',
      //logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _loginUser,
      onRecoverPassword: (String email) => _recoverPassword(context, email),
      onSignup: _signupUser,
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: () {
        Object useData;
        if (method == 'Login') {
          useData = _loginData;
          Navigator.of(context).pushReplacementNamed(
              _isSignedIn ? '/home' : '/confirm',
              arguments: useData);
        } else {
          useData = _signUpData;
          Navigator.of(context)
              .pushReplacementNamed('/confirm', arguments: useData);
        }
      },
    );
  }

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _loginUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        final res = await Amplify.Auth.signIn(
          username: data.name.toString(),
          password: data.password,
        );
        _isSignedIn = res.isSignedIn;
        _loginData = data;
        method = 'Login';
      } on AuthException catch (e) {
        debugPrint('Error: ' + e.toString());
        if (e.message.toString() == 'Failed since user is not authorized.') {
          return 'Incorrect username or password.';
        }

        if (e.message.toString() == 'There is already a user signed in.') {
          await Amplify.Auth.signOut();
          return 'Problem logging in. Please try again';
        }

        /*if (e.message.toString() == 'Username already exists in the system.') {
          return 'Username already exists.';
        }*/

        return 'There was a problem signing up. Please try again';
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) async {
      try {
        await Amplify.Auth.signUp(
            username: data.name.toString(),
            password: data.password,
            options: CognitoSignUpOptions(userAttributes: {
              'email': data.name.toString(),
            }));

        _signUpData = data;
        method = 'Signup';
      } on AuthException catch (e) {
        debugPrint('Error: ' + e.message.toString());
        if (e.message.toString() == 'Username already exists in the system.') {
          return 'Username already exists.';
        }

        return 'There was a problem signing up. Please try again';
      }
    });
  }

  Future<String?> _recoverPassword(BuildContext context, String email) async {
    try {
      final res = await Amplify.Auth.resetPassword(username: email);
      //debugPrint('res.nextStep.updateStep =' + res.nextStep.updateStep);
      if (res.nextStep.updateStep == 'CONFIRM_RESET_PASSWORD_WITH_CODE') {
        Navigator.of(context).pushReplacementNamed(
          '/confirm-reset',
          arguments: LoginData(name: email, password: ''),
        );
      }
    } on AuthException catch (e) {
      debugPrint('Error: ' + e.message.toString());
      if (e.message.toString() == 'User not found in the system.') {
        return 'Email does not exist.';
      }
    }
    return null;
  }
}
