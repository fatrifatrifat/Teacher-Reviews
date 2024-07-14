import 'package:cloud_firestore/cloud_firestore.dart';

class Classes {
  final String name;
  final String classId;
  final String schoolId;
  final String teacherId;
  final List<Map<String, dynamic>> reviews;

  Classes({
    required this.name,
    required this.classId,
    required this.schoolId,
    required this.teacherId,
    required this.reviews,
  });

  factory Classes.fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    List<Map<String, dynamic>> reviewsList = [];
    if (data['reviews'] != null) {
      (data['reviews'] as List).forEach((review) {
        double rating = review['rating']?.toDouble() ?? 0.0;
        String comment = review['comment'] ?? '';
        List<String> likes = (review['likes'] as List<dynamic>?)
                ?.map((like) => like.toString())
                .toList() ??
            [];
        String date = review['date'] ?? '';
        String id = review['id'] ?? '';

        reviewsList.add({
          'rating': rating,
          'comment': comment,
          'likes': likes,
          'date': date,
          'id': id,
        });
      });
    }

    return Classes(
      name: data['name'] ?? 'Unnamed Class',
      classId: data['classId'] ?? '',
      schoolId: data['schoolId'] ?? '',
      teacherId: data['teacherId'] ?? '',
      reviews: reviewsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'classId': classId,
      'schoolId': schoolId,
      'teacherId': teacherId,
      'reviews': reviews.map((review) {
        return {
          'rating': review['rating'],
          'comment': review['comment'],
          'likes': review['likes'],
          'date': review['date'],
          'id': review['id'],
        };
      }).toList(),
    };
  }
}
