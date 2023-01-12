import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'map_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<NewsModel>().greeting),
        backgroundColor: Colors.teal[700],
      ),
      body: context.watch<NewsModel>().articles.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: ListView.builder(
                        itemCount: context.watch<NewsModel>().articles.length,
                        itemBuilder: (context, index) {
                          final article =
                              context.watch<NewsModel>().articles[index];
                          if (index == 0) {
                            return Card(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.network(
                                      article['urlToImage'],
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 10, 10),
                                      child: Text(
                                        article['title'] ?? '',
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 10, 15),
                                      child: Text(article['description'] ?? '',
                                          maxLines: 2),
                                    ),
                                  ]),
                            );
                          }
                          return Card(
                            child: ListTile(
                              leading: article['urlToImage'] == null
                                  ? const SizedBox(
                                      width: 110,
                                      height: 110,
                                    )
                                  : Image.network(
                                      article['urlToImage'],
                                      width: 110,
                                      height: 110,
                                    ),
                              title: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 5, 5, 5),
                                child: Text(
                                  article['title'] ?? '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 5, 5),
                                child: Text(
                                  article['description'] ?? '',
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapScreen()),
          );
        },
        child: const Text('Report'),
      ),
    );
  }
}
