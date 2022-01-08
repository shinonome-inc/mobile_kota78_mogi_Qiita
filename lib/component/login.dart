import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/root.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final QiitaClient repository = QiitaClient();

  double _webViewHeight = 1;
  late WebViewController _webViewController;

  String? _urlRedirectionState;
  String? url;
  late final Uri uri;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _urlRedirectionState = _randomString(40);
    print(_urlRedirectionState);
    url = QiitaClient.createdAuthorizeUrl(_urlRedirectionState!);
  }

  Future<void> _onPageFinished(BuildContext context, String url) async {
    double newHeight = double.parse(
      await _webViewController
          .evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(10),
                topLeft: const Radius.circular(10),
              ),
            ),
            child: Align(alignment: Alignment.center,
              child: Text("Article",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Pacifico'
                  )
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(color: HexColor(Constants.white),),
                SingleChildScrollView(
                  child: Container(
                    height: _webViewHeight,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: WebView(
                        initialUrl: url,
                        onPageStarted: (String url) {
                          setState(() {
                            _isLoading = true;
                            print(_urlRedirectionState);
                          });
                        },
                        onPageFinished: (String url) {
                          setState(() async {
                            _isLoading = false;
                            print(url);
                            final uri = Uri.parse(url);
                            if(uri.queryParameters['code'] != null) {
                              _onAuthorizeCallbackIsCalled(uri);
                            }
                            _onPageFinished(context, url);
                          });
                        },
                        onWebViewCreated: (controller) async {
                          _webViewController = controller;
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void _onAuthorizeCallbackIsCalled(Uri uri) async {

    final accessToken = await QiitaClient.createAccessTokenFromCallbackUri(uri, _urlRedirectionState!);
    print('[accessToken]: $accessToken');
    await QiitaClient.saveAccessToken(accessToken);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => Root()),
    );
  }
  //CSRF対策のためクエリに含めるstateの値を生成
  String _randomString(int length) {
    final chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random.secure();
    final codeUnits = List.generate(length, (index) {
      final n = rand.nextInt(chars.length);
      return chars.codeUnitAt(n);
    });
    return String.fromCharCodes(codeUnits);
  }
}