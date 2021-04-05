import 'package:flutter/material.dart';
import '../other/globals.dart' as global;

class TimeTable extends StatefulWidget {
  @override
  _TimeTable createState() => _TimeTable();
}

class _TimeTable extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children: global.sentral.getListings(context),
      ),
    );
  }
}
