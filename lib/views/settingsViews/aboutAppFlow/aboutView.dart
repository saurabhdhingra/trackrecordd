import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trackrecordd/views/settingsViews/aboutAppFlow/privacyPolicy.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String version = "";

  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  @override
  void initState() {
    super.initState();
    getVersionInfo();
  }

  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    // final user = UserPreferences.myUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: Image.asset(
                            'images/icon.png',
                          ).image,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'TrackRecord',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Version $version Beta',
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 20),
                child: Text(
                  'This app was born out of my need to measure and visualize my growth in gym . \n\nGyms are a reality escape and as much as I want this app to help you to monitor and streamline your fitness journey I also want you to be responsible in using it. Comparing your growth with someone else or working out too much can have negative consequencces. \n\nHope you like what I have done. \n\nSaurabh Dhingra',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              // ListTile(
              //   shape: StadiumBorder(),
              //   title: Text(
              //     'Packages and Plugins',
              //     style: TextStyle(),
              //   ),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios,
              //     size: 20,
              //   ),
              //   tileColor: Theme.of(context).colorScheme == ColorScheme.dark()
              //       ? Colors.grey[900]
              //       : Colors.grey[400],
              //   dense: false,
              // ),
              // SizedBox(height: height * 0.01),
              SizedBox(height: height * 0.01),
              Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(height / 38)),
                ),
                child: ListTile(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const PrivacyPolicyPage();
                        },
                      ),
                    );
                  },
                  title: const Text(
                    'Privacy Policy',
                    style: TextStyle(),
                  ),
                  trailing: const Icon(
                    Icons.lock,
                    size: 20,
                  ),
                  dense: false,
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(height / 38)),
                ),
                child: ListTile(
                  onTap: () async {
                    const url =
                        'https://play.google.com/store/apps/details?id=com.saurabh.trackrecordd';
                    RenderBox? box = context.findRenderObject() as RenderBox;
                    await Share.share(
                        'Track your workouts with TrackRecord.\n\nDownload for Android : \n\n$url',
                        subject: 'Share Play Store Link',
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                  title: const Text(
                    'Share app',
                    style: TextStyle(),
                  ),
                  trailing: const Icon(
                    Icons.share_outlined,
                    size: 20,
                  ),
                  dense: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
