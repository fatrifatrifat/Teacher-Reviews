import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teacher_review/models/classes.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/ressources/firestore_methods.dart';

class ReviewsCard extends StatefulWidget {
  final Teacher teacher;
  final String schoolId;
  final List<Classes> classes;

  const ReviewsCard({
    super.key,
    required this.teacher,
    required this.schoolId,
    required this.classes,
  });

  @override
  _ReviewsCardState createState() => _ReviewsCardState();
}

class _ReviewsCardState extends State<ReviewsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Reviews',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: widget.classes.length,
              itemBuilder: (context, classIndex) {
                final mClass = widget.classes[classIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        mClass.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('schools')
                          .doc(widget.schoolId)
                          .collection('teachers')
                          .doc(widget.teacher.teacherId)
                          .collection('classes')
                          .doc(mClass.classId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasError) {
                          return const Center(
                              child: Text('Something went wrong'));
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('No reviews found'));
                        }

                        var classData = Classes.fromSnap(snapshot.data!);

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: classData.reviews.length,
                          itemBuilder: (context, reviewIndex) {
                            double rating = classData.reviews[reviewIndex]
                                ['rating'] as double;
                            String? comment = classData.reviews[reviewIndex]
                                ['comment'] as String?;
                            List<String> likes = List<String>.from(
                                classData.reviews[reviewIndex]['likes'] ?? []);
                            String dateStr =
                                classData.reviews[reviewIndex]['date'] ?? '';
                            DateTime date = DateTime.parse(dateStr);
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(date);
                            String reviewId =
                                classData.reviews[reviewIndex]['id'] ?? '';

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: List.generate(
                                            rating.toInt(),
                                            (i) => Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 4.0),
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  color: getRatingColor(
                                                      rating.toInt()),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: const Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 131, 130, 130),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (comment != null) ...[
                                      const SizedBox(height: 8.0),
                                      Text(
                                        comment,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Thank you for reporting this review. Our team will look into it and take appropriate action.'),
                                              ),
                                            );
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(Icons.flag_outlined),
                                              SizedBox(width: 4.0),
                                              Text('Report'),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                User? user = FirebaseAuth
                                                    .instance.currentUser;
                                                if (user == null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'You need to be logged in to like a review.'),
                                                    ),
                                                  );
                                                } else {
                                                  FirestoreMethods()
                                                      .toggleLikeReview(
                                                    schoolId: widget.schoolId,
                                                    teacherId: widget
                                                        .teacher.teacherId,
                                                    classId: mClass.classId,
                                                    reviewId: reviewId,
                                                    userId: user.uid,
                                                  );
                                                }
                                              },
                                              icon: const Icon(Icons.thumb_up),
                                            ),
                                            Text('${likes.length}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Color getRatingColor(int rating) {
    switch (rating) {
      case 5:
        return Colors.green[700]!;
      case 4:
        return Colors.green;
      case 3:
        return Colors.yellow;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.red;
      default:
        return Colors.red[900]!;
    }
  }
}
