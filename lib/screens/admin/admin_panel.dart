import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher_review/models/request.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  Stream<List<Request>> getRequests() {
    return FirebaseFirestore.instance
        .collection('requests')
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Request.fromSnap(doc)).toList());
  }

  Future<void> approveRequest(Request request) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(request.id)
        .update({'status': 'approved'});

    if (request.type == 'teacher') {
      await addTeacherToSchool(request.details);
    } else if (request.type == 'class') {
      await addClassToTeacher(request.details);
    }
  }

  Future<void> rejectRequest(String requestId) async {
    await FirebaseFirestore.instance
        .collection('requests')
        .doc(requestId)
        .update({'status': 'rejected'});
  }

  Future<void> addTeacherToSchool(Map<String, dynamic> teacherDetails) async {
    await FirebaseFirestore.instance
        .collection('schools')
        .doc(teacherDetails['schoolId'])
        .collection('teachers')
        .doc(teacherDetails['teacherId'])
        .set({
      'firstName': teacherDetails['firstName'],
      'lastName': teacherDetails['lastName'],
      'teacherId': teacherDetails['teacherId'],
      'email': teacherDetails['email'],
      'schoolId': teacherDetails['schoolId'],
      'classes': [],
      'rating': [],
    });
  }

  Future<void> addClassToTeacher(Map<String, dynamic> classDetails) async {
    await FirebaseFirestore.instance
        .collection('schools')
        .doc(classDetails['schoolId'])
        .collection('teachers')
        .doc(classDetails['teacherId'])
        .collection('classes')
        .doc(classDetails['classId'])
        .set({
      'name': classDetails['name'],
      'classId': classDetails['classId'],
      'reviews': [],
      'schoolId': classDetails['schoolId'],
      'teacherId': classDetails['teacherId'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      body: StreamBuilder<List<Request>>(
        stream: getRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading requests'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No pending requests'));
          }

          final requests = snapshot.data!;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final requestType = request.type;
              String fullName;

              if (requestType == 'teacher') {
                final firstName = request.details['firstName'];
                final lastName = request.details['lastName'];
                fullName = '$firstName $lastName';
              } else if (requestType == 'class') {
                fullName = '${request.details['name']}}';
              } else {
                fullName = 'unknown';
              }

              return ListTile(
                title: Text(fullName),
                subtitle: Text(request.type),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => approveRequest(request),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => rejectRequest(request.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
