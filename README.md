# Quebec School Review App

## Project Description
This Flutter application allows users to browse and review teachers from CEGEPs and universities in Quebec. Users can create an account or log in as a guest, search for schools, view teacher ratings, and leave reviews. Admins can manage requests for adding teachers and classes.

## Features
- Account creation and guest login
- Interactive map with markers for Quebec CEGEPs and universities
- Search functionality for schools and teachers
- View school details and teacher reviews
- Add and manage teacher and class requests
- Admin panel for handling requests

## Installation

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Firebase account: [Create a Firebase project](https://firebase.google.com/)

### Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/quebec-school-review-app.git
   cd quebec-school-review-app

2. Install dependencies:
   ```bash
   flutter pub get

3. Add your google-services.json file to the android/app/ directory.

4. Set up your Firebase and Google Maps API keys.

### Build and Run
To run the app, use the following command:
```bash
flutter run
```

To build the app for release:
```bash
-flutter build apk  # For Android
-flutter build ios  # For iOS
```
### Usage
-Upon launching the app, you can either log in or browse as a guest.
-Use the search bar to find schools or teachers.
-Click on school markers on the map to view details.
-Leave reviews for teachers by selecting a teacher and rating them.

### Credits
-Flutter for the framework.
-Firebase for backend services.
-Google Maps API for the map functionality.