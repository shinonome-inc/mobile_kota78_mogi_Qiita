import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/model/tag.dart';

String onFieldSubmittedText = "";
class QiitaClient {
  static Future<List<Article>> fetchArticle() async {
    final _url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +onFieldSubmittedText+ "%3AQiita";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> articleJsonArray = json.decode(response.body);
      print('Loaded New Article Data');
      return articleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}

class QiitaTags {
  static Future<List<Tag>> fetchTag() async {
    final _url = "https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> tagJsonArray = json.decode(response.body);
      print('Loaded New Tag Data');
      return tagJsonArray.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }
}

String tagName = "";
class FetchTagDetail {
  static Future<List<Article>> fetchArticle() async {
    final _url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +tagName+ "%3AQiita";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> tagArticleJsonArray = json.decode(response.body);
      print('Loaded New Article Data');
      return tagArticleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}