import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'package:trackrecordd/views/authViews/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final ThemeProvider themeProvider = ThemeProvider();
  final ShowcaseActionProvider actionProvider = ShowcaseActionProvider();

  themeProvider.getTheme();

  runApp(MyApp(
    themeProvider: themeProvider,
    actionProvider: actionProvider,
  ));
}

class MyApp extends StatefulWidget {
  final ThemeProvider themeProvider;
  final ShowcaseActionProvider actionProvider;
  const MyApp({
    super.key,
    required this.themeProvider,
    required this.actionProvider,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => widget.themeProvider),
          Provider(create: (_) => widget.actionProvider),
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            title: 'TrackRecord',
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        },
      );
}
