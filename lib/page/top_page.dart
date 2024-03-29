import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/page/error_page.dart';
import 'package:qiita_app1/component/login.dart';

class TopPage extends StatefulWidget {
  TopPage(
      {Key? key}
      ) : super(key: key);


  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage> {
  var isShowErrorView = false;
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
                        showModalBottomSheet(
                            enableDrag: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Login();
                            }
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
                    print('Without LogIn is tapped');
                    Navigator.of(context).pushReplacementNamed("/root");
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
              ),
              isShowErrorView
                  ? Positioned.fill(
                  child: ErrorPage(
                    refreshFunction: () {
                      print('refreshFunction');
                      setState(() {
                        isShowErrorView = false;
                      });
                      },
                  )
              )
                  : Container()
            ]
        )
    );
  }
}
