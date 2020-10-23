import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sentral_companion/main.dart';
import 'package:sentral_companion/other/sentral_classes/classes.dart';
import '../other/globals.dart' as global;
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Account extends StatelessWidget {
  UserInfo user = global.sentral.userinfo;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Column(
      children: [
        Container(
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (user.imageUrl != null)
                    ClipOval(
                      child: Image.file(
                        File(user.imageUrl),
                        height: 150,
                        width: 150,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  if (user.imageUrl == null)
                    CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                        size: 150,
                      ),
                      radius: 75,
                    ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 70,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name ?? "",
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            user.id ?? "",
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //   ),
                  //   Flexible(
                  //     fit: FlexFit.tight,
                  //     flex: 10,
                  //     child: Icon(Icons.arrow_right),
                  //   ),
                ],
              ),
            ),
          ),
        ),
        Divider(),
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(100, 4, 156, 229),
                  child: Icon(
                    Icons.account_circle_sharp,
                    color: Color.fromARGB(255, 4, 156, 229),
                  ),
                ),
                title: Text("Account"),
                onTap: () {
                  loginPagePopup();
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(100, 187, 134, 252),
                  child: Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 187, 134, 252),
                  ),
                ),
                title: Text("Settings"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
