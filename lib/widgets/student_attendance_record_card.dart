import 'package:a_check/models/attendance_record.dart';
import 'package:a_check/utils/abstracts.dart';
import 'package:a_check/widgets/controllers/student_attendance_record_card_state.dart';
import 'package:flutter/material.dart';

class StudentAttendanceRecordCard extends StatefulWidget {
  const StudentAttendanceRecordCard({Key? key, required this.record})
      : super(key: key);

  final AttendanceRecord record;

  @override
  State<StudentAttendanceRecordCard> createState() => SARCState();
}

class SARCView extends WidgetView<StudentAttendanceRecordCard, SARCState> {
  const SARCView(state, {Key? key}) : super(state, key: key);

  Widget radioButton({required String title, required AttendanceStatus value}) {
    return Column(
      children: [
        Text(title),
        Radio<AttendanceStatus>(
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            value: value,
            groupValue: state.status,
            onChanged: state.onRadioChanged)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.record.getStudent.toString(),
                        softWrap: false,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.record.getStudent.id),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                radioButton(title: "P", value: AttendanceStatus.present),
                radioButton(title: "A", value: AttendanceStatus.absent),
                radioButton(title: "L", value: AttendanceStatus.late),
                radioButton(title: "E", value: AttendanceStatus.excused),
              ],
            )
          ],
        ),
      ),
    );
  }
}
