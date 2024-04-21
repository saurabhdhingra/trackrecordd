import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackrecordd/views/authViews/login.dart';
// import 'package:trackrecord/database/models.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import 'package:trackrecordd/views/editExercisesView.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final auth = FirebaseAuth.instance;
  bool dark = false;
  void getThemeState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dark = (prefs.getInt('counter') ?? 0) == 0 ? false : true;
    });
  }

  void setThemeState(bool dark) async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    // final user = UserPreferences.myUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // title: Text('Settings',
        //     style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
        shadowColor: Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // profileSettings(width, height, context),
            SizedBox(height: height * 0.03),
            themeSettings(width, context, height, themeProvider),
            SizedBox(height: height * 0.02),
            editExercisesLink(width, context, height),
            SizedBox(height: height * 0.02),
            Center(
              child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(height / 38)),
                ),
                child: ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    auth.signOut();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginView(
                          isLogout: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Align profileSettings(width, height, BuildContext context) {
  //   return Align(
  //           alignment: Alignment.center,
  //           child: Container(
  //             width: width * 0.9,
  //             height: height * 0.28,
  //             decoration: BoxDecoration(
  //               color: Theme.of(context).primaryColor,
  //               borderRadius: BorderRadius.all(Radius.circular(height / 38)),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: <Widget>[
  //                 SizedBox(
  //                   height: height * 0.01,
  //                 ),
  //                 Container(
  //                   height: height / 35,
  //                   width: width,
  //                   child: Row(
  //                     children: [
  //                       SizedBox(
  //                         width: width * 0.7,
  //                       ),
  //                       IconButton(
  //                         onPressed: () {
  //                           print('Edit pressed');
  //                         },
  //                         icon: Icon(Icons.edit),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 CircleAvatar(
  //                   radius: height * 0.08,
  //                   backgroundImage: AssetImage(user.imagePath),
  //                 ),
  //                 Center(
  //                   child: Column(
  //                     children: [
  //                       Text(
  //                         user.name,
  //                         style: TextStyle(
  //                             fontSize: 25, fontWeight: FontWeight.bold),
  //                       ),
  //                       Text(
  //                         user.email,
  //                         style: TextStyle(
  //                             fontSize: 15, fontWeight: FontWeight.normal),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  // }

  Center themeSettings(width, BuildContext context, height, themeProvider) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(height / 38)),
        ),
        child: Column(
          children: [
            ListTile(
              title: const Text('Use Device Theme'),
              trailing: Platform.isIOS
                  ? CupertinoSwitch(
                      value: themeProvider.isSystem,
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleSystemTheme(value, dark);
                      },
                    )
                  : Switch(
                      value: themeProvider.isSystem,
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleSystemTheme(value, dark);
                      },
                    ),
            ),
            ListTile(
              title: const Text(
                'Dark mode',
              ),
              trailing: Platform.isIOS
                  ? CupertinoSwitch(
                      value: themeProvider.isDark,
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        setState(() {
                          dark = value;
                        });
                        provider.toggleTheme(value);
                      },
                    )
                  : Switch(
                      value: themeProvider.isDark,
                      onChanged: (value) {
                        final provider =
                            Provider.of<ThemeProvider>(context, listen: false);
                        setState(() {
                          dark = value;
                        });
                        provider.toggleTheme(value);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Center editExercisesLink(width, BuildContext context, height) {
    return Center(
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(height / 38)),
        ),
        child: ListTile(
          title: const Text('Edit Exercises'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditExercisesView()),
            );
          },
        ),
      ),
    );
  }
}
