import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/model/user.dart';

class QiitaClient {
  static Future<List<Article>> fetchArticle(String query) async {
    final _url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +query+ "%3AQiita";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> articleJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return articleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<List<Tag>> fetchTag() async {
    final _url = "https://qiita.com/api/v2/tags?page=1&per_page=20&sort=count";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> tagJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return tagJsonArray.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }

  static Future<List<Article>> fetchTagDetail(String query) async {
    final _url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +query+ "%3AQiita";
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> tagArticleJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return tagArticleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<User> fetchUserDetail() async {
    final _url = "https://qiita.com/api/v2/users/ko_cha78";
    final response = await http.get(Uri.parse(_url));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print(_url);
      //print(response.body);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load article');
    }
  }
}
