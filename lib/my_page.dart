import 'package:flutter/material.dart';


class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
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
