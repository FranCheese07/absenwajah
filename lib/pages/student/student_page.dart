import 'package:a_check/models/class.dart';
import 'package:a_check/models/student.dart';
import 'package:a_check/pages/student/controllers/student_state.dart';
import 'package:a_check/utils/abstracts.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key, required this.studentKey, this.studentClass})
      : super(key: key);

  final String studentKey;
  final Class? studentClass;

  @override
  State<StudentPage> createState() => StudentState();
}

class StudentView extends WidgetView<StudentPage, StudentState> {
  const StudentView(state, {Key? key}) : super(state, key: key);

  Widget buildHeader(Student student) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35.0),
            bottomRight: Radius.circular(35.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Container(
                        height: 112,
                        width: 112,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          border: Border.fromBorderSide(BorderSide()),
                          shape: BoxShape.circle,
                        ),
                        child: state.student.facePhotoBytes != null
                            ? Image.memory(state.student.facePhotoBytes!)
                            : const Icon(Icons.person_2),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                        child: Text(
                          student.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xfffcfcfc),
                          ),
                        ),
                      ),
                      Text(
                        student.id,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xffe9e9e9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStudentInfo(Student student) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          width: 400,
          height: 35,
          decoration: const BoxDecoration(
            color: Color(0x00ffffff),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.zero,
          ),
          child: Card(
            margin: const EdgeInsets.all(2.0),
            color: const Color(0xffffffff),
            shadowColor: const Color(0xffebebeb),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: student.hasRegisteredFace()
                ? GestureDetector(
                    onLongPress: state.registerFace,
                    child: Checkbox(
                        value: student.hasRegisteredFace(),
                        onChanged: (value) {/* do nothing */}),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: MaterialButton(
                      onPressed: state.registerFace,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Student Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                enabled: false,
                decoration: const InputDecoration(
                    labelText: "Contact Number", isDense: true),
                controller: TextEditingController(text: student.phone),
              ),
              TextField(
                enabled: false,
                decoration:
                    const InputDecoration(labelText: "E-mail", isDense: true),
                controller: TextEditingController(text: student.email),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGuardianInfo(Student student) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Guardian Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          student.guardian.toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        TextField(
          enabled: false,
          decoration:
              const InputDecoration(labelText: "Contact Number", isDense: true),
          controller: TextEditingController(text: student.guardian?.phone),
        ),
        TextField(
          enabled: false,
          decoration: const InputDecoration(labelText: "E-mail", isDense: true),
          controller: TextEditingController(text: student.guardian?.email),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: state.studentValueNotifier,
      builder: (context, student, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            PopupMenuButton(
              itemBuilder: (context) => [
                if (widget.studentClass != null)
                  PopupMenuItem(
                      onTap: state.removeFromClass,
                      child: const Text("Remove from class")),
                PopupMenuItem(
                  onTap: state.editStudent,
                  child: const Text("Edit student"),
                )
              ],
            )
          ],
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(student),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    buildStudentInfo(student),
                    const SizedBox(height: 24),
                    student.guardian != null
                        ? buildGuardianInfo(student)
                        : const Text("No guardian!"),
                  ],
                )),
          ],
        )),
      ),
    );
  }
}
