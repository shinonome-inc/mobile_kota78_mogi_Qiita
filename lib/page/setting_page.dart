import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/page/top_page.dart';
import 'package:qiita_app1/component/privacy_policy_page.dart';
import 'package:qiita_app1/component/term_of_service_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _accessTokenIsSaved = false;
  @override
  void initState() {
    super.initState();
    substituteBool();
  }

  void substituteBool() async {
    _accessTokenIsSaved = await QiitaClient.accessTokenIsSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
          automaticallyImplyLeading: false,
          shape: Border(bottom: BorderSide(color: HexColor(Constants.grey), width: 0.3)),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.05),),),
            Column(children :<Widget>[
              Container(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("アプリ情報",style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                    enableDrag: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => PrivacyModal(),
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
                        child: Icon(Icons.arrow_forward_ios_rounded, color: HexColor(Constants.black),),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 20,
                endIndent: 0,
              ),
              InkWell(
                onTap: (){
                  showModalBottomSheet(
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => TermsModal()
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
                        child: Icon(Icons.arrow_forward_ios_rounded, color: HexColor(Constants.black),),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
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
                      child: Text("アプリバージョン", style: TextStyle(color: HexColor(Constants.black),),),
                    ),
                    Expanded(child: Container()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                      child: Text("v1.0.0", style: TextStyle(color: HexColor(Constants.black), fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
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
                onTap: () async {
                  print("LogOut is tapped");
                  showLogoutDialog(context);
                  },
                child: Container(
                  constraints: BoxConstraints.tightForFinite(height: 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child:Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Text(_accessTokenIsSaved ? "ログアウトする" : "ログインする"),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 0.5,
                color: HexColor(Constants.separatingLineColor),
                indent: 20,
                endIndent: 0,
              ),
            ])
          ],
        )
    );
  }

  void showLogoutDialog(BuildContext context) {
    if (_accessTokenIsSaved) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("ログアウトしますか？"),
            actions: [
              TextButton(
                child: Text("キャンセル"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                  child: Text("OK"),
                  onPressed: () async {
                    await QiitaClient.deleteAccessToken();
                    Navigator.of(context).pushReplacementNamed("/");
                  }
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("ログインしますか？"),
            actions: [
              TextButton(
                child: Text("キャンセル"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => TopPage()));
                  }
              ),
            ],
          );
        },
      );
    }
  }
}