import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/component/tag_list.dart';
import 'package:qiita_app1/page/error_page.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  late Future<List<Tag>> tagList;
  @override
  void initState() {
    tagList = QiitaClient.fetchTag();
    super.initState();
  }

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
            "Tags",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        body: Center(
          child:FutureBuilder<List<Tag>>(
            future: tagList,
            builder: (BuildContext context,
                AsyncSnapshot<List<Tag>> snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () async {
                    tagList = QiitaClient.fetchTag();
                  },
                  child: TagListView(tags: snapshot.requireData),
                );
              }
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return ErrorPage(
                  refreshFunction: () {
                    tagList = QiitaClient.fetchTag();
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
