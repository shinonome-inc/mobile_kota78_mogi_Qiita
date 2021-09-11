import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/component/tag_list.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key key}) : super(key: key);
  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  QiitaTags qiitaTag = QiitaTags();

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
          child: Column(
            children: [
              FutureBuilder<List<Tag>>(
                future: QiitaTags.fetchTag(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return TagListView(tags: snapshot.data);
                  }
                  return Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator()
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
