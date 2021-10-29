import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/component/user_list.dart';

class FollowPage extends StatelessWidget {
  final String userId;
  FollowPage(this.userId);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<User>>(
        future: QiitaClient.fetchFollowees(userId),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                QiitaClient.fetchFollowees(userId);
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
            return Text(snapshot.error.toString());
          } else {
            return Text("データが存在しません");
          }
        },
      ),
    );
  }
}
