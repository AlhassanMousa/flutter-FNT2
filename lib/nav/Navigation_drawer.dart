import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/news.dart';
import 'package:flutter_application_3/screens/login_page.dart';
import 'package:flutter_application_3/nav/drawer_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter_application_3/components/loading.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Navigation();
  }
}

class Navigation extends State<NavigationDrawer> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String? name;
  String? email;
  bool? isLogin = false;
  Future<void> verityFirstRun() async {
    final verification = await SharedPreferences.getInstance();
    setState(() => name = verification.getString('name'));
    setState(() => email = verification.getString('email'));
    setState(() => isLogin = verification.getBool('isLogin'));
  }

  @override
  void initState() {
    verityFirstRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromARGB(255, 30, 96, 103),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                thickness: 1,
                height: 10,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              DrawerItem(
                name: 'News',
                icon: Icons.newspaper,
                onPressed: () => onItemPressed(context, index: 0),
              ),
              DrawerItem(
                name: (isLogin == true) ? 'LogOut' : 'LogIn',
                icon: (isLogin == true)
                    ? Icons.logout_rounded
                    : Icons.login_rounded,
                onPressed: (isLogin == false)
                    ? () => onItemPressed(context, index: 1)
                    : () => LogoutScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    // print('here${MySharedPreferences.getStringValue('username')}');

    switch (index) {
      case 0:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const NewsScreen();
        }));
        break;
      case 1:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }));
        break;
    }
  }

  Widget headerWidget() {
    return Row(
      children: [
        CircleAvatar(
            radius: 25.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: (isLogin == true)
                  ? Image.asset("assets/avatar.png")
                  : Image.asset("assets/notAvatar.png"),
            )),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((isLogin == true) ? '$name' : '',
                style: const TextStyle(fontSize: 15, color: Colors.white)),
            const SizedBox(
              height: 10,
            ),
            Text((isLogin == true) ? '$email' : '',
                style: TextStyle(fontSize: 12, color: Colors.white))
          ],
        ),
      ],
    );
  }

  LogoutScreen() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('phone');
    await prefs.remove('email');
    await prefs.remove('id');
    await prefs.setBool('isLogin', false);
  }
}








/*
  final fuck = () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nom = prefs.getString('name');
    return nom;
  };



 */