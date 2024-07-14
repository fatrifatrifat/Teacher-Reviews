import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher_review/models/classes.dart';
import 'package:teacher_review/models/school.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTeacherToSchool(String schoolId, Teacher teacher) async {
    try {
      String teacherId = const Uuid().v1();
      await _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('teachers')
          .doc(teacherId)
          .set({
        'firstName': teacher.firstName,
        'lastName': teacher.lastName,
        'teacherId': teacherId,
        'email': teacher.email,
        'classes': [],
        'rating': [],
      });
    } catch (e) {
      //print(e.toString());
    }
  }

  Future<void> addClassToTeacher(
      String schoolId, Teacher teacher, Classes mClass) async {
    try {
      await _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('teachers')
          .doc(teacher.teacherId)
          .collection('classes')
          .doc(mClass.classId)
          .set({
        'name': mClass.name,
        'classId': mClass.classId,
        'reviews': [],
        'schoolId': schoolId,
        'teacherId': teacher.teacherId,
      });
    } catch (e) {
      //print(e.toString());
    }
  }

  Future<School> getSchoolById(String schoolId) async {
    DocumentSnapshot schoolDoc =
        await _firestore.collection('schools').doc(schoolId).get();
    return School.fromSnap(schoolDoc);
  }

  Future<void> toggleLikeReview({
    required String schoolId,
    required String teacherId,
    required String classId,
    required String reviewId,
    required String userId,
  }) async {
    try {
      DocumentReference classRef = _firestore
          .collection('schools')
          .doc(schoolId)
          .collection('teachers')
          .doc(teacherId)
          .collection('classes')
          .doc(classId);

      DocumentSnapshot classSnap = await classRef.get();

      if (classSnap.exists) {
        Classes mClass = Classes.fromSnap(classSnap);
        bool reviewFound = false;

        for (var review in mClass.reviews) {
          if (review['id'] == reviewId) {
            reviewFound = true;
            List<String> likes = List<String>.from(review['likes']);
            if (likes.contains(userId)) {
              likes.remove(userId);
            } else {
              likes.add(userId);
            }
            review['likes'] = likes;
            break;
          }
        }

        if (reviewFound) {
          await classRef.update({'reviews': mClass.reviews});
        } else {
          //print('Review not found');
        }
      } else {
        // print('Class does not exist');
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> submitRequest(String type, Map<String, dynamic> details) async {
    await FirebaseFirestore.instance.collection('requests').add({
      'type': type,
      'details': details,
      'status': 'pending',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
