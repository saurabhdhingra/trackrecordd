import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trackrecordd/authViews/basicDetails.dart';
import 'package:trackrecordd/authViews/verify.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackrecordd/widgets/customField.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';

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
              SizedBox(
                width: width,
                height: height * 0.23,
              ),
              CustomField(
                setValue: (value) => setState(() => email = value.trim()),
                formKey: _formKey1,
                hintText: 'Email',
              ),
              const Text(
                'We won\'t judge you even if it is embarassing     ',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: height * 0.02),
              CustomField(
                setValue: (value) => setState(() => password = value.trim()),
                formKey: _formKey2,
                obscureText: true,
                hintText: 'Password',
              ),
              SizedBox(height: height * 0.02),
              CustomField(
                setValue: (value) =>
                    setState(() => confirmPassword = value.trim()),
                formKey: _formKey3,
                obscureText: true,
                hintText: 'Confirm Password',
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: 230,
                height: 40,
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
