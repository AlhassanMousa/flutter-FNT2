import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/splash_screen.dart';
import 'package:flutter_application_3/nav/Navigation_drawer.dart';

void main() {
  runApp(const MaterialApp(home: SplashScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Builder(builder: (context) {
        return Center(
            child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width - 100,
        ));
      }),
    );
  }
}
