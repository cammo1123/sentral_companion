import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/screenutil.dart';
import '../other/globals.dart' as global;

import 'calendar_page.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: StaggeredGridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color.fromARGB(
                          Theme.of(context).brightness == Brightness.light
                              ? 255
                              : 75,
                          255,
                          255,
                          255),
                      boxShadow: [
                        Theme.of(context).brightness == Brightness.light
                            ? BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            : BoxShadow(
                                offset: Offset(0.0, 0.0),
                              ),
                      ],
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            curve: Curves.bounceOut,
                            type: PageTransitionType.scale,
                            alignment: Alignment.center,
                            child: Calender(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today),
                                    Text(" Calendar"),
                                  ],
                                ),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                            Text(
                              "${DateTime.now().day}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(160),
                              ),
                            ),
                            Text(
                              "${DateFormat('EEEE').format(DateTime.now())}",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color.fromARGB(
                          Theme.of(context).brightness == Brightness.light
                              ? 255
                              : 75,
                          255,
                          255,
                          255),
                      boxShadow: [
                        Theme.of(context).brightness == Brightness.light
                            ? BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            : BoxShadow(
                                offset: Offset(0.0, 0.0),
                              ),
                      ],
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (contextT) => Calender()),
                        // );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.data_usage),
                                    Text(" Attendance"),
                                  ],
                                ),
                                Icon(Icons.arrow_right),
                              ],
                            ),
                            Expanded(
                              child: CircularPercentIndicator(
                                radius: ScreenUtil().setHeight(160.0),
                                lineWidth: ScreenUtil().setSp(20),
                                percent:
                                    global.sentral.userinfo.attendance.overall,
                                animateFromLastPercent: true,
                                startAngle: 180,
                                reverse: false,
                                animation: true,
                                circularStrokeCap: CircularStrokeCap.butt,
                                progressColor:
                                    global.sentral.userinfo.attendance.overall <
                                            0.80
                                        ? Colors.red
                                        : global.sentral.userinfo.attendance
                                                    .overall <
                                                0.90
                                            ? Colors.amber
                                            : Colors.green,
                                center: new Text(
                                  "${global.sentral.userinfo.attendance.overall * 100}%",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color.fromARGB(
                          Theme.of(context).brightness == Brightness.light
                              ? 255
                              : 75,
                          255,
                          255,
                          255),
                      boxShadow: [
                        Theme.of(context).brightness == Brightness.light
                            ? BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2.5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            : BoxShadow(
                                offset: Offset(0.0, 0.0),
                              ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.file_present),
                                Text(" Reports"),
                              ],
                            ),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              for (int r = 0; r < 2; r++)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    for (int i = 0; i < 2; i++)
                                      Expanded(
                                        child: Container(
                                          height: ScreenUtil().setHeight(150),
                                          padding: EdgeInsets.all(8.0),
                                          margin: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? 255
                                                    : 125,
                                                255,
                                                255,
                                                255),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: [
                                              Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1.5,
                                                      blurRadius: 5,
                                                      offset: Offset(0, 1.5),
                                                    )
                                                  : BoxShadow(
                                                      offset: Offset(0.0, 0.0),
                                                    ),
                                            ],
                                          ),
                                          child: ListTile(
                                            dense: true,
                                            contentPadding: EdgeInsets.zero,
                                            title: Text("Semester 1"),
                                            subtitle: Text("Year 11"),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              staggeredTiles: const <StaggeredTile>[
                const StaggeredTile.count(1, 1),
                const StaggeredTile.count(1, 1),
                const StaggeredTile.count(2, 1.55),
              ],
            ),
            // child: GridView.count(
            //   padding: EdgeInsets.zero,
            //   crossAxisCount: 2,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.all(8.0),
            //       padding: EdgeInsets.all(16.0),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(25.0),
            //         color: Colors.redAccent,
            //       ),
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               Icon(Icons.calendar_today),
            //               Text(" Calendar"),
            //             ],
            //           ),
            //           Text(
            //             "12",
            //             style: TextStyle(
            //               fontSize: 100,
            //             ),
            //           ),
            //           Text("Monday"),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.all(8.0),
            //       padding: EdgeInsets.all(16.0),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(25.0),
            //         color: Colors.blueAccent,
            //       ),
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               Icon(Icons.data_usage),
            //               Text(" Attendance"),
            //             ],
            //           ),
            //           Expanded(
            //             child: CircularPercentIndicator(
            //               radius: 115.0,
            //               lineWidth: 17.5,
            //               percent: 0.75,
            //               animateFromLastPercent: true,
            //               startAngle: 180,
            //               reverse: false,
            //               animation: true,
            //               circularStrokeCap: CircularStrokeCap.round,
            //               center: new Text(
            //                 "75%",
            //                 style: TextStyle(
            //                   fontSize: 24,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       margin: EdgeInsets.all(8.0),
            //       padding: EdgeInsets.all(16.0),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(25.0),
            //         color: Colors.green[400],
            //       ),
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               Icon(Icons.file_present),
            //               Text(" Reports"),
            //             ],
            //           ),
            //           Expanded(
            //             child: CircularPercentIndicator(
            //               radius: 115.0,
            //               lineWidth: 17.5,
            //               percent: 0.75,
            //               animateFromLastPercent: true,
            //               startAngle: 180,
            //               reverse: false,
            //               animation: true,
            //               circularStrokeCap: CircularStrokeCap.round,
            //               center: new Text(
            //                 "75%",
            //                 style: TextStyle(
            //                   fontSize: 24,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}
