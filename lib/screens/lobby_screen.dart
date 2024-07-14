import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:teacher_review/models/school.dart';
import 'package:teacher_review/models/teacher.dart';
import 'package:teacher_review/screens/admin/admin_panel.dart';
import 'package:teacher_review/screens/home_screen.dart';
import 'package:teacher_review/services/auth/auth_service.dart';
import 'package:teacher_review/utils/math_distance.dart';
import 'package:teacher_review/utils/school_info.dart';
import 'package:teacher_review/widget/cards/school_card.dart';

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen>
    with TickerProviderStateMixin {
  final Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  LatLng? _currentP;

  late AnimationController _searchBarAnimationController;
  late Animation<Offset> _slideSearchAnimation;
  bool _isSearchBarVisible = false;

  late AnimationController _schoolBarAnimationController;
  late Animation<Offset> _slideSchoolAnimation;
  bool _isSchoolBarVisible = false;

  School? _selectedSchool;

  final PanelController _panelController = PanelController();

  final TextEditingController _textEditingController = TextEditingController();

  late List<Teacher> teachers = [];

  late final Stream<QuerySnapshot>? teachersStream;

  late final user;

  List<School> _filteredSchools = [];

  void refreshTeachers() {
    setState(() {
      teachersStream = FirebaseFirestore.instance
          .collection('schools')
          .doc(_selectedSchool!.id)
          .collection('teachers')
          .snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    user = AuthService.firebase().currentUser;
    getLocationUpdates();
    _filteredSchools = schools;

    //search bar
    _searchBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideSearchAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(
        0,
        0,
      ),
    ).animate(
      CurvedAnimation(
        parent: _searchBarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    //school bar
    _schoolBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideSchoolAnimation = Tween<Offset>(
        begin: const Offset(0, 1),
        end: const Offset(
          0,
          0,
        )).animate(
      CurvedAnimation(
        parent: _schoolBarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _searchBarAnimationController.dispose();
    _schoolBarAnimationController.dispose();
    super.dispose();
  }

  void _toggleSearchBar() {
    setState(() {
      if (_isSearchBarVisible) {
        _searchBarAnimationController.reverse();
        FocusManager.instance.primaryFocus?.unfocus();
      } else {
        _searchBarAnimationController.forward();
      }
      _isSearchBarVisible = !_isSearchBarVisible;
    });
  }

  void _toggleSchoolBar(School? school) {
    setState(() {
      if (_isSchoolBarVisible) {
        _schoolBarAnimationController.reverse();
      } else {
        _selectedSchool = school;
        _schoolBarAnimationController.forward();
      }
      _isSchoolBarVisible = !_isSchoolBarVisible;
    });

    if (_selectedSchool != null) {
      FirebaseFirestore.instance
          .collection('schools')
          .doc(_selectedSchool!.id)
          .collection('teachers')
          .get()
          .then((snapshot) {
        List<Teacher> fetchedTeachers = snapshot.docs.map((doc) {
          return Teacher.fromSnap(doc);
        }).toList();

        setState(() {
          teachers = fetchedTeachers;
        });
      }).catchError((error) {
        setState(() {
          teachers = [];
        });
      });
    }
  }

  void _closeSchoolBar() {
    setState(() {
      if (_isSchoolBarVisible) {
        _schoolBarAnimationController.reverse();
        _isSchoolBarVisible = false;
      }
    });
  }

  void _filterSchools(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSchools = schools;
      } else {
        _filteredSchools = schools
            .where((school) =>
                school.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentP != null
              ? GoogleMap(
                  onTap: (_) {
                    _closeSchoolBar();
                    _panelController.close();
                  },
                  onMapCreated: (GoogleMapController controller) =>
                      _mapController.complete(controller),
                  initialCameraPosition: CameraPosition(
                    target: _currentP!,
                    zoom: 13,
                  ),
                  markers: schools
                      .map(
                        (school) => Marker(
                          markerId: MarkerId(school.name),
                          position: school.location,
                          onTap: () {
                            if (_isSchoolBarVisible) {
                              _toggleSchoolBar(null);
                            }
                            _toggleSchoolBar(school);
                            refreshTeachers();
                            //schoolCard.refreshTeachers();
                            //fetchTeachers();
                          },
                        ),
                      )
                      .toSet(),
                )
              : const Center(
                  child: Text('Loading...'),
                ),
          Positioned(
            top: 30,
            right: 10,
            child: FloatingActionButton(
              heroTag: 'search',
              onPressed: () {
                _toggleSearchBar();
                _closeSchoolBar();
              },
              child: const Icon(Icons.search),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              heroTag: 'relocate camera',
              onPressed: () {
                if (_currentP != null) {
                  _cameraToPosition(_currentP!);
                }
              },
              child: const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'logout',
                  onPressed: () {
                    AuthService.firebase().logOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'adminPanel',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AdminPanel(),
                      ),
                    );
                  },
                  child: const Icon(Icons.admin_panel_settings),
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _slideSearchAnimation,
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _toggleSearchBar();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          onChanged: (value) {
                            _filterSchools(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredSchools.length,
                      itemBuilder: (context, index) {
                        final school = _filteredSchools[index];
                        return GestureDetector(
                          onTap: () {
                            _selectedSchool = school;
                            _textEditingController.clear();
                            _toggleSearchBar();
                            _cameraToPosition(_selectedSchool!.location);
                            if (_isSchoolBarVisible) {
                              _toggleSchoolBar(null);
                            }
                            _toggleSchoolBar(school);
                            _filterSchools('');
                            refreshTeachers();
                            //_panelController.open();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Text(school.name),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _slideSchoolAnimation,
              child: GestureDetector(
                onTap: () {
                  // HapticFeedback.lightImpact();
                  _panelController.open();
                  _closeSchoolBar();
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: _selectedSchool == null
                      ? Container()
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: _selectedSchool!.name,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  _selectedSchool!.photoUrl,
                                ),
                                radius: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedSchool!.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    '${_selectedSchool!.address} ${getDistance(_currentP!, _selectedSchool!.location)}Km',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          SlidingUpPanel(
            controller: _panelController,
            maxHeight: MediaQuery.of(context).size.height * 0.75,
            minHeight: 0,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            panelBuilder: (scrollController) {
              return _selectedSchool != null
                  ? SchoolCard(
                      selectedSchool: _selectedSchool!,
                      currentP: _currentP!,
                      textEditingController: _textEditingController,
                      teachersList: teachers,
                    )
                  : const SizedBox.shrink();
            },
            onPanelClosed: () {
              refreshTeachers();
              _toggleSchoolBar(null);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: pos, zoom: 13),
    ));
  }

  void getLocationUpdates() {
    _locationController.onLocationChanged.listen((event) {
      setState(() {
        _currentP = LatLng(event.latitude!, event.longitude!);
      });
    });
  }
}
