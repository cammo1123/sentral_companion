import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../other/globals.dart' as global;

import 'package:sentral_companion/other/sentral_classes/classes.dart';
import 'package:xpath_parse/xpath_selector.dart';

String regexFindFirst(String expression, String string) {
  var i = RegExp(expression).firstMatch(string);

  if (i != null) {
    return string.substring(i.start, i.end);
  } else {
    return "";
  }
}

class Sentral {
  String url = "https://web2.pittwater-h.schools.nsw.edu.au/portal";
  http.Response resDash;
  Map<String, Period> today = new Map<String, Period>();
  List<Event> events = [];
  Map<String, Color> subjectColors = {};
  UserInfo userinfo = new UserInfo();
  bool updated = false;

  //TODO Properly Define Wednesday
  Map<int, List<PeriodData>> periods = {
    //? Monday
    1: <PeriodData>[
      //Period 0
      PeriodData(Duration(hours: 7, minutes: 45),
          Duration(hours: 8, minutes: 45), "0"),
      //Period BS
      PeriodData(Duration(hours: 8, minutes: 50),
          Duration(hours: 8, minutes: 55), "BS"),
      //Period 1
      PeriodData(Duration(hours: 8, minutes: 55),
          Duration(hours: 9, minutes: 55), "1"),
      //Period RC
      PeriodData(Duration(hours: 9, minutes: 55),
          Duration(hours: 10, minutes: 10), "RC"),
      //Period 2
      PeriodData(Duration(hours: 10, minutes: 10),
          Duration(hours: 11, minutes: 10), "2"),
      //Period L1
      PeriodData(Duration(hours: 11, minutes: 10),
          Duration(hours: 11, minutes: 40), "L1"),
      //Period 3
      PeriodData(Duration(hours: 11, minutes: 40),
          Duration(hours: 12, minutes: 40), "3"),
      //Period 4
      PeriodData(Duration(hours: 12, minutes: 45),
          Duration(hours: 13, minutes: 45), "4"),
      //Period L2
      PeriodData(Duration(hours: 13, minutes: 45),
          Duration(hours: 14, minutes: 20), "L2"),
      //Period 5
      PeriodData(Duration(hours: 14, minutes: 20),
          Duration(hours: 15, minutes: 20), "5"),
    ],
    //? Tuesday
    2: <PeriodData>[
      //Period 0
      PeriodData(Duration(hours: 7, minutes: 45),
          Duration(hours: 8, minutes: 45), "0"),
      //Period BS
      PeriodData(Duration(hours: 8, minutes: 50),
          Duration(hours: 8, minutes: 55), "BS"),
      //Period 1
      PeriodData(Duration(hours: 8, minutes: 55),
          Duration(hours: 9, minutes: 47), "1"),
      //Period RC
      PeriodData(Duration(hours: 9, minutes: 47),
          Duration(hours: 10, minutes: 2), "RC"),
      //Period 2
      PeriodData(Duration(hours: 10, minutes: 2),
          Duration(hours: 10, minutes: 54), "2"),
      //Period L1
      PeriodData(Duration(hours: 10, minutes: 54),
          Duration(hours: 11, minutes: 22), "L1"),
      //Period 3
      PeriodData(Duration(hours: 11, minutes: 24),
          Duration(hours: 12, minutes: 16), "3"),
      //Period 4
      PeriodData(Duration(hours: 12, minutes: 16),
          Duration(hours: 13, minutes: 13), "4"),
      //Period L2
      PeriodData(Duration(hours: 13, minutes: 10),
          Duration(hours: 13, minutes: 43), "L2"),
      //Period 5
      PeriodData(Duration(hours: 13, minutes: 48),
          Duration(hours: 14, minutes: 40), "5"),
    ],
    //? Wednesday
    3: <PeriodData>[
      //Period 0
      PeriodData(Duration(hours: 7, minutes: 45),
          Duration(hours: 8, minutes: 45), "0"),
      //Period BS
      PeriodData(Duration(hours: 8, minutes: 50),
          Duration(hours: 8, minutes: 55), "BS"),
      //Period 1
      PeriodData(Duration(hours: 8, minutes: 55),
          Duration(hours: 9, minutes: 55), "1"),
      //Period RC
      PeriodData(Duration(hours: 9, minutes: 55),
          Duration(hours: 10, minutes: 10), "RC"),
      //Period 2
      PeriodData(Duration(hours: 10, minutes: 10),
          Duration(hours: 11, minutes: 10), "2"),
      //Period L1
      PeriodData(Duration(hours: 11, minutes: 10),
          Duration(hours: 11, minutes: 40), "L1"),
      //Period 3
      PeriodData(Duration(hours: 11, minutes: 40),
          Duration(hours: 12, minutes: 40), "3"),
      //Period L2
      PeriodData(Duration(hours: 12, minutes: 40),
          Duration(hours: 1, minutes: 15), "L2"),
      //Period 4
      PeriodData(Duration(hours: 1, minutes: 15),
          Duration(hours: 2, minutes: 15), "4"),
      //Period 5
      PeriodData(Duration(hours: 2, minutes: 20),
          Duration(hours: 3, minutes: 20), "5"),
    ],
    //? Thursday
    4: <PeriodData>[
      //Period 0
      PeriodData(Duration(hours: 7, minutes: 45),
          Duration(hours: 8, minutes: 45), "0"),
      //Period BS
      PeriodData(Duration(hours: 8, minutes: 50),
          Duration(hours: 8, minutes: 55), "BS"),
      //Period 1
      PeriodData(Duration(hours: 8, minutes: 55),
          Duration(hours: 9, minutes: 55), "1"),
      //Period RC
      PeriodData(Duration(hours: 9, minutes: 55),
          Duration(hours: 10, minutes: 10), "RC"),
      //Period 2
      PeriodData(Duration(hours: 10, minutes: 10),
          Duration(hours: 11, minutes: 10), "2"),
      //Period L1
      PeriodData(Duration(hours: 11, minutes: 10),
          Duration(hours: 11, minutes: 40), "L1"),
      //Period 3
      PeriodData(Duration(hours: 11, minutes: 40),
          Duration(hours: 12, minutes: 40), "3"),
      //Period 4
      PeriodData(Duration(hours: 12, minutes: 45),
          Duration(hours: 13, minutes: 45), "4"),
      //Period L2
      PeriodData(Duration(hours: 13, minutes: 45),
          Duration(hours: 14, minutes: 20), "L2"),
      //Period 5
      PeriodData(Duration(hours: 14, minutes: 20),
          Duration(hours: 15, minutes: 20), "5"),
    ],
    //? Friday
    5: <PeriodData>[
      //Period 0
      PeriodData(Duration(hours: 7, minutes: 45),
          Duration(hours: 8, minutes: 45), "0"),
      //Period BS
      PeriodData(Duration(hours: 8, minutes: 50),
          Duration(hours: 8, minutes: 55), "BS"),
      //Period 1
      PeriodData(Duration(hours: 8, minutes: 55),
          Duration(hours: 9, minutes: 55), "1"),
      //Period RC
      PeriodData(Duration(hours: 9, minutes: 55),
          Duration(hours: 10, minutes: 10), "RC"),
      //Period 2
      PeriodData(Duration(hours: 10, minutes: 10),
          Duration(hours: 11, minutes: 10), "2"),
      //Period L1
      PeriodData(Duration(hours: 11, minutes: 10),
          Duration(hours: 11, minutes: 40), "L1"),
      //Period 3
      PeriodData(Duration(hours: 11, minutes: 40),
          Duration(hours: 12, minutes: 40), "3"),
      //Period 4
      PeriodData(Duration(hours: 12, minutes: 45),
          Duration(hours: 13, minutes: 45), "4"),
      //Period L2
      PeriodData(Duration(hours: 13, minutes: 45),
          Duration(hours: 14, minutes: 20), "L2"),
      //Period 5
      PeriodData(Duration(hours: 14, minutes: 20),
          Duration(hours: 15, minutes: 20), "5"),
    ],
  };

