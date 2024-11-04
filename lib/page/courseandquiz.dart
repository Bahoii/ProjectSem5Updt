// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/dasboard.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/mainmenu.dart';
import 'package:quizz/page/coursehall_2/accounting.dart';
import 'package:quizz/page/coursehall_2/datacourse.dart';
import 'package:quizz/page/coursehall_2/englishcourse.dart';
import 'package:quizz/page/coursehall_2/investcourse.dart';
import 'package:quizz/page/coursehall_2/marketingcourse.dart';
import 'package:quizz/page/coursehall_2/officecourse.dart';
import 'package:quizz/page/enterCode.dart';
import 'package:quizz/page/favourite.dart';
import 'package:quizz/page/provider/favouriteprovider.dart';
import 'package:quizz/services/firebase/course/course.dart';
import 'package:quizz/services/firebase/course/model/course_model.dart';
import 'package:quizz/services/sqflite/database.dart';
import 'package:quizz/services/sqflite/favorite.dart';
import 'package:sqflite/sqflite.dart';

class CourseAndQuiz extends StatefulWidget {
  const CourseAndQuiz({super.key});

  @override
  _CourseAndQuizState createState() => _CourseAndQuizState();
}

class _CourseAndQuizState extends State<CourseAndQuiz> {
  final TextEditingController _searchController = TextEditingController();
  late Database db;
  late Favorite favoriteService;
  late Future<List<Course>> futureCourses;
  List<Course> _filteredCourses = [];
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 2;
  bool _isVisible = false;

  final dataNavigate = [
    const MainMenu(),
    const Favourite(),
    const CourseAndQuiz()
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    initDatabase().then((database) {
      db = database;
      favoriteService = Favorite(db);
    });
    futureCourses = fetchCourses();
    _searchController.addListener(_filterCourses);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => dataNavigate[index]),
    );
  }

  void _scrollListener() {
    setState(() {
      _isVisible = _scrollController.offset >= 100;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _filterCourses() {
    final searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredCourses = _filteredCourses
          .where(
              (course) => course.courseName.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        backgroundColor: const Color(0xFF2F4C50),
        title: const Text(
          'UP SKILL',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EnterCodePage()),
            ),
            child: const Text(
              'ENTER CODE',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.grey,
            ),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
            child: const Text(
              'LOGIN',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      drawer: const DashboardModal(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Course or Quiz',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 30),
              FutureBuilder<List<Course>>(
                future: futureCourses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    print('Error loading courses: ${snapshot.error}');
                    return const Center(child: Text('Failed to load courses'));
                  } else if (snapshot.hasData) {
                    _filteredCourses = snapshot.data!;
                    return _filteredCourses.isEmpty
                        ? const Center(child: Text('No courses found'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _filteredCourses.length,
                            itemBuilder: (context, index) =>
                                buildCourseCard(_filteredCourses[index]),
                          );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.grey,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            )
          : null,
    );
  }

  int _averageRating(List<dynamic> feedback) {
    final List<Map<String, dynamic>> feedbackList = feedback
        .whereType<Map<String, dynamic>>()
        .cast<Map<String, dynamic>>()
        .toList();

    if (feedbackList.isEmpty) return 0;

    final int sum = feedbackList.fold<int>(
      0,
      (sum, feedback) => sum + (feedback['rating'] as int? ?? 0),
    );

    return (sum / feedbackList.length).round();
  }

  Widget buildCourseCard(Course course) {
    int rating = 0;
    int feedbackCount = 0;

    final List<dynamic> feedbackList = course.category.feedback;
    feedbackCount = feedbackList.length;
    rating = _averageRating(feedbackList);

    return GestureDetector(
      child: Stack(
        children: [
          Card(
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Color.fromARGB(255, 145, 143, 143)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.courseName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    course.description,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dibuat oleh\n${course.user.name}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          i < rating ? Icons.star : Icons.star_border,
                          color: i < rating ? Colors.yellow : Colors.black,
                        ),
                      const SizedBox(width: 5),
                      Text(rating.toString()),
                      const SizedBox(width: 5),
                      Text('($feedbackCount)'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          switch (course.mainCourse) {
                            case 'DataCourse':
                              return const DataCourse();
                            case 'AccountingCourse':
                              return const AccountingCourse();
                            case 'EnglishCourse':
                              return const EnglishCourse();
                            case 'InvestCourse':
                              return const InvestCourse();
                            case 'MarketCourse':
                              return const MarketCourse();
                            case 'OfficeCourse':
                              return const OfficeCourse();
                            default:
                              return const DataCourse();
                          }
                        }),
                      ),
                      child: const Text(
                        'Learn Here',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            child: Consumer<FavoriteModel>(
              builder: (context, favoriteModel, child) {
                final isFavorite = favoriteModel.isFavorite(course.courseName);
                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? const Color.fromARGB(255, 255, 17, 0)
                        : Colors.grey,
                  ),
                  onPressed: () async {
                    await favoriteModel.toggleFavorite(course);
                    _showSnackBar(
                      context,
                      isFavorite
                          ? "Removed from Favorites!"
                          : "Added to Favorites!",
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
