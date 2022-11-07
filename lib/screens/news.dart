import 'package:flutter/material.dart';
import 'package:flutter_application_3/nav/Navigation_drawer.dart';
import 'package:flutter_application_3/article_model.dart';
import 'package:flutter_application_3/components/image_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

var articles;
Future<List> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      ''));
  if (response.statusCode == 200) {
    // print(json.decode(response.body)['data']);
    print('ll${json.decode(response.body)['data']}');
    articles = json.decode(response.body)['data'];
    return json.decode(response.body)['data'];
  } else {
    throw Exception('Failed to load album');
  }
}

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> tabs = [];

    return DefaultTabController(
      initialIndex: 0,
      length: tabs.length,
      child: Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text("Sign In Screen"),
          centerTitle: true,
        ),
        body: ListView(
          children: [const _TopScreen(), _NewsList(tabs: tabs)],
        ),
      ),
    );
  }
}

class Album {}

class _NewsList extends StatelessWidget {
  const _NewsList({
    Key? key,
    required this.tabs,
  }) : super(key: key);
  final List<String> tabs;

  @override
  Widget build(BuildContext context) {
    final articles = Article.articles;
    return Column(children: [
      TabBar(
        isScrollable: true,
        indicatorColor: Colors.black,
        tabs: tabs
            .map(
              (tab) => Tab(
                icon: Text(
                  tab,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            )
            .toList(),
      ),
      SizedBox(
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            children: tabs
                .map(
                  (tab) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        /*  onTap: () {
                          Navigator.pushNamed(
                            context,
                            ArticleScreen.routeName,
                            arguments: articles[index],
                          );
                        },*/
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
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                )
                .toList(),
          ))
    ]);
  }
}

/**************************************************************/

class _TopScreen extends StatelessWidget {
  const _TopScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(fetchAlbum());
    print('qq $articles');

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Discover',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Text(
            'News from all over the world',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: Colors.grey.shade200,
              filled: true,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              suffixIcon: const RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.tune,
                  color: Colors.grey,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