  //? Login to site
  Future<bool> login(String username, String password) async {
    global.site = Session();

    updated = !updated;

    var map = new Map<String, dynamic>();

    map['action'] = 'login';

    map['username'] = username;

    map['password'] = password;

    var res = await global.site.post("$url/login/login", map);

    if (res.headers['set-cookie'].contains("PortalLoggedIn=1")) {
      res = await global.site.get("$url/attendance/overview");
      resDash = res;
      await this.getCalender();
      await this.getUserInfo();

      return true;
    } else {
      print("Login Failed");
      return false;
    }
  }

  Future<void> getCalender() async {
    events = new List<Event>();

    var subjects = <String>[];

    String timetable = await fetchTimeTable(url);

    var table = timetable.split("BEGIN:VEVENT");

    for (var e in table) {
      var event = e.split("\n");
      if (event.length == 10) {
        Event tempEvent = new Event();

        var start = (event[1].replaceAll(RegExp(r"[A-Z].*:"), ""));
        var end = (event[3].replaceAll(RegExp(r"[A-Z].*:"), ""));
        var uid = (event[4].replaceAll(RegExp(r"[A-Z].*:"), ""));
        var description =
            (event[5].replaceAll(RegExp(r"[A-Z].*:.*[A-Z]:"), "")).split("\\n");

        var summary = (event[6].replaceAll(RegExp(r".*: "), ""));
        summary = summary.substring(0, summary.length - 1);
        var room = (event[7].replaceAll(RegExp(r"[A-Z].*[A-Z]:[A-Z].*: "), ""));

        tempEvent.start = calDateTime(start);
        tempEvent.end = calDateTime(end);
        tempEvent.uid = uid;
        tempEvent.description = description;
        tempEvent.summary = summary;
        tempEvent.room = room;

        if (!subjects.contains(summary.toLowerCase())) {
          subjects.add(summary.toLowerCase());
        }

        events.add(tempEvent);
      }
    }

    subjects.sort();

    for (String subject in subjects) {
      subjectColors[subject] = materialColors[subjects.indexOf(subject)];
    }

    return;
  }

