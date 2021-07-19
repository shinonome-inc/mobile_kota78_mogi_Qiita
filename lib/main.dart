import 'package:flutter/material.dart';
import 'package:qiita_app1/top_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TopPage(),
    );
  }
}
