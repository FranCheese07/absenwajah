import 'package:a_check/models/student.dart';
import 'package:a_check/utils/localdb.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'class.g.dart';

@HiveType(typeId: 1)
enum DaysOfTheWeek {
  @HiveField(0)
  monday,
  @HiveField(1)
  tuesday,
  @HiveField(2)
  wednesday,
  @HiveField(3)
  thursday,
  @HiveField(4)
  friday,
  @HiveField(5)
  saturday,
  @HiveField(6)
  sunday;

  @override
  String toString() {
    switch (this) {
      case monday:
        return "Monday";
      case tuesday:
        return "Tuesday";
      case wednesday:
        return "Wednesday";
      case thursday:
        return "Thursday";
      case friday:
        return "Friday";
      case saturday:
        return "Saturday";
      case sunday:
        return "Sunday";
      default:
        return "";
    }
  }
}

@HiveType(typeId: 0)
class Class extends HiveObject {
  @HiveField(0)
  String code;

  @HiveField(1)
  String name;

  @HiveField(2)
  String section;

  @HiveField(3)
  List<ClassSchedule> schedule;

  @HiveField(4)
  Set<String> students = {};

  Class(
      {required this.code,
      required this.name,
      required this.section,
      required this.schedule,
      List<String>? students}) {
    if (students != null) {
      this.students = students.toSet();
    }
  }

  @override
  String toString() {
    String classInfo = "$code: $name [$section]\n";
    var classSchedBuf = StringBuffer();
    for (var s in schedule) {
      classSchedBuf.write(
          "${s.day} ${s.startTimeHour.toString().padLeft(2, '0')}:${s.startTimeMinute.toString().padLeft(2, '0')} - ${s.endTimeHour.toString().padLeft(2, '0')}:${s.endTimeMinute.toString().padLeft(2, '0')}\n");
    }

    return classInfo + classSchedBuf.toString();
  }

  List<Student> getStudents() {
    final studentsList = students.map((id) {
      final castedBox = HiveBoxes.studentsBox().values.cast();
      return castedBox.firstWhere((student) => student.id == id) as Student;
    }).toList();
    studentsList.sort(
      (a, b) =>
          a.firstName[0].toLowerCase().compareTo(b.firstName[0].toLowerCase()),
    );
    return studentsList;
  }
}

@HiveType(typeId: 2)
class ClassSchedule {
  @HiveField(1)
  DaysOfTheWeek day;

  @HiveField(2)
  late int startTimeHour;

  @HiveField(3)
  late int startTimeMinute;

  @HiveField(4)
  late int endTimeHour;

  @HiveField(5)
  late int endTimeMinute;

  ClassSchedule(
      {required this.day,
      required this.startTimeHour,
      required this.startTimeMinute,
      required this.endTimeHour,
      required this.endTimeMinute});

  ClassSchedule.usingTimeOfDay(
      {required this.day,
      required TimeOfDay startTime,
      required TimeOfDay endTime}) {
    startTimeHour = startTime.hour;
    startTimeMinute = startTime.minute;
    endTimeHour = endTime.hour;
    endTimeMinute = endTime.minute;
  }

  TimeOfDay getStartTime() {
    return TimeOfDay(hour: startTimeHour, minute: startTimeMinute);
  }

  TimeOfDay getEndTime() {
    return TimeOfDay(hour: endTimeHour, minute: endTimeMinute);
  }
}