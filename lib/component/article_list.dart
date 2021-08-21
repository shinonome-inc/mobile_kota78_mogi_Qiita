import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:intl/intl.dart';


class ArticleListView extends StatefulWidget {
  final List<Article> articles;
  ArticleListView({Key key, this.articles}) : super(key: key);

  @override
  _ArticleListViewState createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  QiitaClient qiitaClient = QiitaClient();


  Widget _modal (Article article){
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
  }


  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          print('Loading New Data');
          QiitaClient.fetchArticle();
        },
        child: ListView.builder(
          itemCount: widget.articles.length,
          itemBuilder: (BuildContext context, int index) {
            final article = widget.articles[index];
            var year = article.updatedAt.substring(0,4);
            var month = article.updatedAt.substring(5,7);
            var day = article.updatedAt.substring(8,10);
            DateTime dateTime = DateTime(int.parse(year), int.parse(month), int.parse(day));
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
                          enableDrag: false,
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