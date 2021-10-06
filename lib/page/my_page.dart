import 'package:flutter/material.dart';
import 'package:qiita_app1/component/article_list.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/article.dart';

class MyPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: HexColor("#FFFFFF"),
          shape: Border(bottom: BorderSide(color: HexColor("#B2B2B2"), width: 0.3)),
          title: Text(
            "MyPage",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: Container(color: HexColor("#FFFFFF"),)),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<User>(
                      future: QiitaClient.fetchMyProfile(),
                      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                        if (snapshot.hasData) {
                          return MyPageView(userData: snapshot.data!,);
                        }
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator()
                          );
                        }
                        if (snapshot.hasError) {
                          print(snapshot.error.toString());
                          return Text(snapshot.error.toString());
                        } else {
                          return Text("データが存在しません");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPageView extends StatelessWidget {
  final User userData;
  MyPageView({Key? key,required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 256,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 16),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(userData.iconUrl!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: Text(
                      userData.userName!,
                      style: TextStyle(
                        color: HexColor(Constants.black),
                        fontSize: 20
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: Text(
                      "@"+ userData.id!,
                      style: TextStyle(
                        color: HexColor("#828282"),
                        fontSize: 12
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                    child: Text(
                      userData.description != null ? userData.description! : "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: HexColor(Constants.black)
                            ),
                            children: [
                              TextSpan(
                                text: userData.followeesCount.toString(),
                              ),
                              TextSpan(
                                text: "フォロー中",
                              ),
                              WidgetSpan(child: SizedBox(width: 8,)),
                              TextSpan(
                                text: userData.followersCount.toString(),
                              ),
                              TextSpan(
                                text: "フォロワー",
                              ),
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: HexColor("#F2F2F2"),
          height: 28,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: Text(
                  "投稿記事",
                  style: TextStyle(
                    color: HexColor("#828282"),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 361,
          child: FutureBuilder<List<Article>>(
            future: QiitaClient.fetchMyArticle(),
            builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      QiitaClient.fetchMyArticle();
                      },
                    child: (() {
                      if (snapshot.data!.isEmpty == true) {
                        return Center(child: Text("まだ投稿がありません"));
                      } else {
                        return UserArticleListView(articles: snapshot.data!);
                      }
                    })(),
                  );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Text("データが存在しません");
              }
            },
          ),
        ),
      ],
    );
  }
}
