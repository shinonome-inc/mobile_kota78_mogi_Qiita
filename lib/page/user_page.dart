import 'package:flutter/material.dart';
import 'package:qiita_app1/component/article_list.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/page/follow_follower_page.dart';
import 'package:qiita_app1/page/error_page.dart';

class UserPage extends StatefulWidget {
  final String userId, userName;
  UserPage(this.userId, this.userName);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  late Future<User> userProfile;
  @override
  void initState() {
    QiitaClient.fetchUserProfile(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          bottomOpacity: 0.0,
          backgroundColor: HexColor(Constants.white),
          leading: BackButton(
            color: HexColor("#468300"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          shape: Border(bottom: BorderSide(color: HexColor(Constants.grey), width: 0.3)),
          title: Text(
            widget.userName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: Container(color: HexColor(Constants.white),)),
            Center(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<User>(
                      future: userProfile,
                      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                        if (snapshot.hasData) {
                          return UserPageView(userData: snapshot.data!, userId: widget.userId,);
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
                              userProfile = QiitaClient.fetchUserProfile(widget.userId);
                            },
                          );
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

class UserPageView extends StatefulWidget {
  final String userId;
  final User userData;
  UserPageView({Key? key,required this.userData, required this.userId}) : super(key: key);

  @override
  State<UserPageView> createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {
  late Future<List<Article>> userArticle;
  @override
  void initState() {
    QiitaClient.fetchUserArticle(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      fontSize: 20
                    ),
                  ),
                ),
                Text("@${widget.userData.id ?? "id未設定"}",

                  style: TextStyle(
                    color: HexColor(Constants.darkGrey),
                    fontSize: 12
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
                          MaterialPageRoute(builder: (context) => FollowFollowerPage(false, widget.userData.id ?? "", widget.userData.userName ?? "")),
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
                          MaterialPageRoute(builder: (context) => FollowFollowerPage(true, widget.userData.id ?? "", widget.userData.userName ?? "")),
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
            future: userArticle,
            builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      userArticle = QiitaClient.fetchUserArticle(widget.userId);
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
                    userArticle = QiitaClient.fetchUserArticle(widget.userId);
                  },
                );
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
