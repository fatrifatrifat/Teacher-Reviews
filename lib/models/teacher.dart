import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher_review/models/classes.dart';

class Teacher {
  final String firstName;
  final String lastName;
  final String email;
  final String teacherId;
  final List<Classes> classes;

  Teacher({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.teacherId,
    required this.classes,
  });

  factory Teacher.fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    List<Classes> classesList = [];
    if (data['classes'] != null) {
      data['classes'].forEach((classData) {
        classesList.add(Classes.fromSnap(classData));
      });
    }

    return Teacher(
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      teacherId: data['teacherId'],
      classes: classesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'teacherId': teacherId,
      'classes': classes.map((classObj) => classObj.toJson()).toList(),
    };
  }
}
