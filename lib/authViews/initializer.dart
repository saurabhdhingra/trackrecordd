import 'package:flutter/material.dart';
import 'package:trackrecordd/authViews/basicDetails.dart';
import 'package:trackrecordd/authViews/signUp.dart';
import 'package:trackrecordd/views/homeView.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({super.key});

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;
  late User? _user;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? const SignupView()
            : const BasicDetailsPage();
  }
}
