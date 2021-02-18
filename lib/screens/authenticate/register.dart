import 'package:final_year_project/animation/fade_animation.dart';
import 'package:final_year_project/shared/customs/xDecorations.dart';
import 'package:final_year_project/shared/customs/xInputFields.dart';
import 'package:final_year_project/shared/customs/xSpaces.dart';
import 'package:final_year_project/shared/customs/xTexts.dart';
import 'package:final_year_project/shared/customs/xloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool _showPassword1 = false;
  bool _showPassword2 = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

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
                            0.5,
                            textBig('Register'),
                          ),
                          sb(2),
                          FadeAnimation(
                            0.6,
                            textSmall('Get on board'),
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
                                  0.8,
                                  Container(
                                    decoration: backgroundInputDecoration(),
                                    child: Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: inputContainerDecoration(),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
                                                ],
                                                keyboardType: TextInputType.name,
                                                decoration: inputTextFieldDecoration('Name', Icons.account_circle_outlined),
                                                onChanged: (value) {
                                                  setState(() {
                                                    name = value;
                                                  });
                                                },
                                                validator: (value) => value.isEmpty ? 'Please enter your Name' : null,
                                              ),
                                            ),
                                            sb(1),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: inputContainerDecoration(),
                                              child: TextFormField(
                                                autocorrect: false,
                                                textCapitalization: TextCapitalization.none,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(RegExp(r"\s")),
                                                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.@]")),
                                                ],
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: inputTextFieldDecoration('E-mail ID', Icons.email_outlined),
                                                onChanged: (value) {
                                                  setState(() {
                                                    email = value;
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value.isEmpty || !value.contains('@')) {
                                                    return 'Please enter a valid E-mail ID';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            sb(1),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: inputContainerDecoration(),
                                              child: TextFormField(
                                                decoration: inputTextFieldDecoration('Password', Icons.lock_open_rounded).copyWith(
                                                  suffixIcon: IconButton(
                                                      icon: _showPassword1 ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showPassword1 = !_showPassword1;
                                                        });
                                                      }),
                                                ),
                                                obscureText: !_showPassword1,
                                                onChanged: (value) {
                                                  setState(() {
                                                    password = value;
                                                  });
                                                },
                                                validator: (value) => value.isEmpty
                                                    ? 'Please enter a valid Password'
                                                    : value.length < 6
                                                        ? 'Please enter a stronger Password'
                                                        : null,
                                              ),
                                            ),
                                            sb(1),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: inputContainerDecoration(),
                                              child: TextFormField(
                                                decoration: inputTextFieldDecoration('Confirm Password', Icons.lock_outline_rounded).copyWith(
                                                  suffixIcon: IconButton(
                                                      icon: _showPassword2 ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
                                                      onPressed: () {
                                                        setState(() {
                                                          _showPassword2 = !_showPassword2;
                                                        });
                                                      }),
                                                ),
                                                obscureText: !_showPassword2,
                                                onChanged: (value) {
                                                  setState(() {
                                                    confirmPassword = value;
                                                  });
                                                },
                                                validator: (value) => value.isEmpty
                                                    ? 'Please confirm your Password'
                                                    : value != password
                                                        ? 'Passwords do not match'
                                                        : value.length < 6
                                                            ? 'Please enter a stronger Password'
                                                            : null,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                sb(6),
                                FadeAnimation(
                                  0.9,
                                  GestureDetector(
                                    onTap: _registerUser,
                                    child: positiveButton('Register'),
                                  ),
                                ),
                                sb(3),
                                FadeAnimation(
                                  1.0,
                                  GestureDetector(
                                    onTap: () => widget.toggleView(),
                                    child: alternateButton('Already Registered? Login here'),
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

  Future _registerUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print(e);
          setState(() {
            loading = false;
            error = 'The Password provided is too weak';
          });
        } else if (e.code == 'email-already-in-use') {
          print(e);
          setState(() {
            loading = false;
            error = 'The account already exists for that E-mail ID';
          });
        } else if (e.code == 'invalid-email') {
          print(e);
          setState(() {
            loading = false;
            error = 'The E-mail ID is badly formatted';
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          loading = false;
          error = e;
        });
      }
      print(email);
      print(password);
    }
  }
}
