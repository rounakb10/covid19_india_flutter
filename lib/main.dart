import 'package:covidindiaflutter/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getBool('isSortedByTotal') == null) {
    preferences.setBool('isSortedByTotal', false);
  }
  runApp(
    ChangeNotifierProvider(
      child: MyApp(),
      create: (BuildContext context) {
        return ThemeChanger(
            isDarkMode: preferences.getBool('isDarkTheme') != null
                ? preferences.getBool('isDarkTheme')
                : true,
            isSortedByTotal: preferences.getBool('isSortedByTotal') != null
                ? preferences.getBool('isSortedByTotal')
                : false);
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, themeChanger, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeChanger.getTheme,
          home: LoadingScreen(),
        );
      },
    );
  }
}
