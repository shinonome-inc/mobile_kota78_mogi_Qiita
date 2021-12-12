import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/model/article.dart';
import 'package:intl/intl.dart';
import 'package:qiita_app1/component/modal.dart';


class ArticleListView extends StatefulWidget {
  final List<Article> articles;
  final String onFieldSubmitted;
  ArticleListView({Key? key,required this.articles, required this.onFieldSubmitted}) : super(key: key);

  @override
  _ArticleListViewState createState() => _ArticleListViewState();
}
class _ArticleListViewState extends State<ArticleListView> {
  QiitaClient qiitaClient = QiitaClient();

  List<Article>? _articles;
  int pageNumber = 1;
  bool addPage = true;

  ScrollController? _scrollController;
  @override
  void initState() {
    super.initState();
    _articles = widget.articles;
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double positionRate =
        _scrollController!.offset / _scrollController!.position.maxScrollExtent;
    const threshold = 0.8;
    if (positionRate > threshold) {
      if (addPage) {
        pageNumber ++;
        addPage = false;
        setState(() {
          QiitaClient.fetchArticle(widget.onFieldSubmitted, pageNumber)
              .then((value) {
            _articles = _articles! + value;
            addPage = true;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _articles!.length,
      itemBuilder: (BuildContext context, int index) {
        final article = _articles![index];
        DateTime dateTime = DateTime.parse(article.updatedAt);
        return Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 19.0,
                  backgroundImage: NetworkImage(article.user.iconUrl!),
                ),
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Text("@"+ article.user.id!),
                    SizedBox(width: 5.0,),
                    Text("投稿日:" + DateFormat('yyyy/M/d').format(dateTime)),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Modal(url: article.url);
                      });
                },
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 70,
              ),
            ],
          ),
        );
      },
    );
  }
}


class UserArticleListView extends StatefulWidget {
  final List<Article> articles;
  UserArticleListView({Key? key,required this.articles}) : super(key: key);

  @override
  _UserArticleListViewState createState() => _UserArticleListViewState();
}
class _UserArticleListViewState extends State<UserArticleListView> {
  QiitaClient qiitaClient = QiitaClient();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.articles.length,
      itemBuilder: (BuildContext context, int index) {
        final article = widget.articles[index];
        DateTime dateTime = DateTime.parse(article.updatedAt);
        return Card(
          elevation: 0,
          margin: EdgeInsets.all(0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: HexColor(Constants.black),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text("@"+ article.user.id!),
                    SizedBox(width: 5.0,),
                    Text("投稿日:" + DateFormat('yyyy/M/d').format(dateTime)),
                  ],
                ),
                onTap: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Modal(url: article.url);
                      });
                },
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.grey),
                indent: 16,
              ),
            ],
          ),
        );
      },
    );
  }
}

