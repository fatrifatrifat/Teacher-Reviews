import 'package:flutter/material.dart';
import 'package:teacher_review/models/classes.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/ressources/firestore_methods.dart';
import 'package:uuid/uuid.dart';

class ClassInputScreen extends StatefulWidget {
  final String schoolId;
  final Teacher teacher;
  const ClassInputScreen({
    super.key,
    required this.teacher,
    required this.schoolId,
  });

  @override
  _ClassInputScreenState createState() => _ClassInputScreenState();
}

class _ClassInputScreenState extends State<ClassInputScreen> {
  TextEditingController classNameController = TextEditingController();
  TextEditingController classDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: classNameController,
              decoration: const InputDecoration(
                labelText: 'Class Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: classDetailsController,
              decoration: const InputDecoration(
                labelText: 'Class Details',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String className = classNameController.text;
                String classDetails = classDetailsController.text;

                if (className.isNotEmpty || classDetails.isNotEmpty) {
                  Classes newClass = Classes(
                    name: className,
                    classId: const Uuid().v4(),
                    schoolId: widget.schoolId,
                    teacherId: widget.teacher.teacherId,
                    reviews: [],
                  );
                  // FirestoreMethods().addClassToTeacher(
                  //     widget.schoolId, widget.teacher, newClass);

                  FirestoreMethods().submitRequest('class', {
                    'classId': newClass.classId,
                    'name': className,
                    'teacherId': widget.teacher.teacherId,
                    'schoolId': widget.schoolId,
                    'reviews': [],
                  });
                }
              },
              child: const Text('Add Class'),
            ),
          ],
        ),
      ),
    );
  }
}
