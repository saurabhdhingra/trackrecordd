import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/utils/functions.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future openBrowserURL({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: inApp, forceWebView: inApp, enableJavaScript: true);
    }
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
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'TrackRecord',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        'Version 1.0.5 Beta',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
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
                    const url =
                        'https://eager-burn-a3e.notion.site/PRIVACY-POLICY-c7b9a85947e947c5ab94f0ddac5f601d';
                    openBrowserURL(url: url, inApp: true);
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
