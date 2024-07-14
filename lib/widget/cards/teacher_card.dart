import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:teacher_review/models/classes.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/widget/cards/teacher_profile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherCard extends StatefulWidget {
  final Teacher teacher;
  final String schoolId;

  const TeacherCard({
    super.key,
    required this.schoolId,
    required this.teacher,
  });

  @override
  State<TeacherCard> createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  List<Classes> _classes = [];
  double averageRating = 0.0;
  int numberOfRatings = 0;

  @override
  void initState() {
    super.initState();
    _fetchClasses();
  }

  @override
  void didUpdateWidget(TeacherCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.teacher.teacherId != widget.teacher.teacherId ||
        oldWidget.schoolId != widget.schoolId) {
      setState(() {
        _classes = [];
        averageRating = 0.0;
        numberOfRatings = 0;
      });
      _fetchClasses();
    }
  }

  Future<void> _fetchClasses() async {
    try {
      QuerySnapshot classesSnapshot = await FirebaseFirestore.instance
          .collection('schools')
          .doc(widget.schoolId)
          .collection('teachers')
          .doc(widget.teacher.teacherId)
          .collection('classes')
          .get();

      List<Classes> classesList =
          classesSnapshot.docs.map((doc) => Classes.fromSnap(doc)).toList();

      setState(() {
        _classes = classesList;
      });

      _calculateAverageRating();
    } catch (error) {
      // Handle error
      print('Error fetching classes: $error');
    }
  }

  void _calculateAverageRating() {
    double totalRating = 0.0;
    int ratingsCount = 0;

    for (var mClass in _classes) {
      for (var review in mClass.reviews) {
        totalRating += review['rating'];
        ratingsCount++;
      }
    }

    if (ratingsCount > 0) {
      setState(() {
        averageRating = totalRating / ratingsCount;
        numberOfRatings = ratingsCount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: TeacherProfileCard(
                teacher: widget.teacher,
                schoolId: widget.schoolId,
              ),
              duration: const Duration(milliseconds: 100),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: averageRating != 0
                    ? getRatingColor(averageRating)
                    : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  averageRating != 0 ? averageRating.toStringAsFixed(1) : 'N/A',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.teacher.firstName} ${widget.teacher.lastName}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.comment,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$numberOfRatings ratings',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.book,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_classes.length} classes',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Color getRatingColor(double rating) {
    if (rating >= 4.5) return Colors.green[700]!;
    if (rating >= 4.0) return Colors.green;
    if (rating >= 3.0) return Colors.yellow;
    if (rating >= 2.0) return Colors.orange;
    if (rating >= 1.0) return const Color.fromARGB(255, 177, 48, 39);
    return Colors.grey;
  }
}
