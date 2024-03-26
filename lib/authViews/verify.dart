import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/authViews/basicDetails.dart';
import 'package:trackrecordd/utils/uiUtils.dart';

import '../utils/constants.dart';
import 'basicDetails.dart';

class VerifyView extends StatefulWidget {
  @override
  _VerifyViewState createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final auth = FirebaseAuth.instance;
  User? user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.025),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              Container(
                width: width * 0.95,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(height / 38)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(
                        CupertinoIcons.mail,
                        size: width * 0.1,
                        color: Colors.black,
                      ),
                      title: Text(
                        "${user!.email}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text("Verify your email."),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.black,
                      endIndent: width * 0.025,
                      indent: width * 0.025,
                    ),
                    Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Text(
                        emailVerify,
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BasicDetailsPage()));
    }
  }
}
