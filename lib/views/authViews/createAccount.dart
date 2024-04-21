import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trackrecordd/views/authViews/basicDetails.dart';
import 'package:trackrecordd/views/authViews/verify.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackrecordd/widgets/customField.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: height * 0.25, width: width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextInputWidget(
                    width: 0.9,
                    height: 0.065,
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const Text(
                    '  We won\'t judge you even if it is embarassing     ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              CustomTextInputWidget(
                width: 0.9,
                height: 0.065,
                controller: passwordController,
                obscureText: true,
                hintText: 'Password',
              ),
              SizedBox(height: height * 0.02),
              CustomTextInputWidget(
                width: 0.9,
                height: 0.065,
                controller: confirmPasswordController,
                obscureText: true,
                hintText: 'Confirm Password',
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xFFFED500),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(height / 38)),
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
                    if (confirmPasswordController.text ==
                        passwordController.text) {
                      try {
                        auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then(
                          (_) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => VerifyView()));
                          },
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Password not confirmed correctly')));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
