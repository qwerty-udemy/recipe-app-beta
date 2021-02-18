import 'dart:ui';

import 'package:final_year_project/animation/fade_animation.dart';
import 'package:final_year_project/shared/customs/xDecorations.dart';
import 'package:final_year_project/shared/customs/xInputFields.dart';
import 'package:final_year_project/shared/customs/xSpaces.dart';
import 'package:final_year_project/shared/customs/xTexts.dart';
import 'package:final_year_project/shared/customs/xloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'reset_password.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  bool _showPassword = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage('assets/images/recipesBackground.jpg'),
          ),
        ),
        height: h,
        width: w,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    sb(4),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                            0.4,
                            textBig('Login'),
                          ),
                          sb(2),
                          FadeAnimation(
                            0.5,
                            textSmall('Welcome back'),
                          ),
                        ],
                      ),
                    ),
                    sb(3),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 16),
                        decoration: backgroundContainerDecoration(),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                sb(5),
                                FadeAnimation(
                                  0.7,
                                  Container(
                                    decoration: backgroundInputDecoration(),
                                    child: Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: inputContainerDecoration(),
                                              child: TextFormField(
                                                autocorrect: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                                                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.@]")),
                                                ],
                                                textCapitalization: TextCapitalization.none,
                                                decoration: inputTextFieldDecoration('E-mail ID', Icons.email_outlined),
                                                onChanged: (value) {
                                                  setState(() {
                                                    email = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Please enter a valid E-mail ID';
                                                  }
                                                  return null;
                                                },
                                                keyboardType: TextInputType.emailAddress,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: inputContainerDecoration(),
                                              child: TextFormField(
                                                decoration: inputTextFieldDecoration('Password', Icons.vpn_key_outlined).copyWith(
                                                  suffixIcon: IconButton(
                                                      icon: _showPassword ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showPassword = !_showPassword;
                                                        });
                                                      }),
                                                ),
                                                obscureText: !_showPassword,
                                                onChanged: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                                validator: (value) => value.isEmpty
                                                    ? 'Enter a valid Password'
                                                    : value.length < 6
                                                        ? 'Password must be atleast 6 characters'
                                                        : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sb(3),
                                FadeAnimation(
                                  0.8,
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ResetPassword(),
                                      ),
                                    ),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(color: Colors.black, fontSize: 16, decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                sb(3),
                                FadeAnimation(
                                  0.9,
                                  GestureDetector(
                                    onTap: _signInUser,
                                    child: positiveButton('Login'),
                                  ),
                                ),
                                sb(3),
                                FadeAnimation(
                                  1.0,
                                  GestureDetector(
                                    onTap: () => widget.toggleView(),
                                    child: alternateButton('New User? Register here'),
                                  ),
                                ),
                                sb(3),
                                loading
                                    ? Container(
                                        height: 50,
                                        width: 100,
                                        child: Loading(),
                                      )
                                    : textError(error),
                                sb(3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _signInUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print(e);
          setState(() {
            loading = false;
            error = 'No user found for that E-mail ID';
          });
        } else if (e.code == 'wrong-password') {
          print(e);
          setState(() {
            loading = false;
            error = 'Password is incorrect';
          });
        } else if (e.code == 'invalid-email') {
          print(e);
          setState(() {
            loading = false;
            error = 'Entered E-mail ID is invalid';
          });
        }
      } catch (e) {
        print(e);
        this.setState(() {
          loading = false;
          error = e;
        });
      }
      print(email);
      print(password);
    }
  }
}
