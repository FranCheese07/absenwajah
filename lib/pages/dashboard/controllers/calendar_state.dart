import 'package:a_check/models/class.dart';
import 'package:a_check/pages/dashboard/calendar_page.dart';
import 'package:a_check/utils/localdb.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class CalendarState extends State<CalendarPage> {
  late final EventController calendarController;

  /// The [weekday] may be 0 for Sunday, 1 for Monday, etc. up to 7 for Sunday.
  DateTime mostRecentWeekday(DateTime date, int weekday) =>
      DateTime(date.year, date.month, date.day - (date.weekday - weekday) % 7);

  void setSchedule() {
    for (Class c in HiveBoxes.classesBox().values.cast<Class>()) {
      for (ClassSchedule s in c.schedule) {
        final date = mostRecentWeekday(DateTime.now(), s.day.index);
        final startTime =
            date.copyWith(hour: s.startTimeHour, minute: s.startTimeMinute);
        final endTime =
            date.copyWith(hour: s.endTimeHour, minute: s.endTimeMinute);
        final event = CalendarEventData(
            title: c.code,
            description: "${c.name} ${c.section}",
            date: date,
            startTime: startTime,
            endTime: endTime);
        calendarController.add(event);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    calendarController = EventController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setSchedule();
  }

  @override
  Widget build(BuildContext context) => CalendarView(this);
}
