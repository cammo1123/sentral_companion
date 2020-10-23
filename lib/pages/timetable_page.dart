import 'package:flutter/material.dart';
import '../other/globals.dart' as global;
import 'package:intl/intl.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTable createState() => _TimeTable();
}

class _TimeTable extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    var today = global.sentral.today;

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMMd');
    final String formatted = formatter.format(now);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        children:
            //   Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Text(
            //       formatted,
            //       style: Theme.of(context).textTheme.headline6,
            //     ),
            //   ),
            //   Divider(
            //     height: 1,
            //   ),
            global.sentral.getListings(context),
      ),
    );
  }
}
