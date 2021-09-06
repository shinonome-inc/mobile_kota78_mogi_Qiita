import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_app1/model/article.dart';

String onFieldSubmittedText = "";
class QiitaClient {
  static Future<List<Article>> fetchArticle() async {
    final url = "https://qiita.com/api/v2/items?page=1&per_page=20&query=" +onFieldSubmittedText+ "%3AQiita HTTP/1.1";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonArray = json.decode(response.body);
      return jsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}
