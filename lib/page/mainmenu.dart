import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/courseandquiz.dart';
import 'package:quizz/page/coursehall_2/accounting.dart';
import 'package:quizz/page/dasboard.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/coursehall_2/datacourse.dart';
import 'package:quizz/page/coursehall_2/englishcourse.dart';
import 'package:quizz/page/coursehall_2/investcourse.dart';
import 'package:quizz/page/coursehall_2/marketingcourse.dart';
import 'package:quizz/page/coursehall_2/officecourse.dart';
import 'package:quizz/page/enterCode.dart';
import 'package:quizz/page/favourite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quizz/page/provider/favouriteprovider.dart';
import 'package:quizz/page/provider/providerUser.dart';
import 'package:quizz/page/register_page.dart';
import 'package:quizz/page/quiz_page.dart';
import 'package:quizz/services/firebase/course/course.dart';
import 'package:quizz/services/firebase/course/model/course_model.dart';
import 'package:quizz/services/firebase/quiz/model/quiz_model.dart';
import 'package:quizz/services/firebase/quiz/quiz.dart';
import 'package:quizz/services/sqflite/database.dart';
import 'package:quizz/services/sqflite/favorite.dart';
import 'package:sqflite/sqflite.dart';

class HighlightedBorderIcon extends StatelessWidget {
  final IconData icon;
  final Color borderColor;
  final double size;

  const HighlightedBorderIcon({
    super.key,
    required this.icon,
    required this.borderColor,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(color: borderColor, width: 2.0),
      ),
      child: Icon(
        icon,
        size: size * 0.6,
        color: Colors.transparent,
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  late Database db;
  late Favorite favoriteService;
  late Future<List<Course>> futureCourses;
  late Future<List<QuizModel>> futureQuiz;
  List<Course> _filteredCourses = [];
  List<QuizModel> _filteredQuizes = [];
  int _selectedIndex = 0;
  bool _isVisible = false;
  bool _showBanner = true;

  final dataNavigate = [
    const MainMenu(),
    const Favourite(),
    const CourseAndQuiz()
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => dataNavigate[index]));
    setState(() {});
  }

  void _scrollTo(double offset) {
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    initDatabase().then((database) {
      db = database;
      favoriteService = Favorite(db);
    });
    futureCourses = fetchCourses();
    futureQuiz = fetchQuiz();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 100) {
      setState(() {
        _isVisible = true;
      });
    } else {
      setState(() {
        _isVisible = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showSuccess() {
    setState(() {});
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.of(context).pop();
        });

        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://www.bing.com/th/id/OGC.35f323bc5b41dc4269001529e3ff1278?pid=1.7&rurl=https%3a%2f%2fcdn.dribbble.com%2fusers%2f39201%2fscreenshots%2f3694057%2fmedia%2f2a1b062114a8244102f67deeb89395fa.gif&ehk=UKQWUom9EAuMfI5A9sAGuRTzi%2fdQT1KVKBkUf%2fajUv8%3d',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
        );
      },
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

  void _filterQuizes() {
    final searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredQuizes = _filteredQuizes
          .where((quiz) => quiz.title.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
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
        backgroundColor: const Color(0x00e2f4c5),
        title: const Row(
          children: [
            Text(
              'UP SKILL',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        actions: [
          Builder(
            builder: (context) => Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EnterCodePage()));
                  },
                  child: const Text(
                    'ENTER CODE',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: const DashboardModal(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Tooltip(
                message: 'Home',
                child: Icon(
                  Icons.home,
                  size: 30,
                )),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
                message: 'Favorite',
                child: Icon(
                  Icons.favorite,
                  size: 30,
                )),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
                message: 'Search',
                child: Icon(
                  Icons.search,
                  size: 30,
                )),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (profileProvider.account.isEmpty && _showBanner)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: MaterialBanner(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'It looks like you don’t have an account yet. Sign in to unlock more features, or continue as a guest.',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _showBanner = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: const Text(
                                  'Continue as Guest',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [Container()],
                  ),
                ),
              Container(
                color: const Color(0x00a8cd9f),
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          _scrollTo(630);
                        },
                        child: const Text("Fisika"),
                      ),
                      const SizedBox(width: 50),
                      TextButton(
                        onPressed: () {
                          _scrollTo(1700);
                        },
                        child: const Text("English "),
                      ),
                      const SizedBox(width: 50),
                      TextButton(
                        onPressed: () {
                          _scrollTo(70);
                        },
                        child: const Text("COURSE"),
                      ),
                      const SizedBox(width: 50),
                      TextButton(
                        onPressed: () {
                          _scrollTo(990);
                        },
                        child: const Text("Mathematics"),
                      ),
                      const SizedBox(width: 50),
                      TextButton(
                        onPressed: () {
                          _scrollTo(1350);
                        },
                        child: const Text("Kimia"),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Mari Mulai Belajar",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Pilihan Terbaik Untuk Anda",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star_border_outlined),
                      Text(
                        'Merdeka Belajar',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseAndQuiz()));
                      },
                      child: const Text("SEE MORE >>",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Course>>(
                future: futureCourses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Optional: Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No courses available.");
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((course) {
                          return buildCourseCard(course);
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 50),
              const Text(
                "Kumpulan Soal Quiz",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Selamat datang di Quiz kami",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 50),
              //bagian Komputer dan IT

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star_border_outlined),
                      Text(
                        'Fisika',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseAndQuiz()));
                      },
                      child: const Text("SEE MORE >>",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: 20),
              //tampilan kedua bagian dua
              FutureBuilder<List<QuizModel>>(
                future: futureQuiz,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Optional: Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No courses available.");
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((quiz) {
                          return buildQuizCard(quiz);
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              //Mathematics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star_border_outlined),
                      Text(
                        'Mathematics',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseAndQuiz()));
                      },
                      child: const Text("SEE MORE >>",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: 20),

              FutureBuilder<List<QuizModel>>(
                future: futureQuiz,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Optional: Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No courses available.");
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((quiz) {
                          return buildQuizCard(quiz);
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              //science
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star_border_outlined),
                      Text(
                        'Kimia',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseAndQuiz()));
                      },
                      child: const Text("SEE MORE >>",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: 20),

              FutureBuilder<List<QuizModel>>(
                future: futureQuiz,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Optional: Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No courses available.");
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((quiz) {
                          return buildQuizCard(quiz);
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              //English dan Language art
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star_border_outlined),
                      Text(
                        'English ',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CourseAndQuiz()));
                      },
                      child: const Text("SEE MORE >>",
                          style: TextStyle(color: Colors.white)))
                ],
              ),
              const SizedBox(height: 20),

