import 'package:flutter/material.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/page/feed_page.dart';
import 'package:qiita_app1/page/tag_page.dart';
import 'package:qiita_app1/page/my_page.dart';
import 'package:qiita_app1/page/setting_page.dart';


class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    TagPage(),
    MyPage(),
    SettingPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt((_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list),label: "フィード"),
          BottomNavigationBarItem(icon: Icon(Icons.label_outline),label: "タグ"),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity_outlined),label: "マイページ"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: "設定"),
      ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: HexColor("#74C13A"),
      ),
    );
  }
}
