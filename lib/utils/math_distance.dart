import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

double getDistance(LatLng first, LatLng second) {
  const double R = 6371;
  double lat1 = first.latitude * pi / 180;
  double lon1 = first.longitude * pi / 180;
  double lat2 = second.latitude * pi / 180;
  double lon2 = second.longitude * pi / 180;

  double dLat = lat2 - lat1;
  double dLon = lon2 - lon1;

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = R * c;

  return double.parse(distance.toStringAsFixed(1));
}
