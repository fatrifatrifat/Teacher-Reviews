import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class School {
  String id;
  final String name;
  final String address;
  final LatLng location;
  final String photoUrl;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.photoUrl,
  });

  static School fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return School(
      id: snap.id,
      name: snapshot['name'],
      address: snapshot['address'],
      location: LatLng(
          snapshot['location']['latitude'], snapshot['location']['longitude']),
      photoUrl: snapshot['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'location': {
          'latitude': location.latitude,
          'longitude': location.longitude
        },
        'photoUrl': photoUrl,
        'id': id,
      };
}
