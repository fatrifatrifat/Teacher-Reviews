import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teacher_review/models/classes.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:uuid/uuid.dart';

class AddReviewScreen extends StatefulWidget {
  final String schoolId;
  final Teacher teacher;
  final Classes selectedClass;
  final Function onReviewAdded;

  const AddReviewScreen({
    super.key,
    required this.selectedClass,
    required this.schoolId,
    required this.teacher,
    required this.onReviewAdded,
  });

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int _selectedStars = 0;
  final TextEditingController _commentController = TextEditingController();

  void _onStarTap(int index) {
    setState(() {
      _selectedStars = index + 1;
    });
  }

  Color _getColorForRating(int rating) {
    switch (rating) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return const Color.fromARGB(255, 228, 205, 5);
      case 4:
        return Colors.green;
      case 5:
        return const Color.fromARGB(255, 61, 143, 63);
      default:
        return Colors.grey;
    }
  }

  Future<void> _submitReview() async {
    if (_selectedStars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating')),
      );
      return;
    }

    final String comment = _commentController.text.trim();

    Map<String, dynamic> newReview = {
      'rating': _selectedStars,
      'comment': comment,
      'date': DateTime.now().toIso8601String(),
      'likes': [],
      'id': const Uuid().v4(),
    };

    List<Map<String, dynamic>> updatedReviews =
        List.from(widget.selectedClass.reviews)..add(newReview);

    try {
      await FirebaseFirestore.instance
          .collection('schools')
          .doc(widget.schoolId)
          .collection('teachers')
          .doc(widget.teacher.teacherId)
          .collection('classes')
          .doc(widget.selectedClass.classId)
          .update({'reviews': updatedReviews});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Review submitted successfully')),
      );

      widget.onReviewAdded();

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedClass.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => _onStarTap(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: _selectedStars > index
                          ? _getColorForRating(_selectedStars)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 32.0,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: 'Add your comment here...',
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitReview,
                child: const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
