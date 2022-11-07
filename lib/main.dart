import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/news.dart';
import 'package:flutter_application_3/screens/splash_screen.dart';
import 'package:flutter_application_3/nav/Navigation_drawer.dart';
import 'package:flutter_application_3/localStorage.dart';
import 'package:flutter_application_3/screens/login_page.dart';

void main() {
  runApp(const MaterialApp(home: SplashScreen()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  late Future<List> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum() as Future<List>;
  }

  // This widget is the root of your application.

  bool isLoggedIn = false;

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("loggedin")
        .then((value) => setState(() {
              isLoggedIn = value;
            }));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Builder(builder: (context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: isLoggedIn ? NewsScreen() : LoginScreen());
      }),
    );
  }
}
