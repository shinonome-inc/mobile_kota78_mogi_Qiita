import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:qiita_app1/hex_color.dart';

class User {
  final String id;
  final String iconUrl;
  User({this.id, this.iconUrl});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      iconUrl: json['profile_image_url'],
    );
  }
}

class Article {
  final String updated_at;
  final String title;
  final String url;
  final User user;

  Article({this.updated_at, this.title, this.url, this.user});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      updated_at: json['updated_at'],
      title: json['title'],
      url: json['url'],
      user: User.fromJson(json['user']),
    );
  }
}

class QiitaClient {
  static Future<List<Article>> fetchArticle() async {
    final url = 'https://qiita.com/api/v2/items';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}

class ArticleListView extends StatelessWidget {
  final List<Article> articles;
  ArticleListView({Key key, this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (BuildContext context, int index) {
        final article = articles[index];
        return Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 19.0,
                  backgroundImage: NetworkImage(article.user.iconUrl),
                ),
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Text("@"+ article.user.id),
                    SizedBox(width: 5.0,),
                    Text("投稿日:" + article.updated_at.substring(0,4)
                        + "/" + article.updated_at.substring(5,7)
                        + "/" + article.updated_at.substring(8,10)
                    ),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet(
                    enableDrag: false,
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: size.height * 0.85,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex:1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: const BorderRadius.only(
                                      topRight: const Radius.circular(20),
                                      topLeft: const Radius.circular(20),
                                    ),
                                  ),
                                  child: Align(alignment: Alignment.center,
                                      child: Text("Article",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Pacifico'
                                        ),
                                      )
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:10,
                                child: Container(
                                  color: Colors.white,
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: WebView(initialUrl: article.url,)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor('E0E0E0'),
              ),
            ],
          ),

        );
      },
    );
  }
}

class FeedPage extends StatelessWidget {
  final Future<List<Article>> articles = QiitaClient.fetchArticle();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar:AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Feed",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Article>>(
            future: articles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ArticleListView(articles: snapshot.data);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}