  Future<void> getUserInfo() async {
    userinfo = new UserInfo();

    var res = resDash;

    var body = res.body;

    var xpath = XPath.source(body);

    var n = xpath.query("//div[2]/div/p/span[1]()").get();
    var name = n.replaceAll("<span>", "").replaceAll("</span>", "");

    var i = xpath.query("//div[2]/div/p/small[1]()").get();
    var id = i.replaceAll("<small>", "").replaceAll("</small>", "");

    var p = xpath.query("//div[2]/div/p/img[1]()").get();
    var photo =
        p.replaceAll(RegExp(r'<img src="'), "").replaceAll(RegExp('".*'), "");

    var chache = [];
    for (var word in name.split(" ")) {
      chache.add("${word[0].toUpperCase()}${word.substring(1).toLowerCase()}");
    }
    body = (await global.site.get(
            "https://web2.pittwater-h.schools.nsw.edu.au/portal/attendance/overview"))
        .body;

    xpath = XPath.source(body);
    var one = xpath.query("//div/div[6]/p[1]/span[1]").get();
    var term1 = double.parse(
        one.replaceAll(RegExp('<span.*">'), "").replaceAll("%</span>", ""));

    var two = xpath.query("//div/div[6]/p[2]/span[1]").get();
    var term2 = double.parse(
        two.replaceAll(RegExp('<span.*">'), "").replaceAll("%</span>", ""));

    var three = xpath.query("//div/div[6]/p[3]/span[1]").get();
    var term3 = double.parse(
        three.replaceAll(RegExp('<span.*">'), "").replaceAll("%</span>", ""));

    var four = xpath.query("//div/div[6]/p[4]/span[1]").get();
    var term4 = double.parse(
        four.replaceAll(RegExp('<span.*">'), "").replaceAll("%</span>", ""));

    var o = xpath.query("//div/div[6]/p[5]/span[1]").get();
    var overall = double.parse(
        o.replaceAll(RegExp('<span.*">'), "").replaceAll("%</span>", ""));

    userinfo.attendance = new Attendance();
    userinfo.attendance.term1 = term1 / 100;
    userinfo.attendance.term2 = term2 / 100;
    userinfo.attendance.term3 = term3 / 100;
    userinfo.attendance.term4 = term4 / 100;
    userinfo.attendance.overall =
        double.parse((overall / 100).toStringAsFixed(3));

    userinfo.name = chache.join(" ");
    userinfo.id = id;
    userinfo.imageUrl = await createImageFromString(photo, id, url);
  }

