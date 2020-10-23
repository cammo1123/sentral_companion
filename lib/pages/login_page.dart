import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:sentral_companion/widgets/FormCard.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  double _topPadding;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    _topPadding = (ScreenUtil().screenHeight / 2 - ScreenUtil().setHeight(250));

    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/sentral_dash.png",
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 77.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/sentral.png",
                          width: ScreenUtil().setWidth(110),
                          height: ScreenUtil().setHeight(110),
                        ),
                        Text(
                          "Sentral\nCompanion".toUpperCase(),
                          style: TextStyle(
                            fontFamily: "PoppinsBold",
                            fontSize: ScreenUtil().setSp(46),
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(180),
                    ),
                    FormCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // var usernameController = TextEditingController(text: global.sentral.usernm);
  // var passwordController = TextEditingController(text: global.sentral.passwd);

  // final _formKey = GlobalKey<FormState>();

  // Widget build(BuildContext context) {
  //   var user = global.sentral.userinfo;
  //   return ListView(
  //     children: [
  //       Table(
  //         columnWidths: {
  //           1: FractionColumnWidth(.8),
  //         },
  //         children: [
  //           TableRow(
  //             children: [
  //               Container(
  //                 margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
  //                 padding: const EdgeInsets.all(10),
  //                 child: Column(
  //                   children: [
  //                     if (user.imageUrl != null)
  //                       ClipOval(
  //                         child: Image.file(
  //                           File(user.imageUrl),
  //                           height: 300.0,
  //                           width: 300.0,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     if (user.imageUrl == null)
  //                       CircleAvatar(
  //                         child: Icon(
  //                           Icons.account_circle,
  //                           size: 300,
  //                         ),
  //                         radius: 150,
  //                       ),
  //                     Divider(
  //                       color: Colors.transparent,
  //                     ),
  //                     Text("${user.name}",
  //                         style: Theme.of(context).textTheme.headline4),
  //                     Text(
  //                       "${user.id}",
  //                       style: Theme.of(context).textTheme.headline6,
  //                     ),
  //                     Divider(
  //                       height: 20,
  //                     ),
  //                     Form(
  //                       key: _formKey,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: <Widget>[
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Center(
  //                               child: Text("Credentials",
  //                                   style:
  //                                       Theme.of(context).textTheme.headline5),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: TextField(
  //                               keyboardAppearance: Brightness.dark,
  //                               autocorrect: false,
  //                               enableSuggestions: false,
  //                               keyboardType: TextInputType.name,
  //                               inputFormatters: [
  //                                 new FilteringTextInputFormatter.deny(
  //                                     RegExp("[ ]")),
  //                               ],
  //                               decoration: InputDecoration(
  //                                 labelText: "Username",
  //                                 border: OutlineInputBorder(),
  //                               ),
  //                               controller: usernameController,
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: TextField(
  //                               decoration: InputDecoration(
  //                                 labelText: "Password",
  //                                 border: OutlineInputBorder(),
  //                               ),
  //                               controller: passwordController,
  //                               obscureText: true,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: ConstrainedBox(
  //                         constraints:
  //                             const BoxConstraints(minWidth: double.infinity),
  //                         child: ElevatedButton(
  //                           onPressed: () async {
  //                             final data =
  //                                 await SharedPreferences.getInstance();

  //                             if (await global.sentral.login(
  //                                     usernameController.text,
  //                                     passwordController.text) ==
  //                                 true) {
  //                               setState(() {
  //                                 user = global.sentral.userinfo;
  //                               });
  //                               data.setString('user', usernameController.text);
  //                               data.setString('pass', passwordController.text);
  //                             } else {}
  //                           },
  //                           child: Text('Update'),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
}