              FutureBuilder<List<QuizModel>>(
                future: futureQuiz,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Optional: Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No courses available.");
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((quiz) {
                          return buildQuizCard(quiz);
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),

              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                ),
                items: [
                  'assets/Mentor.jpg',
                  'assets/learn.jpeg',
                  'assets/learn2.jpeg',
                  'assets/learn3.jpeg',
                  'assets/learn4.jpeg',
                  'assets/learn5.jpeg',
                ].map((assetPath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Image.asset(
                          assetPath,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              const SizedBox(
                height: 50,
              ),

              //footer
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      maxLines: 3,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _showSuccess();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'SEND',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
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
      child: Card(
        margin: const EdgeInsets.only(right: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Color.fromARGB(255, 145, 143, 143))),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  //child: Image.asset( //untuk menambahkan image di course
                  //item['image']!,
                  //width: 250,
                  //height: 100,
                  //fit: BoxFit.cover,
                  //),
                ),
                Padding(
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
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
                                      return Container();
                                  }
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Learn Here',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Consumer<FavoriteModel>(
                builder: (context, favoriteModel, child) {
                  final isFavorite =
                      favoriteModel.isFavorite(course.courseName);
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
      ),
    );
  }

  Widget buildQuizCard(QuizModel quiz) {
    int totalMarks = quiz.totalMarks;
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.only(right: 20),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Color.fromARGB(255, 145, 143, 143))),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  //child: Image.asset( //untuk menambah image di quiz
                  //item['image']!,
                  //width: 250,
                  //height: 100,
                  //fit: BoxFit.cover,
                  //),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Total Mark: ${totalMarks.toString()}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     for (int i = 0; i < 5; i++)
                      //       Icon(
                      //         i <
                      //                 (double.tryParse(item['rating'] ?? '0') ??
                      //                         0)
                      //                     .round()
                      //             ? Icons.star
                      //             : Icons.star_border,
                      //         color: i <
                      //                 (double.tryParse(item['rating'] ?? '0') ??
                      //                         0)
                      //                     .round()
                      //             ? Colors.yellow
                      //             : Colors.black,
                      //       ),
                      //     const SizedBox(width: 5),
                      //     Text(item['rating'] ?? '0'),
                      //     const SizedBox(width: 5),
                      //     Text(item['reviews'] ?? '0'),
                      //   ],
                      // ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QuizPage(quiz.title, quiz.title)));
                          },
                          child: const Text(
                            'Start Quiz',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Consumer<FavoriteModel>(
                builder: (context, favoriteModel, child) {
                  final isFavorite = favoriteModel.isFavorite(quiz.title);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? const Color.fromARGB(255, 255, 17, 0)
                          : Colors.white,
                    ),
                    onPressed: () {
                      if (!isFavorite) {
                        // favoriteModel.toggleFavorite(item);
                        _showSnackBar(context, "Added to Favorites!");
                      } else {
                        // favoriteModel.toggleFavorite(course);
                        _showSnackBar(context, "Removed from Favorites!");
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
