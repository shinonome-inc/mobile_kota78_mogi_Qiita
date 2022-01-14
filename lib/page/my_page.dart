import 'package:flutter/material.dart';
import 'package:qiita_app1/component/article_list.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/page/follow_follower_page.dart';
import 'package:qiita_app1/page/error_page.dart';

class MyPage extends StatefulWidget {

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<User> myProfile;
  @override
  void initState() {
    myProfile = QiitaClient.fetchMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: HexColor(Constants.white),
          shape: Border(bottom: BorderSide(color: HexColor(Constants.grey), width: 0.3)),
          title: Text(
            "MyPage",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: myProfile,
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
                return ErrorPage(
                  refreshFunction: () {
                    myProfile = QiitaClient.fetchMyProfile();
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

class MyPageView extends StatefulWidget {
  final User userData;
  MyPageView({Key? key,required this.userData}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  late Future<List<Article>> myArticleList;
  @override
  void initState() {
    myArticleList = QiitaClient.fetchMyArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: HexColor(Constants.white),)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.userData.iconUrl != null ?
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(widget.userData.iconUrl!),
                    ) :
                    CircleAvatar(
                      radius: 40.0,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 4),
                      child: Text(
                        widget.userData.userName ?? "ユーザー名未設定",
                        style: TextStyle(
                          color: HexColor(Constants.black),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      "@${widget.userData.id ?? "id未設定"}",
                      style: TextStyle(
                        color: HexColor(Constants.darkGrey),
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Text(
                        widget.userData.description != null ? widget.userData.description! : "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new FollowFollowerPage(false, widget.userData.id ?? "", widget.userData.userName ?? "")),
                            );
                          },
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: HexColor(Constants.black),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userData.followeesCount.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "フォロー中",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]
                              )
                          ),
                        ),
                        SizedBox(width: 8.0,),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new FollowFollowerPage(true, widget.userData.id ?? "", widget.userData.userName ?? "")),
                            );
                          },
                          child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                    color: HexColor(Constants.black),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.userData.followersCount.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "フォロワー",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: HexColor(Constants.whiteSmoke),
              height: 28,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Text(
                      "投稿記事",
                      style: TextStyle(
                        color: HexColor(Constants.darkGrey),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: myArticleList,
                builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        myArticleList = QiitaClient.fetchMyArticle();
                      },
                      child: (() {
                        if (snapshot.data?.isEmpty ?? true) {
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
                    return ErrorPage(
                        refreshFunction: () {
                          myArticleList = QiitaClient.fetchMyArticle();
                        }
                    );
                  } else {
                    return Text("データが存在しません");
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}