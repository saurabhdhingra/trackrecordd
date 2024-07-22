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
  String email = "";
  String password = "";
  String confirmPassword = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                  CustomField(
                    width: 0.9,
                    height: 0.065,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    setValue: (value) => email = value,
                  ),
                  const Text(
                    '        We won\'t judge you even if it is embarassing     ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              CustomField(
                width: 0.9,
                height: 0.065,
                obscureText: true,
                hintText: 'Password',
                setValue: (value) => password = value,
              ),
              SizedBox(height: height * 0.02),
              CustomField(
                width: 0.9,
                height: 0.065,
                obscureText: true,
                hintText: 'Confirm Password',
                setValue: (value) => confirmPassword = value,
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
                    if (confirmPassword == password) {
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
