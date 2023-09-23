import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackrecordd/utils/constants.dart';
import 'package:trackrecordd/utils/functions.dart';
import 'package:trackrecordd/views/splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
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
