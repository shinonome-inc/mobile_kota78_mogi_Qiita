import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "MyPage",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        body: Center(
          child: WebView(
            initialUrl: 'https://qiita.com/ko_cha78',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}