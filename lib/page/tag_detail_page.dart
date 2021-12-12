import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/component/article_list.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/page/error_page.dart';

class TagDetailPage extends StatefulWidget {
  TagDetailPage(this.tagName);
  final String tagName;
  @override
  _TagDetailPageState createState() => _TagDetailPageState();
}

class _TagDetailPageState extends State<TagDetailPage> {

  QiitaClient qiitaClient = QiitaClient();
  late Future<List<Article>> tagDetailList;

  @override
  void initState() {
    tagDetailList = QiitaClient.fetchTagDetail(widget.tagName, 1);
    super.initState();
  }

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
            return Text(
              widget.tagName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: "Pacifico",
              ),
            );
        })(),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(28),
            child:Container(
              color: HexColor(Constants.whiteSmoke),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical:8.0),
                    child: Text("投稿記事", style: TextStyle(color: HexColor(Constants.darkGrey),),),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            )
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Article>>(
            future: tagDetailList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () async {
                    tagDetailList = QiitaClient.fetchTagDetail(widget.tagName, 1);
                  },
                  child: ArticleListView(
                    articles: snapshot.data!,
                    onFieldSubmitted: "",
                  ),
                );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
              return ErrorPage(
                refreshFunction: () {
                  tagDetailList = QiitaClient.fetchTagDetail(widget.tagName, 1);
                  },
              );
              } else {
                return Text("データが存在しません");
              }
            },
          ),
        ),
      );
  }
}
