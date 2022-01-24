import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qiita_app1/model/article.dart';
import 'package:qiita_app1/model/tag.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QiitaClient {

  static final  clientID       = env['CLIENT_ID'] ?? "";
  static final  clientSecret   = env['CLIENT_SECRET'] ?? "";
  static final  keyAccessToken = 'qiita/accessToken';

  static Future<Map<String, String>> getHeader() async {
    final _accessToken = await getAccessToken();
    final _accessTokenIsSaved = await accessTokenIsSaved();
    return _accessTokenIsSaved ?
    {
      'Authorization': 'Bearer $_accessToken'
    } : {};
  }

  static String createdAuthorizeUrl(String state) {
    final scope = 'read_qiita%20write_qiita';
    String _url = 'https://qiita.com/api/v2/oauth/authorize?client_id=$clientID&scope=$scope&state=$state';
    return _url;
  }

  static Future<String> createAccessTokenFromCallbackUri(Uri uri,
      String expectedState) async {
    final String? state = uri.queryParameters['state'];
    final String? code  = uri.queryParameters['code'];
    if (expectedState != state) {
      throw Exception('the state is different from expectedState');
    }

    final response = await http.post(
      Uri.parse('https://qiita.com/api/v2/access_tokens'),
      headers: {
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'client_id': clientID,
        'client_secret': clientSecret,
        'code': code,
      }),
    );
    final body = jsonDecode(response.body);
    final accessTokenn = body['token'];

    return accessTokenn;
  }

  static Future<void> saveAccessToken(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyAccessToken, accessToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken);
  }

  static Future<void> deleteAccessToken() async {
    final _accessToken = await getAccessToken();
    String url = "https://qiita.com/api/v2/access_tokens/$_accessToken";
    final response = await http.delete(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 204) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(keyAccessToken);
    } else {
      throw Exception('Failed to delete');
    }
  }

  static Future<bool> accessTokenIsSaved() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  static Future<List<Article>> fetchArticle(String query, int pageNumber) async {
    final header = await getHeader();
    print(pageNumber);
    final _url = (query == "")
        ? "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20"
        : "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20&query=$query"
    ;
    final response = await http.get(
      Uri.parse(_url),
      headers: header,
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

  static Future<List<Tag>> fetchTag(int pageNumber) async {
    final header = await getHeader();
    print(pageNumber);
    final _url = "https://qiita.com/api/v2/tags?page=$pageNumber&per_page=20&sort=count";
    final response = await http.get(
      Uri.parse(_url),
        headers: header
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
    final header = await getHeader();
    final _url = "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20&query=$query";
    final response = await http.get(
      Uri.parse(_url),
        headers: header
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
    final _accessToken = await getAccessToken();
    final _url = "https://qiita.com/api/v2/authenticated_user";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_accessToken',
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
    final _accessToken = await getAccessToken();
    final _url = "https://qiita.com/api/v2/authenticated_user/items";
    final response = await http.get(
      Uri.parse(_url),
      headers: {
        'Authorization': 'Bearer $_accessToken',
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
    final header = await getHeader();
    final _url = "https://qiita.com/api/v2/users/$userId/followees";
    final response = await http.get(
      Uri.parse(_url),
        headers: header
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
    final header = await getHeader();
    final _url = "https://qiita.com/api/v2/users/$userId/followers";
    final response = await http.get(
      Uri.parse(_url),
        headers: header
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
    final header = await getHeader();
    final _url = "https://qiita.com/api/v2/users/$userId";
    final response = await http.get(
      Uri.parse(_url),
        headers: header
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
    final header = await getHeader();
    print(pageNumber);
    final _url = "https://qiita.com/api/v2/items?page=$pageNumber&per_page=20&query=$userId";
    final response = await http.get(
      Uri.parse(_url),
        headers: header
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
