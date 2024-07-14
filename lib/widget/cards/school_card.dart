import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teacher_review/models/school.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/screens/add_teacher_screen.dart';
import 'package:teacher_review/utils/math_distance.dart';
import 'package:teacher_review/widget/cards/teacher_card.dart';

class SchoolCard extends StatefulWidget {
  final School selectedSchool;
  final LatLng currentP;
  final TextEditingController textEditingController;
  final List<Teacher> teachersList;

  const SchoolCard({
    super.key,
    required this.selectedSchool,
    required this.currentP,
    required this.textEditingController,
    required this.teachersList,
  });

  @override
  State<SchoolCard> createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchTeacherController =
      TextEditingController();
  List<Teacher> _filteredTeachers = [];
  List<Teacher> _allTeachers = [];
  StreamSubscription<List<Teacher>>? _teachersSubscription;

  final inputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 226, 226, 226)),
  );

  @override
  void initState() {
    super.initState();
    _searchTeacherController.addListener(_searchTeacherListener);
    _updateTeachers();
  }

  @override
  void didUpdateWidget(SchoolCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedSchool.id != widget.selectedSchool.id) {
      _updateTeachers();
    }
  }

  @override
  void dispose() {
    _searchTeacherController.removeListener(_searchTeacherListener);
    _searchTeacherController.dispose();
    _teachersSubscription?.cancel();
    super.dispose();
  }

  void _updateTeachers() {
    _teachersSubscription?.cancel();
    _teachersSubscription = _getTeachersStream().listen((teachers) {
      if (mounted) {
        setState(() {
          _allTeachers = teachers;
          _searchTeacher(_searchTeacherController.text);
        });
      }
    });
  }

  void _searchTeacherListener() {
    _searchTeacher(_searchTeacherController.text);
  }

  void _searchTeacher(String query) {
    if (!mounted) return;
    setState(() {
      if (query.isEmpty) {
        _filteredTeachers = _allTeachers;
      } else {
        _filteredTeachers = _allTeachers.where((teacher) {
          final firstName = teacher.firstName.toLowerCase();
          final lastName = teacher.lastName.toLowerCase();
          final input = query.toLowerCase();
          return firstName.contains(input) || lastName.contains(input);
        }).toList();
      }
    });
  }

  Stream<List<Teacher>> _getTeachersStream() {
    return FirebaseFirestore.instance
        .collection('schools')
        .doc(widget.selectedSchool.id)
        .collection('teachers')
        .snapshots()
        .map((snapshot) {
      print("Fetching teachers for school: ${widget.selectedSchool.id}");
      return snapshot.docs.map((doc) => Teacher.fromSnap(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.selectedSchool.name,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.selectedSchool.photoUrl),
                      radius: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedSchool.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '${widget.selectedSchool.address} ${getDistance(widget.currentP, widget.selectedSchool.location)}Km',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchTeacherController,
                decoration: InputDecoration(
                  hintText:
                      'Find your teacher at ${widget.selectedSchool.name}',
                  hintStyle: const TextStyle(
                      fontSize: 14, fontStyle: FontStyle.italic),
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.text,
                obscureText: false,
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _filteredTeachers.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TeacherCard(
                    schoolId: widget.selectedSchool.id,
                    teacher: _filteredTeachers[index],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.person_add),
              color: Colors.white,
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('You need to be logged in to add a teacher.')),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddTeacherScreen(
                        schoolId: widget.selectedSchool.id,
                        teachersList: _allTeachers,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
