import 'package:flutter/material.dart';
import 'package:flutter_application_3/components/image_container.dart';
import 'package:flutter_application_3/nav/Navigation_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);
  @override
  _FirstScreenState createState() => _FirstScreenState();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class _FirstScreenState extends State<NewsScreen> {
  String apiUrl =
      'https://us-central1-takweed-eg.cloudfunctions.net/client/posts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text("News Screen"),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<Articles>>(
            future: fetchArticles(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Articles> articles = snapshot.data as List<Articles>;
                return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        child: Row(
                          children: [
                            ImageContainer(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(17.0),
                              borderRadius: 5,
                              imageUrl: articles[index].imageUrl,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  articles[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            )),
                            //  Text(articles[index].createdAt),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.schedule,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${DateTime.now().difference(articles[index].createdAt).inHours} hours ago',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 20),
                                const Icon(
                                  Icons.visibility,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${articles[index].views} views',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text('error');
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Future<List<Articles>> fetchArticles() async {
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'otptoken': 'TakweedFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ',
      },
    );
    return (json.decode(response.body)['data'] as List)
        .map((e) => Articles.fromJson(e))
        .toList();
  }
}

class Articles {
  String id;
  String title;
  String? createdAt;
  int views;
  String imageUrl;

  Articles({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.views,
    required this.imageUrl,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
        id: json['_id'],
        title: json['title'],
        createdAt: json['createdAt'],
        views: json['views'],
        imageUrl: json['imageUrl']);
  }
}
