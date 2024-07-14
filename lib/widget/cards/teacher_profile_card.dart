import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teacher_review/models/classes.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/screens/add_review_screen.dart';
import 'package:teacher_review/screens/class_input_screen.dart';
import 'reviews_card.dart';

class TeacherProfileCard extends StatefulWidget {
  final Teacher teacher;
  final String schoolId;

  const TeacherProfileCard({
    super.key,
    required this.teacher,
    required this.schoolId,
  });

  @override
  _TeacherProfileCardState createState() => _TeacherProfileCardState();
}

class _TeacherProfileCardState extends State<TeacherProfileCard> {
  int _selectedClassIndex = 0;
  List<Classes> classes = [];

  Color getRatingColor(double rating) {
    if (rating >= 4.5) return Colors.green[700]!;
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.yellow;
    if (rating >= 2.0) return Colors.orange;
    if (rating >= 1.0) return const Color.fromARGB(255, 177, 48, 39);
    return Colors.red[900]!;
  }

  @override
  void initState() {
    super.initState();
    _fetchClasses();
  }

  Future<void> _fetchClasses() async {
    try {
      final classesSnapshot = await FirebaseFirestore.instance
          .collection('schools')
          .doc(widget.schoolId)
          .collection('teachers')
          .doc(widget.teacher.teacherId)
          .collection('classes')
          .get();

      setState(() {
        classes =
            classesSnapshot.docs.map((doc) => Classes.fromSnap(doc)).toList();
      });
    } catch (error) {
      //print('Error fetching classes: $error');
    }
  }

  void _handleReviewAdded() {
    _fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.teacher.firstName} ${widget.teacher.lastName}'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('schools')
                      .doc(widget.schoolId)
                      .collection('teachers')
                      .doc(widget.teacher.teacherId)
                      .collection('classes')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error fetching classes'),
                      );
                    }

                    final docs = snapshot.data!.docs;
                    classes = docs.map((doc) => Classes.fromSnap(doc)).toList();

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: classes.length + 1,
                      itemBuilder: (context, index) {
                        if (index == classes.length) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: OutlinedButton(
                              onPressed: () {
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'You need to be logged in to add a class.')),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClassInputScreen(
                                        schoolId: widget.schoolId,
                                        teacher: widget.teacher,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                side: BorderSide(color: Colors.grey[300]!),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.add, color: Colors.black),
                                  SizedBox(width: 4),
                                  Text(
                                    'Class',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _selectedClassIndex == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: BorderSide(
                                color: _selectedClassIndex == index
                                    ? Colors.blue
                                    : Colors.grey[300]!,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedClassIndex = index;
                              });
                            },
                            child: Text(
                              classes[index].name,
                              style: TextStyle(
                                color: _selectedClassIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const Divider(),
              Expanded(
                child: ReviewsCard(
                  teacher: widget.teacher,
                  schoolId: widget.schoolId,
                  classes: classes,
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
                icon: const Icon(Icons.add),
                color: Colors.white,
                onPressed: () {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'You need to be logged in to make a review.')),
                    );
                  } else {
                    if (classes.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Add a class in order to make a review'),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddReviewScreen(
                            schoolId: widget.schoolId,
                            teacher: widget.teacher,
                            selectedClass: classes[_selectedClassIndex],
                            onReviewAdded: _handleReviewAdded,
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
