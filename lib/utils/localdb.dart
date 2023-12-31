import 'package:a_check/models/attendance_record.dart';
import 'package:a_check/models/class.dart';
import 'package:a_check/models/student.dart';
import 'package:hive/hive.dart';

class HiveBoxes {
  static const classes = "classes";
  static const students = "students";
  // static const guardians = "students";
  static const attendances = "attendances";

  static Box classesBox() => Hive.box(classes);
  static Box studentsBox() => Hive.box(students);
  // static Box guardiansBox() => Hive.box(guardians);
  static Box attendancesBox() => Hive.box(attendances);

  static initialize() async {
    initializeAdapters();

    await Hive.openBox(classes);
    await Hive.openBox(students);
    // await Hive.openBox(guardians);
    await Hive.openBox(attendances);
  }

  static initializeAdapters() {
    Hive.registerAdapter(DaysOfTheWeekAdapter());
    Hive.registerAdapter(ClassAdapter());
    Hive.registerAdapter(ClassScheduleAdapter());
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(StudentAdapter());
    Hive.registerAdapter(AttendanceStatusAdapter());
    Hive.registerAdapter(AttendanceRecordAdapter());
  }

  static clearAllData() {
    classesBox().clear();
    studentsBox().clear();
    // guardiansBox().clear;
    attendancesBox().clear;
  }
}