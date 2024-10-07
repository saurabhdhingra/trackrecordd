import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trackrecordd/views/authViews/detailsFlow/basicDetails.dart';
import 'package:trackrecordd/views/authViews/signUpFlow/verify.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackrecordd/widgets/customField.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // late TextEditingController emailController;
  // late TextEditingController passwordController;
  // late TextEditingController confirmPasswordController;

  String email = "";
  String password = "";
  String confirm = "";

  @override
  void initState() {
    super.initState();
    // emailController = TextEditingController();
    // passwordController = TextEditingController();
    // confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // emailController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final auth = FirebaseAuth.instance;

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(
                      setValue: (value) => setState(() => email = value),
                      hintText: "Email",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: const Text(
                        'We won\'t judge you even if it is embarassing',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                CustomField(
                  setValue: (value) => setState(() => password = value),
                  hintText: "Password",
                  obscureText: true,
                ),
                SizedBox(height: height * 0.02),
                CustomField(
                  setValue: (value) => setState(() => confirm = value),
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                SizedBox(height: height * 0.02),
                Container(
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFED500),
                    shape: BoxShape.rectangle,
                    borderRadius:
                        BorderRadius.all(Radius.circular(height / 38)),
                  ),
                  child: TextButton(
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    onPressed: () {
                      print("Verify clicked");
                      if (password.trim() == "" || password.isEmpty) {
                        print("Password Empty condition");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter a password')));
                      } else {
                        if (!isPasswordValid(password)) {
                          print("Password not valid condition");
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Password must be at least 8 characters long and include '
                                      'uppercase, lowercase, digit, and special character (@#\$%^&*)')));
                        }
                        if (confirm == password) {
                          print("Account creation condition");
                          try {
                            auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then(
                              (_) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => VerifyView(),
                                  ),
                                );
                              },
                            );
                          } catch (e) {
                            print("Firebase Auth Exception");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        } else {
                          print("Password not confirmed condition");
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Password not confirmed correctly. Please enter the same password twice.')));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: const Text(
                    'Password must be at least 8 characters long and include '
                    'uppercase, lowercase, digit, and special character (@#\$%^&*)',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String passwordPattern =
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*])[A-Za-z\d@#$%^&*]{8,}$';

  bool isPasswordValid(String password) {
    RegExp regex = RegExp(passwordPattern);
    return regex.hasMatch(password);
  }
}
