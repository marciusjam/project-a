import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class ConfirmResetScreen extends StatefulWidget {
  final LoginData data;

  const ConfirmResetScreen({required this.data});

  //const ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmResetScreenState createState() => _ConfirmResetScreenState();
}

class _ConfirmResetScreenState extends State<ConfirmResetScreen> {
  final _controller = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isEnabled = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
    _newPasswordController.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _newPasswordController.dispose();
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
                          controller: _newPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Enter new password',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
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
                                  _resetPassword(
                                      context,
                                      widget.data,
                                      _controller.text,
                                      _newPasswordController.text);
                                }
                              : null,
                          elevation: 4,
                          color: Theme.of(context).primaryColor,
                          disabledColor: Colors.deepOrange.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            'RESET',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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

  void _resetPassword(BuildContext context, LoginData data, String code,
      String password) async {
    try {
      final res = await Amplify.Auth.confirmResetPassword(
        username: data.name.toString(),
        newPassword: password,
        confirmationCode: code,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Password changed succcesfully. Please log in',
            style: TextStyle(fontSize: 15),
          ),
        ),
      );

      Navigator.of(context).pushReplacementNamed('/');
    } on AuthException catch (e) {
      debugPrint(e.toString());
      _showError(context, e.message.toString());
      return null;
    }
  }

  void _resendCode(BuildContext context, LoginData data) async {
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
