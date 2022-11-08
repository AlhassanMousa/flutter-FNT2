import 'package:flutter/material.dart';
import 'package:flutter_application_3/nav/Navigation_drawer.dart';
import 'package:flutter_application_3/screens/news.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/components/loading.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _SigninState();
}

class _SigninState extends State<LoginScreen> {
  TextEditingController phoneNum = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLogin = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text("Sign In Screen"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Icon(
                Icons.login,
                size: 100,
              ),
              SizedBox(height: 100),
              //Hello Again!
              Text(
                "! مرحبا بك",
              ),
              SizedBox(height: 10),
              Text('Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 50),

              //Email textField
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: phoneNum,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'رقم الهاتف'),
                        )),
                  )),

              SizedBox(height: 10),
              //Password textField
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          obscureText: true,
                          controller: password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'كلمة المرور '),
                        )),
                  )),
              SizedBox(height: 10),

              //signin Button
              ElevatedButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(50, 5, 50, 5),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  loginUser();
                },
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ]))));
  }

  void loginUser() async {
    Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
    var url = "https://us-central1-takweed-eg.cloudfunctions.net/auth/login/";
    final prefs = await SharedPreferences.getInstance();

    var values = {
      "phone": '+2${phoneNum.text}',
      "password": password.text,
    };

    var urlParser = Uri.parse(url);
    Response response = await http.post(
      urlParser,
      body: json.encode(values),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'otptoken': 'TakweedFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ',
      },
    );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const NewsScreen();
    }));

    var respo = json.decode(response.body);
    var name = respo['data']['name'];
    var phone = respo['data']['phone'];
    var email = respo['data']['email'];
    var id = respo['data']['nationalId'];
    //  var accessToken = respo['data']['accessToken'];
    //  MySharedPreferences.instance.setStringValue("username", name);
    await prefs.setString('name', name);
    await prefs.setString('phone', phone);
    await prefs.setString('email', email);
    await prefs.setString('id', id);
    await prefs.setBool('isLogin', true);
  }

  void getArt() async {
    var url = "https://us-central1-takweed-eg.cloudfunctions.net/client/posts";
    final prefs = await SharedPreferences.getInstance();
    Response response = await http.get(Uri.parse(url));
    var respo = json.decode(response.body);
    var articles = respo['respo']['data'];
    await prefs.setString('articles', articles);
  }
}
