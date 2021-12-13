import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/component/article_list.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/page/error_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  String _onFieldSubmitted = "";
  late Future<List<Article>> articleList;
  GlobalKey<ArticleListViewState> _key = GlobalKey();


  @override
  void initState() {
    articleList = QiitaClient.fetchArticle("", 1);
    super.initState();
  }

  //Kaoruさんのコード
  final textController = TextEditingController();

  Widget _textField() {
    return Container(
      height: 36,
      child: TextFormField(
        autocorrect: true,
        controller: textController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, size: 25, color: HexColor('#8E8E93'),),
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, 12, 12, 10),
          hintStyle: TextStyle(color: HexColor('#8E8E93')),
          filled: true,
          fillColor: HexColor('#EFEFF0'),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.transparent, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.redAccent, width: 1),
          ),
        ),
        // ユーザーがフィールドのテキストの編集が完了したことを示したときに呼び出される
        onFieldSubmitted: (value) {
          print('onFieldSubmitted: $value');
          _onFieldSubmitted = value;
          articleList = QiitaClient.fetchArticle(_onFieldSubmitted, 1);
          articleList.then(
                  (articleValue) {
                    print(articleValue[0].title);
                    _key.currentState!.setState(() {});
                  });
          },
      ),
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
            preferredSize: const Size.fromHeight(54),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  child: _textField(),
                ),
                Divider(
                  height: 0,
                  thickness: 0.5,
                  color: HexColor(Constants.separatingLineColor),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder<List<Article>>(
            future: articleList,
            builder: (BuildContext context,
                AsyncSnapshot<List<Article>> snapshot) {
             if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () async {
                    articleList = QiitaClient.fetchArticle(_onFieldSubmitted, 1);
                  },
                  child: ArticleListView(
                    key: _key,
                    articles: snapshot.data!,
                    onFieldSubmitted: _onFieldSubmitted,
                  ),
                );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return ErrorPage(
                  refreshFunction: () {
                    articleList = QiitaClient.fetchArticle("", 1);
                  },
                );
              } else {
                return Text("データが存在しません");
              }
            },
          ),
        ),
      ),
    );
  }
}
