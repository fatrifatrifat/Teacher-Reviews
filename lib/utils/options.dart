import 'package:flutter_dotenv/flutter_dotenv.dart';

final googleMapsApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
final firebaseApiKey = dotenv.env['FIREBASE_API_KEY'];
final firebaseAuthDomain = dotenv.env['FIREBASE_AUTH_DOMAIN'];
final firebaseProjectId = dotenv.env['FIREBASE_PROJECT_ID'];
final firebaseStorageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'];
final firebaseMessagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
final firebaseAppId = dotenv.env['FIREBASE_APP_ID'];
final firebaseMeasurementId = dotenv.env['FIREBASE_MEASUREMENT_ID'];
