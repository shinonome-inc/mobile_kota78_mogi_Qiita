import 'package:flutter/material.dart';


class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text("Feed",style: TextStyle(color: Colors.black,fontSize: 15.0),),
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
