import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/component/article_list.dart';
import 'package:qiita_app1/client/qiita_client.dart';

class TagDetailPage extends StatefulWidget {
  TagDetailPage(this.tagName);
  final String tagName;
  @override
  _TagDetailPageState createState() => _TagDetailPageState();
}

class _TagDetailPageState extends State<TagDetailPage> {

  QiitaClient qiitaClient = QiitaClient();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: HexColor("#468300"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: (() {
          if (widget.tagName == null) {
            return Text(
              widget.tagName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: "Pacifico",
              ),
            );
          }
        })(),
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
                future: QiitaClient.fetchTagDetail(widget.tagName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          QiitaClient.fetchTagDetail(widget.tagName);
                        },
                        child: ArticleListView(articles: snapshot.data!,),
                        //child: articleListView(snapshot.data),
                      ),
                    );
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
      );
  }
}
