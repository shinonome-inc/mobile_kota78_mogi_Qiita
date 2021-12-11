import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/component/tag_list.dart';

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
          child: FutureBuilder<List<Tag>>(
            future: tagList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TagListView(tags: snapshot.requireData);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
