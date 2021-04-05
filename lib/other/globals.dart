library sentralcompanion.globals;

import 'package:flutter/material.dart';
import 'package:sentral_companion/other/sentral_classes/classes.dart';
import 'package:sentral_companion/other/sentralapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

Sentral sentral;
TextEditingController username;
SharedPreferences data;
bool loggedIn;
TextEditingController password;
Session site;
BuildContext context;
String version = "v0.0.1-alpha";
