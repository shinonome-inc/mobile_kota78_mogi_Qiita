import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/page/tag_detail_page.dart';



class TagListView extends StatefulWidget {
  final List<Tag> tags;
  TagListView({Key key, this.tags}) : super(key: key);

  @override
  _TagListViewState createState() => _TagListViewState();
}

class _TagListViewState extends State<TagListView> {
  QiitaTags qiitaTags = QiitaTags();
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RefreshIndicator(
          onRefresh: () async {
            QiitaTags.fetchTag();
          },
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 162 / 138,
              crossAxisCount: 2,
            ),
            itemCount: widget.tags.length,
            itemBuilder: (BuildContext context, int index) {
              final tag = widget.tags[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      tagName =tag.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TagDetailPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#E0E0E0'),),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                          mainAxisAlignment:MainAxisAlignment.center ,
                          children: <Widget>[
                        (() {
                          if (tag.iconUrl == null) {
                            return Icon(Icons.cancel, size: 38,);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Container(
                                height: 38,
                                width: 38,
                                child: Image.network(tag.iconUrl),
                              ),
                            );
                          }
                        })(),
                        SizedBox(
                          height: 20,
                          child: Text(
                            tag.id,
                            style: TextStyle(
                              color: HexColor(constants.black),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Column(
                            children: [
                              Text(
                                "記事件数:" + tag.itemsCount.toString(),
                                style: TextStyle(color: HexColor('#828282'), fontSize: 12),
                              ),
                              Text(
                                "フォロワー数" + tag.followersCount.toString(),
                                style: TextStyle(color: HexColor('#828282'), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ]
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}