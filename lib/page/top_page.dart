import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/client/qiita_client.dart';
import 'package:qiita_app1/root.dart';
import 'package:qiita_app1/page/error_page.dart';

class TopPage extends StatefulWidget {
  TopPage(
      {Key? key}
      ) : super(key: key);



  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/top_page_back.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.2),),
              ),
              Column(children: [
                Expanded(flex: 4, child: (Container())),
                Text(
                  "Qiita Feed App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico",
                  ),
                ),
                Text("-PlayGround-", style: TextStyle(color: Colors.white),),
                Expanded(flex:5, child: (Container())),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Material(
                    color: Colors.green[800],
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap:() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Root()),
                        );
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'ログイン',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    print('Tapped Privacy Policy');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ErrorPage(QiitaClient.fetchArticle(""))),
                    );
                  },
                  child: Text(
                    "ログインせずに利用する",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Expanded(child: Container(),),
              ],
              ),]
        )
    );
  }
}