  void newGetTodayCal() async {
    today = new Map<String, Period>();
    List<Event> todayEvents = [];

    var now = DateTime.now();
    var localNow = now.toLocal();
    var timeOffset = now.timeZoneOffset;
    var curtoday = DateTime.utc(localNow.year, localNow.month, localNow.day);
    var tomorrow = curtoday.add(Duration(days: 1));
    curtoday = curtoday.toLocal().subtract(timeOffset);
    tomorrow = tomorrow.toLocal().subtract(timeOffset);

    //? GET TODAYS EVENTS

    for (Event event in events) {
      var start = event.start.toLocal();

      if (curtoday.isBefore(start) && tomorrow.isAfter(start)) {
        todayEvents.add(event);
      }
    }

    //? GET PERIODS

    var i = 0;

    for (Event event in todayEvents) {
      for (var period in periods[now.weekday]) {
        bool startSame = (event.start
            .toLocal()
            .isAtSameMomentAs(curtoday.add(period.start)));
        bool endSame =
            (event.end.toLocal().isAtSameMomentAs(curtoday.add(period.end)));

        if (startSame && endSame) {
          //* Define Actual Periods
          var properPeriod = Period();

          var curperiod = period.period;

          properPeriod.period = curperiod;
          properPeriod.room = event.room;
          properPeriod.subject = event.summary;
          properPeriod.periodString = curperiod.contains(RegExp("[A-Z][0-9]"))
              ? curperiod
              : "\n$curperiod\n";
          properPeriod.subjectString = curperiod.contains(RegExp("[A-Z][0-9]"))
              ? ""
              : "${event.summary}\n\n${event.room}";

          //* Define Breaks

          var temp = periods[now.weekday]
                  [periods[now.weekday].indexOf(period) - 1]
              .period;
          if (temp.contains(RegExp("[A-Z][0-9]"))) {
            var fakePeriod = new Period();
            curperiod = temp;
            fakePeriod.period = curperiod;
            fakePeriod.room = "";
            fakePeriod.subject = "";
            fakePeriod.periodString = "$curperiod";
            fakePeriod.subjectString = "";

            today[temp] = fakePeriod;
          }

          //! Due to nature of above script we have to add ProperPeriod after FakePeriod

          today[properPeriod.period] = properPeriod;
        }
      }
      i = i + 1;
    }
  }

  List<Widget> getListings(BuildContext context) {
    this.newGetTodayCal();
    List listings = List<Widget>();
    for (var i in today.entries) {
      listings.add(
        Table(
          columnWidths: {
            1: FractionColumnWidth(.8),
          },
          children: [
            TableRow(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    i.value.periodString,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: const EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: i.value.now == true
                        ? Theme.of(context).indicatorColor.withAlpha(100)
                        : i.value.subject.contains(new RegExp(r"[A-Z]")) == true
                            ? Theme.of(context).cardColor
                            : Colors.grey.withAlpha(120),
                    borderRadius: new BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 2.5,
                      color: !i.value.period.contains(RegExp(r"[A-Z][0-9]"))
                          ? global.sentral
                              .subjectColors[i.value.subject.toLowerCase()]
                          : Colors.grey.withAlpha(120),
                    ),
                  ),
                  child: Text(i.value.subjectString),
                )
              ],
            ),
          ],
        ),
      );
    }
    return listings;
  }
}
