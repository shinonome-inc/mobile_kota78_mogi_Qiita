import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/component/user_list.dart';
import 'package:qiita_app1/page/error_page.dart';

class FollowerPage extends StatefulWidget {
  final String userId;
  FollowerPage(this.userId);

  @override
  State<FollowerPage> createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  late Future<List<User>> followersList;
  @override
  void initState() {
    followersList = QiitaClient.fetchFollowers(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<User>>(
        future: followersList,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                followersList = QiitaClient.fetchFollowers(widget.userId);
              },
              child: (() {
                if (snapshot.data?.isEmpty ?? true) {
                  return Center(child: Text("まだフォローしていません"));
                } else {
                  return UserListView(users: snapshot.data!);
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
                followersList = QiitaClient.fetchFollowers(widget.userId);
              },
            );
          } else {
            return Text("データが存在しません");
          }
        },
      ),
    );
  }
}
