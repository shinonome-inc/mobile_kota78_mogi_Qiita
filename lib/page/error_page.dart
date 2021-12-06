import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/constants.dart';

class ErrorPage extends StatefulWidget {
  final VoidCallback refreshFunction;
  ErrorPage({required this.refreshFunction});

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {


  Widget buttonView(String text, color, textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      child: Material(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => widget.refreshFunction,
          child: Container(
            height: 50,
            child: Center(
              child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          backgroundColor: HexColor(Constants.white),
          shape: Border(bottom: BorderSide(color: HexColor(Constants.grey), width: 0.3)),
        ),*/
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: HexColor(Constants.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.public_off_outlined,
                          color: HexColor("#74C13A"),
                          size: 80,
                        ),
                        SizedBox(height: 36,),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "ネットワークエラー",
                                style: TextStyle(
                                  color: HexColor(Constants.black),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text(
                                "お手数ですが電波の良い場所で\n再度読み込みをお願いします",
                                style: TextStyle(
                                  color: HexColor(Constants.darkGrey),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                buttonView("再読み込みする", HexColor("#74C13A"), HexColor("#F9FCFF"))
              ],
            ),
          ],
        )
    );
  }
}
