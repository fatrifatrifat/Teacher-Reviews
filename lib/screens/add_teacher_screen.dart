import 'package:flutter/material.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/ressources/firestore_methods.dart';
import 'package:uuid/uuid.dart';

class AddTeacherScreen extends StatefulWidget {
  final String schoolId;
  final List<Teacher> teachersList;
  const AddTeacherScreen({
    super.key,
    required this.schoolId,
    required this.teachersList,
  });

  @override
  _AddTeacherScreenState createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter first name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter last name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email (Optional)',
                hintText: 'Enter email',
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Teacher t = Teacher(
                  teacherId: const Uuid().v4(),
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  email: _emailController.text,
                  classes: [],
                );
                for (Teacher mTeacher in widget.teachersList) {
                  if (t.firstName.toLowerCase() ==
                          mTeacher.firstName.toLowerCase() &&
                      t.lastName.toLowerCase() ==
                          mTeacher.lastName.toLowerCase()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('This teacher already exists.')),
                    );
                    return;
                  }
                }
                // FirestoreMethods().addTeacherToSchool(
                //   widget.schoolId,
                //   t,
                // );
                FirestoreMethods().submitRequest('teacher', {
                  'firstName': t.firstName,
                  'lastName': t.lastName,
                  'email': t.email,
                  'schoolId': widget.schoolId,
                  'teacherId': t.teacherId,
                });

                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: const Text('Add Teacher'),
            ),
          ],
        ),
      ),
    );
  }
}
