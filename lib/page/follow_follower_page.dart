import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiita_app1/component/follow_page.dart';
import 'package:qiita_app1/component/follower_page.dart';
import 'package:qiita_app1/constants.dart';
import 'package:qiita_app1/hex_color.dart';

class FollowFollowerPage extends StatefulWidget {
  final bool isFollowerTapped;
  final String userId, userName;
  FollowFollowerPage(this.isFollowerTapped, this.userId, this.userName);

  @override
  _FollowFollowerPageState createState() => _FollowFollowerPageState();
}

class _FollowFollowerPageState extends State<FollowFollowerPage> {

  bool? switchValue;
  void initState() {
    super.initState();
      switchValue =  widget.isFollowerTapped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: HexColor("#468300"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.userName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: "Pacifico",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoSlidingSegmentedControl<bool>(
                    groupValue: switchValue,
                    children: {
                        true: Text(
                          "フォロワー",
                          style: TextStyle(
                            fontWeight: switchValue == true ? FontWeight.w600 : FontWeight.w500,
                            color: HexColor(Constants.darkBlack),
                          ),
                        ),
                        false: Text(
                          "フォロー中",
                          style: TextStyle(
                            fontWeight: switchValue == false ? FontWeight.w600 : FontWeight.w500,
                            color: HexColor(Constants.darkBlack),
                          ),
                        ),
                      },
                      onValueChanged: (switchValue) {
                        print(switchValue);
                        setState(() {
                          this.switchValue = switchValue;
                          switchValue = widget.isFollowerTapped;
                        });
                      },
                  ),
                ),
              ],
            ),
          ),
          (() {
            if (switchValue == true) {
              return FollowPage(widget.userId);
            } else {
              return FollowerPage(widget.userId);
            }
          })(),

        ],
      ),
    );
  }
}
