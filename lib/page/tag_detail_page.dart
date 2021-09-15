import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qiita_app1/component/tag_list.dart';

class TagDetailPage extends StatefulWidget {
  const TagDetailPage({Key key}) : super(key: key);
  @override
  _TagDetailPageState createState() => _TagDetailPageState();
}

class _TagDetailPageState extends State<TagDetailPage> {

  FetchTagDetail fetchTagDetail = FetchTagDetail();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar:AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: BackButton(
            color: HexColor("#468300"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            tagName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(28),
            child:Container(
              color: HexColor("#F2F2F2"),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical:8.0),
                    child: Text("投稿記事", style: TextStyle(color: HexColor("#828282"),),),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            )
          ),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<List<Article>>(
                future: FetchTagDetail.fetchArticle(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ArticleListView(articles: snapshot.data);
                  }
                  return Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator()
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ArticleListView extends StatefulWidget {
  final List<Article> articles;
  ArticleListView({Key key, this.articles}) : super(key: key);

  @override
  _ArticleListViewState createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  FetchTagDetail fetchTagDetail = FetchTagDetail();


  Widget _modal (Article article){
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
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
                  )
              ),
            ),
          ),
          Expanded(
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
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          FetchTagDetail.fetchArticle();
        },
        child: ListView.builder(
          itemCount: widget.articles.length,
          itemBuilder: (BuildContext context, int index) {
            final article = widget.articles[index];
            DateTime dateTime = DateTime.parse(article.updatedAt);
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
                        Text("投稿日:" + DateFormat('yyyy/M/d').format(dateTime)),
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          enableDrag: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return _modal(article);
                          });
                    },
                  ),
                  Divider(
                    height: 0,
                    thickness: 0.5,
                    color: HexColor('E0E0E0'),
                    indent: 70,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class FetchTagDetail {
  static Future<List<Article>> fetchArticle() async {
    final _url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +tagName+ "%3AQiita";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> tagArticleJsonArray = json.decode(response.body);
      print('Loaded New Article Data');
      return tagArticleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}