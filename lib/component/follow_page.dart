import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/component/user_list.dart';
import 'package:qiita_app1/page/error_page.dart';

class FollowPage extends StatefulWidget {
  final String userId;
  FollowPage(this.userId);

  @override
  State<FollowPage> createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  late Future<List<User>> followeesList;
  @override
  void initState() {
    followeesList = QiitaClient.fetchFollowees(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<User>>(
        future: followeesList,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                followeesList = QiitaClient.fetchFollowees(widget.userId);
              },
              child: (() {
                if (snapshot.data?.isEmpty ?? true) {
                  return Center(child: Text("まだフォローされていません"));
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
                followeesList = QiitaClient.fetchFollowees(widget.userId);
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
