import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class ConfirmScreen extends StatefulWidget {
  final SignupData data;

  const ConfirmScreen({required this.data});

  //const ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _controller = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  margin: const EdgeInsets.all(30),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Enter Confirmation code',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        MaterialButton(
                          onPressed: _isEnabled
                              ? () {
                                  _verifyCode(
                                      context, widget.data, _controller.text);
                                }
                              : null,
                          elevation: 4,
                          color: Theme.of(context).primaryColor,
                          disabledColor: Colors.deepOrange.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            'VERIFY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _resendCode(context, widget.data);
                          },
                          child: Text(
                            'Resend code',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  void _verifyCode(BuildContext context, SignupData data, String code) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
        username: data.name.toString(),
        confirmationCode: code,
      );

      if (res.isSignUpComplete) {
        //Login user
        final user = await Amplify.Auth.signIn(
            username: data.name.toString(), password: data.password.toString());

        if (user.isSignedIn) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } on AuthException catch (e) {
      debugPrint(e.toString());
      _showError(context, e.message.toString());
      return null;
    }
  }

  void _resendCode(BuildContext context, SignupData data) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: data.name.toString());

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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(
          message.toString(),
          style: TextStyle(fontSize: 15),
        )));
  }
}
