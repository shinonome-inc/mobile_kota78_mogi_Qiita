import 'package:flutter/material.dart';
import 'package:qiita_app1/model/user.dart';
import 'package:qiita_app1/hex_color.dart';
import 'package:qiita_app1/constants.dart';

class UserListView extends StatelessWidget {
  final List<User> users;
  UserListView({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        final user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: HexColor(Constants.separatingLineColor)
                  ),
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16.0,
                            backgroundImage: NetworkImage(user.iconUrl!),
                          ),
                          SizedBox(width: 8.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.userName == "" ? "NoName" : user.userName!,
                                style: TextStyle(
                                  color: HexColor(Constants.black),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                "@${user.id ?? ""}",
                                style: TextStyle(
                                  color: HexColor(Constants.darkGrey),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                      child: Text(
                        "Posts: ${user.itemsCount}, follower: ${user.followersCount}",
                        style: TextStyle(
                            color: HexColor(Constants.black),
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        user.description ?? "",
                        style: TextStyle(
                            color: HexColor(Constants.darkGrey),
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
