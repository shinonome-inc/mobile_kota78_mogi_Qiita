import 'package:flutter/material.dart';


class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                  [
                    Card(child: ListTile(title: Text("aaa"),subtitle: Text("bbb"),leading: FlutterLogo(),)),
                    Card(child: ListTile(title: Text("aaa"),subtitle: Text("bbb"),leading: FlutterLogo(),)),
                    Card(child: ListTile(title: Text("aaa"),subtitle: Text("bbb"),leading: FlutterLogo(),)),
                  ]
              ),
            ),

            // other sliver widgets
          ],
        )
    );
  }
}
