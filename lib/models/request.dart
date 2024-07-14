import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String id;
  final String type;
  final Map<String, dynamic> details;

  Request({required this.id, required this.type, required this.details});

  factory Request.fromSnap(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return Request(
      id: snap.id,
      type: data['type'],
      details: data['details'],
    );
  }
}
