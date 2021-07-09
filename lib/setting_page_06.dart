import 'package:flutter/material.dart';


class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.05),),),
            Column(children :<Widget>[
              Container(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("アプリ情報",style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
              ),
              Container(height:50.0,decoration: BoxDecoration(color: Colors.white),),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.grey,
                indent: 20,
                endIndent: 0,
              ),
              Container(height:50.0,decoration: BoxDecoration(color: Colors.white,),),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.grey,
                indent: 20,
                endIndent: 0,
              ),
              Container(height:50.0,decoration: BoxDecoration(color: Colors.white,),),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.grey,
                indent: 20,
                endIndent: 0,
              ),
              Container(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("その他",style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
              ),
              Container(height:50.0,decoration: BoxDecoration(color: Colors.white,),),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.grey,
                indent: 20,
                endIndent: 0,
              ),
            ])
          ],
        )
    );
  }
}
