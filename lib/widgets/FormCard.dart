import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:ui';
import 'package:sentral_companion/main.dart';

import '../other/globals.dart' as global;

import 'package:flutter_screenutil/screenutil.dart';

class FormCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(550),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Color(0xff616161)
            : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 15.0),
            blurRadius: 15.0,
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(45),
                fontFamily: "PoppinsBold",
                letterSpacing: .6,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            Text(
              "Username",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                fontFamily: "PoppinsMedium",
                letterSpacing: .6,
              ),
            ),
            TextField(
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.name,
              inputFormatters: [
                new FilteringTextInputFormatter.deny(RegExp("[ ]")),
              ],
              controller: global.username,
              decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            Text(
              "Password",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                fontFamily: "PoppinsMedium",
                letterSpacing: .6,
              ),
            ),
            TextField(
              controller: global.password,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(35),
            ),
            InkWell(
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(85),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF6078ea).withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      bool success = await global.sentral
                          .login(global.username.text, global.password.text);

                      global.data.setString('user', global.username.text);
                      global.data.setString('pass', global.password.text);

                      if (success) {
                        await global.sentral
                            .login(global.username.text, global.password.text);
                        mainPage();
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Login Failed'),
                        );

                        // Find the Scaffold in the widget tree and use
                        // it to show a SnackBar.
                        Scaffold.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Center(
                      child: Text("SIGNIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: 18,
                              letterSpacing: 1.0)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
