import 'package:Makulay/main.dart';
import 'package:Makulay/models/ModelProvider.dart';
import 'package:Makulay/navigation_container.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:Makulay/screens/home_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:uuid/uuid.dart';

var globalEmail;
var globalPassword;

class Login extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Login(this.cameras, {Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SignupData _signUpData;
  late LoginData _loginData;
  String method = 'Login';
  late bool _isSignedIn;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController verifCodeController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    if (method == 'Login') {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  cursorColor: Colors.red,
                  controller: emailController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email/Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusColor: Colors.red,
                    labelStyle: TextStyle(
                      color: Colors.red,
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

                SizedBox(height: 5.0),

                TextField(
                  cursorColor: Colors.red,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                  obscureText: true,
                ),
                //SizedBox(height: 0.0),

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
                    debugPrint('Login: ' +
                        emailController.text +
                        ' ' +
                        passwordController.text);

                    _loginUser(emailController.text, passwordController.text);

                    /*Navigator.of(context).pushReplacementNamed(
                                    _isSignedIn ? '/home' : '/confirm',
                                    arguments: _loginData);*/
                  },
                  child: Text('Login'),
                ),
                //SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                      textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      _recoverPassword(context, emailController.text);
                    },
                    child: Text(
                      'Forgot Password',
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: InkWell(
                            onTap: () {
                              print('Signup Pressed');
                              setState(() {
                                method = 'Signup';
                              });
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //)
      ]);
    } else if(method == 'Signup') {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  cursorColor: Colors.red,
                  controller: emailController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email/Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusColor: Colors.red,
                    labelStyle: TextStyle(
                      color: Colors.red,
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

                SizedBox(height: 5.0),

                TextField(
                  cursorColor: Colors.red,
                  controller: passwordController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                  obscureText: true,
                ),

                SizedBox(height: 5.0),

                TextField(
                  cursorColor: Colors.red,
                  controller: confirmPasswordController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                  obscureText: true,
                ),
                //SizedBox(height: 0.0),

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
                    debugPrint('Signup: ' +
                        emailController.text +
                        ' ' +
                        passwordController.text);
                        if(passwordController.text != confirmPasswordController.text){
                          _showError(context, 'Password and Confirm Password are not the same.');
                        }else{
                          _signupUser(emailController.text, passwordController.text, confirmPasswordController.text);
                        }

                    
                    /*Navigator.of(context).pushReplacementNamed(
                                    _isSignedIn ? '/home' : '/confirm',
                                    arguments: _loginData);*/
                  },
                  child: Text('Signup'),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Back to "),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: InkWell(
                            onTap: () {
                              print('Login Pressed');
                              setState(() {
                                method = 'Login';
                              });
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //)
      ]);
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  cursorColor: Colors.red,
                  controller: verifCodeController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Verification Code',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //labelText: 'Email/Username/Phone Number',
                    focusColor: Colors.red,
                    labelStyle: TextStyle(
                      color: Colors.red,
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
                    debugPrint('Verify Code: ' +
                        verifCodeController.text);

                    _verifyCode(context, globalEmail, globalPassword, verifCodeController.text);

                    /*Navigator.of(context).pushReplacementNamed(
                                    _isSignedIn ? '/home' : '/confirm',
                                    arguments: _loginData);*/
                  },
                  child: Text('Verify'),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: InkWell(
                            onTap: () {
                              print('Resend Code Pressed');
                              _resendCode(context, globalEmail);
                            },
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Back to "),
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: InkWell(
                            onTap: () {
                              print('Login Pressed');
                              setState(() {
                                method = 'Login';
                              });
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //)
      ]);
    }
  }

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _loginUser(String name, String password) async {
    await Amplify.Auth.signOut();
    debugPrint('Name: ' + name + ', Password: ' + password);
    return Future.delayed(loginTime).then((_) async {
      try {
        final res = await Amplify.Auth.signIn(
          username: name.toString(),
          password: password,
        );
        debugPrint('res: ' + res.toString());
        var userConfirmationNeeded;
        if(res.nextStep.signInStep == AuthSignInStep.confirmSignUp){
          //userConfirmationNeeded = true;
          _resendCode(context, name);
          setState(() {
            method = 'Verify';
            globalEmail = name;
            globalPassword = password;
          });
        }else if (res.nextStep.signInStep == AuthSignInStep.done) {
          //userConfirmationNeeded = false;
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp(widget.cameras)),
        );
        }
    
        
        
        
        //_handleSignInResult(res);
        
      } on AuthException catch (e) {
        debugPrint('Error: ' + e.toString());
        _showError(context, e.message.toString());
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

  void _verifyCode(BuildContext context, String name, String password, String code) async {
    try {
      debugPrint(name.toString());
      final res = await Amplify.Auth.confirmSignUp(
        username: name.toString(),
        confirmationCode: code,
      );

      if (res.isSignUpComplete) {
        //Login user
        final user = await Amplify.Auth.signIn(
            username: name.toString(), password: password.toString());

        if (user.isSignedIn) {
          //Navigator.pushReplacementNamed(context, '/home');
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp(widget.cameras)),);
        }
      }else{
        method = 'Verify';
      }
    } on AuthException catch (e) {
      debugPrint(e.toString());
      _showError(context, e.message.toString());
      return null;
    }
  }

  void _resendCode(BuildContext context, String name) async {
    try {
      debugPrint('sending new code to: ' + name.toString());
      await Amplify.Auth.resendSignUpCode(username: name.toString());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text(
            'Confirmation code resent. Check your email',
            style: TextStyle(fontSize: 15),
          )));
    } on AuthException catch (e) {
      _showError(context, e.message.toString());
    }
  }


  Future<String?> _signupUser(String name, String password, String confirmpass) {
    final userAttributes = <AuthUserAttributeKey, String>{
        AuthUserAttributeKey.email: name,
        //AuthUserAttributeKey.phoneNumber: '+18885551234',
      };
      return Future.delayed(loginTime).then((_) async {
        try {
          await Amplify.Auth.signUp(
              username: name.toString(),
              password: password,
              options: SignUpOptions(userAttributes: userAttributes));
          setState(() {
              globalEmail = name;
              globalPassword = password;
              method = 'verify';
            });
          //_signUpData = data;
          //method = 'Signup';
        } on AuthException catch (e) {
          debugPrint('Error: ' + e.message.toString());
          _showError(context, e.message.toString());
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



  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          message.toString(),
          style: TextStyle(fontSize: 15),
        )));
  }
}
