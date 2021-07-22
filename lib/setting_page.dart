import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontFamily: "Pacifico",
            ),
          ),
        ),
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
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    enableDrag: false,
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => privacyModal(),
                  );
                },
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text("プライバシーポリシー"),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.grey,
                indent: 20,
                endIndent: 0,
              ),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => termsModal()
                  );
                },
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text("利用規約"),
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.grey,
                indent: 20,
                endIndent: 0,
              ),
              Container(
                constraints: BoxConstraints.tightForFinite(height: 50),
                decoration: BoxDecoration(color: Colors.white),
                child:Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                      child: Text("アプリバージョン"),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      child: Text("v1.0.0", style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
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
              InkWell(
                onTap: () {print("LogOut is tapped");},
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text("ログアウトする"),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
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

  Widget privacyModal() => Container(
    height: 600,
    child: Column(
      children: <Widget>[
        Expanded(
          flex:1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(20),
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Align(alignment: Alignment.center,
                child: Text("プライバシーポリシー",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          ),
        ),
        Expanded(
          flex:10,
          child: Container(
            child:WebView(
              initialUrl: 'https://qiita.com/privacy',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ],
    ),
  );

  Widget termsModal() => Container(
    height: 600,
    child: Column(
      children: <Widget>[
        Expanded(
          flex:1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topRight: const Radius.circular(20),
                topLeft: const Radius.circular(20),
              ),
            ),
            child: Align(alignment: Alignment.center,
                child: Text("利用規約",
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
          ),
        ),
        Expanded(
          flex:10,
          child: Container(
            child:WebView(
              initialUrl: 'https://qiita.com/terms',
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
        ),
      ],
    ),
  );

}


