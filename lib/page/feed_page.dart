import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/component/article_list.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key key}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  QiitaClient qiitaClient = QiitaClient();

  //Kaoruさんのコード
  String onChangedText = '';
  final textController = TextEditingController();

  Widget _textField() {
    return TextFormField(
      autocorrect: true,
      controller: textController,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search, size: 25, color: Colors.grey,),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
      // フィールドのテキストが変更される度に呼び出される　　　　必要ない（？）
      onChanged: (value) {
        print('onChanged: $value');
        setState(() {
          onChangedText = value;
        });
      },
      // ユーザーがフィールドのテキストの編集が完了したことを示したときに呼び出される
      onFieldSubmitted: (value) {
        print('onFieldSubmitted: $value');
        setState(() {
          onFieldSubmittedText = value;
        });
      },
    );
  }
//ここまで


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
          title: Text(
            "Feed",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: _textField(),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<List<Article>>(
                future: QiitaClient.fetchArticle(),
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
