import 'package:agilay/models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';

import 'package:agilay/screens/home_page.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
  String method = 'Login';
  late bool _isSignedIn;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    if (method == 'Login') {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  cursorColor: Colors.amber,
                  controller: emailController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email/Username/Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //labelText: 'Email/Username/Phone Number',
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

                SizedBox(height: 5.0),

                TextField(
                  cursorColor: Colors.amber,
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
                      primary: Colors.amber,
                      textStyle: TextStyle(
                        color: Colors.amber,
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
                                  color: Colors.amber,
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
                  cursorColor: Colors.amber,
                  controller: emailController,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email/Username/Phone Number',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //labelText: 'Email/Username/Phone Number',
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

                SizedBox(height: 5.0),

                TextField(
                  cursorColor: Colors.amber,
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
                  cursorColor: Colors.amber,
                  controller: passwordController,
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

                    _signupUser(emailController.text, passwordController.text);

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
                                  color: Colors.amber,
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
        _isSignedIn = res.isSignedIn;
        //_loginData = data;
        //method = 'Login';
        _createUser(name);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
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

  Future<void> _createUser(String name) async {
    /*try {
      final post = User(
          username: 'Marcius',
          email: name.toString(),
          phoneNumber: '09190612407');
      await Amplify.DataStore.save(post);

      // Post created successfully, navigate to the next screen or show a success message
    } catch (e) {
      // Handle the error (e.g., display an error message)
      print('Error creating post: $e');
    }*/
  }

  Future<String?> _signupUser(String name, String password) {
    final userAttributes = <AuthUserAttributeKey, String>{
      AuthUserAttributeKey.email: 'test@example.com',
      //AuthUserAttributeKey.phoneNumber: '+18885551234',
    };
    return Future.delayed(loginTime).then((_) async {
      try {
        await Amplify.Auth.signUp(
            username: name.toString(),
            password: password,
            options: SignUpOptions(userAttributes: userAttributes));

        //_signUpData = data;
        //method = 'Signup';
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
