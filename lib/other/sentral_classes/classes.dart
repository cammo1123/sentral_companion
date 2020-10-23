import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sentral_companion/other/globals.dart' as global;

import 'package:path_provider/path_provider.dart';

var materialColors = <Color>[
  Color.fromARGB(255, 251, 233, 195),
  Color.fromARGB(255, 255, 191, 127),
  Color.fromARGB(255, 126, 250, 250),
  Color.fromARGB(255, 249, 126, 126),
  Color.fromARGB(255, 223, 192, 254),
  Color.fromARGB(255, 252, 235, 127),
  Color.fromARGB(255, 118, 231, 127),
  Color.fromARGB(255, 191, 159, 159),
  Color.fromARGB(255, 213, 56, 53),
  Color.fromARGB(255, 229, 124, 115),
  Color.fromARGB(255, 243, 85, 62),
  Color.fromARGB(255, 246, 191, 59),
  Color.fromARGB(255, 66, 182, 122),
  Color.fromARGB(255, 47, 128, 68),
  Color.fromARGB(255, 4, 156, 229),
  Color.fromARGB(255, 64, 89, 181),
  Color.fromARGB(255, 121, 134, 203),
  Color.fromARGB(255, 146, 88, 170),
  Color.fromARGB(255, 98, 97, 97),
];

class Event {
  DateTime start;
  DateTime end;
  String uid;
  List<String> description;
  String summary;
  String room;
  Color color;

  Event(
      [this.start,
      this.end,
      this.summary,
      this.uid,
      this.description,
      this.room,
      this.color]);
}

//? Create Image From String
Future<String> createImageFromString(
    String photo, String id, String url) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  String fullPath = '$dir/$id.png';

  var t = await global.site.get(url + photo.replaceAll("/portal", ""));
  File file = File(fullPath);

  await file.writeAsBytes(t.bodyBytes);
  return file.path;
}

//? Create File From String
Future<String> fetchTimeTable(String baseUrl) async {
  String baseDir = (await getApplicationDocumentsDirectory()).path;
  String timeTableDir = "$baseDir/${global.sentral.userinfo.id}.ical";
  File file = File(timeTableDir);

  if (await file.exists()) {
    print("Getting TimeTable from Cache");
    return await file.readAsString();
  } else {
    print("Getting TimeTable from Portal");
    var request = await global.site
        .get(baseUrl.replaceAll("portal", "portal/timetable/export"));
    await file.writeAsString(request.body);
    return await file.readAsString();
  }
}

//? Subclass of UserInfo
class Attendance {
  double overall;
  double term1;
  double term2;
  double term3;
  double term4;

  Attendance([this.overall, this.term1, this.term2, this.term3, this.term4]);
}

extension GlobalKeyExtension on GlobalKey {
  Rect get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null)?.getTranslation();
    if (translation != null && renderObject.paintBounds != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

//? Stores user Information

class UserInfo {
  String name;
  String id;
  String imageUrl;
  Attendance attendance;

  UserInfo([this.name, this.id, this.imageUrl, this.attendance]);
}

//? Defines Timetable

class PeriodData {
  Duration start;
  Duration end;
  String period;

  PeriodData(this.start, this.end, this.period);
}

//? Stores Information About a Period

class Period {
  String room;
  String teacher;
  String subject;
  String period;
  String subjectString;
  String periodString;
  bool now;

  Period(
      [this.room,
      this.teacher,
      this.subject,
      this.now,
      this.period,
      this.subjectString,
      this.periodString]);
}

//? Request Handler With Cookies

class Session {
  Map<String, String> headers = {};

  Future<http.Response> get(String url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return response;
  }

  Future<http.Response> post(String url, Map<String, dynamic> data) async {
    http.Response response = await http.post(url, body: data, headers: headers);

    updateCookie(response);

    return response;
  }

  void clearCookies() {
    headers = {};
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}

//? Convert from .ical time format to DateTime format

DateTime calDateTime(s) {
  return DateTime.utc(
    int.parse(s.substring(0, 4)),
    int.parse(s.substring(4, 6)),
    int.parse(s.substring(6, 8)),
    int.parse(s.substring(9, 11)),
    int.parse(s.substring(11, 13)),
    int.parse(s.substring(13, 15)),
  );
}
