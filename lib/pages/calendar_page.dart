import 'package:flutter/material.dart';
import 'package:sentral_companion/other/sentral_classes/classes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../other/globals.dart' as global;

class Calender extends StatefulWidget {
  @override
  _Calender createState() => _Calender();
}

class _Calender extends State<Calender> {
  List<Event> meetings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        onViewChanged: (ViewChangedDetails details) {},
        view: CalendarView.workWeek,
        appointmentTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
        timeSlotViewSettings: TimeSlotViewSettings(
          timeIntervalHeight: -1,
          startHour: 8,
          endHour: 16,
          timeRulerSize: 0,
          dayFormat: 'EEE',
        ),
        dataSource: MeetingDataSource(
          _getDataSource(),
        ),
      ),
    );
  }

  List<Event> _getDataSource() {
    meetings = List<Event>();
    for (Event event in global.sentral.events) {
      meetings.add(
          Event(event.start.toLocal(), event.end.toLocal(), event.summary));
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].end;
  }

  @override
  String getSubject(int index) {
    return appointments[index].summary;
  }

  @override
  Color getColor(int index) {
    return global
        .sentral.subjectColors[appointments[index].summary.toLowerCase()];
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
