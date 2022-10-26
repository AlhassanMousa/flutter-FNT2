import 'package:flutter/material.dart';
import 'package:flutter_application_3/nav/Navigation_drawer.dart';

class News extends StatefulWidget {
  News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: Text("News Screen"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Column(
              children: [
                Text('News',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w900)),
                const SizedBox(height: 5),
                Text(
                  'News from all over world ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search",
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: const Icon(Icons.tune, color: Colors.grey)))
              ],
            )
          ],
        ));
  }
}




/*
SafeArea(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 100),
          //Hello Again!
          Text(
            "! ii بك",
          ),
        ])),
      ),

 */