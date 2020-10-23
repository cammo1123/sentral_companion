import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sentral_companion/pages/account_page.dart';
import 'other/globals.dart' as global;

import 'package:sentral_companion/pages/login_page.dart';
import 'package:sentral_companion/pages/dashboard_page.dart';
import 'package:sentral_companion/pages/timetable_page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'other/sentralapi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  global.sentral = Sentral();

  var status = await Permission.storage.status;
  if (status.isUndetermined) {
    await [
      Permission.storage,
    ].request();
  }

  global.data = await SharedPreferences.getInstance();

  final user = global.data.getString('user') ?? "";
  final pass = global.data.getString('pass') ?? "";

  global.username = TextEditingController(text: user);
  global.password = TextEditingController(text: pass);

  global.loggedIn = await global.sentral.login(user, pass);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final ThemeData darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentral App',
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

BuildContext contextT;

void loginPagePopup() {
  Navigator.push(
    contextT,
    MaterialPageRoute(builder: (contextT) => LoginPage()),
  );
}

void mainPage() {
  Navigator.push(
    contextT,
    MaterialPageRoute(builder: (contextT) => MyHomePage()),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  PersistentTabController _controller;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.dashboard),
        title: ("Dashboard"),
        activeColor: ThemeData.dark().buttonColor,
        inactiveColor: CupertinoColors.inactiveGray,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calendar_view_day),
        title: ("Overview"),
        activeColor: CupertinoColors.activeBlue,
        inactiveColor: CupertinoColors.inactiveGray,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: ("Account"),
        activeColor: ThemeData.dark().buttonColor,
        inactiveColor: CupertinoColors.inactiveGray,
      ),
    ];
  }

  var prevSentral = global.sentral.updated;

  @override
  Widget build(BuildContext context) {
    contextT = context;

    if (global.loggedIn == false) {
      loginPagePopup();
    }
    _controller = PersistentTabController(initialIndex: 1);

    List<Widget> _buildScreens() {
      return [DashBoard(), TimeTable(), Account()];
    }

    return Container(
      decoration:
          new BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Padding(
        padding: MediaQuery.of(context).padding,
        child: PersistentTabView(
          screens: _buildScreens(),
          controller: _controller,
          items: _navBarsItems(),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          decoration: NavBarDecoration(
            colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
          ),
          navBarStyle: NavBarStyle.style6,
        ),
      ),
    );
  }
}
