import 'package:final_year_project/animation/fade_animation.dart';
import 'package:final_year_project/shared/customs/xDecorations.dart';
import 'package:final_year_project/shared/customs/xInputFields.dart';
import 'package:final_year_project/shared/customs/xSpaces.dart';
import 'package:final_year_project/shared/customs/xTexts.dart';
import 'package:final_year_project/shared/customs/xloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String error = '';
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
                  children: [
                    sb(4),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FadeAnimation(
                            0.5,
                            textBig('Reset Password'),
                          ),
                          sb(2),
                          FadeAnimation(
                            0.6,
                            textSmall('It\'s always okay to forget'),
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
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                                child: Text(
                                                  'Enter your E-mail ID',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(16),
                                                child: Text(
                                                  'A Password reset link will be sent to your E-mail ID which will allow you to reset the Password.',
                                                  style: TextStyle(fontSize: 16, color: Colors.black54),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                              child: Container(
                                                decoration: inputContainerDecoration().copyWith(
                                                  border: Border.all(
                                                    color: Colors.grey[200],
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8),
                                                  child: TextFormField(
                                                    autocorrect: false,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.deny(RegExp(r"\s")),
                                                      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.@]")),
                                                    ],
                                                    keyboardType: TextInputType.emailAddress,
                                                    textCapitalization: TextCapitalization.none,
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
                                  0.8,
                                  GestureDetector(
                                    onTap: _resetPassword,
                                    child: positiveButton('Send Link'),
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

  Future _resetPassword() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
          Fluttertoast.showToast(
              msg: "Password reset link sent to $email",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16);
          Navigator.of(context).pop();
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          print(e);
          setState(() {
            loading = false;
            error = 'The E-mail ID is badly formatted';
          });
        } else if (e.code == 'user-not-found') {
          print(e);
          setState(() {
            loading = false;
            error = 'No user found for that E-mail ID';
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
    }
  }
}
