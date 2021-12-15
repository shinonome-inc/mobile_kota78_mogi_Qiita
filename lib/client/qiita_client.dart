import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/model/user.dart';

class QiitaClient {

  static String accessToken ="";

  static Future<List<Article>> fetchArticle(String query, int pageNumber) async {
    print(pageNumber);
    final _url = "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20&query=$query";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
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
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> tagJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return tagJsonArray.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tags');
    }
  }

  static Future<List<Article>> fetchTagDetail(String query, int pageNumber) async {
    final _url = "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20&query=$query";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> tagArticleJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return tagArticleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<User> fetchMyProfile() async {
    final _url = "https://qiita.com/api/v2/authenticated_user";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print(_url);
      Map userMap = json.decode(response.body);
      var user = new User.fromJson(userMap);
      print(response.body);
      return user;
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<List<Article>> fetchMyArticle() async {
    final _url = "https://qiita.com/api/v2/authenticated_user/items";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> articleJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return articleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<List<User>> fetchFollowers(String userId) async {
    final _url = "https://qiita.com/api/v2/users/$userId/followees";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> followersJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return followersJsonArray.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load followers');
    }
  }

  static Future<List<User>> fetchFollowees(String userId) async {
    final _url = "https://qiita.com/api/v2/users/$userId/followers";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> followeesJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return followeesJsonArray.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load followees');
    }
  }

  static Future<User> fetchUserProfile(String userId) async {
    final _url = "https://qiita.com/api/v2/users/$userId";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print(_url);
      Map userMap = json.decode(response.body);
      var user = new User.fromJson(userMap);
      print(response.body);
      return user;
    } else {
      throw Exception('Failed to load article');
    }
  }

  static Future<List<Article>> fetchUserArticle(String userId, int pageNumber) async {
    final _url = "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20&query=$userId";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> userArticleJsonArray = json.decode(response.body);
      print(_url);
      print(response.body);
      return userArticleJsonArray.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load article');
    }
  }
}
