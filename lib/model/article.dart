import 'package:qiita_app1/model/user.dart';

class Article {
  final String updatedAt;
  final String title;
  final String url;
  final User user;

  Article({required this.updatedAt, required this.title, required this.url, required this.user});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      updatedAt: json['updated_at'],
      title: json['title'],
      url: json['url'],
      user: User.fromJson(json['user']),
    );
  }
}