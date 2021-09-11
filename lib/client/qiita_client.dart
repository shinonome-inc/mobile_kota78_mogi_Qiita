import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/model/tag.dart';

String onFieldSubmittedText = "";
class QiitaClient {
  static Future<List<Article>> fetchArticle() async {
    final _url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +onFieldSubmittedText+ "%3AQiita HTTP/1.1";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> articleJsonArray = json.decode(response.body);
      return articleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}

class QiitaTags {
  static Future<List<Tag>> fetchTag() async {
    final _url = "https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count HTTP/1.1";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> tagJsonArray = json.decode(response.body);
      return tagJsonArray.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }
}
