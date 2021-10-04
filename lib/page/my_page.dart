import 'package:flutter/material.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/client/qiita_client.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
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
            future: QiitaClient.fetchUserDetail(),
            builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      QiitaClient.fetchUserDetail();
                    },
                    child: Text(""),
                  ),
                );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
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