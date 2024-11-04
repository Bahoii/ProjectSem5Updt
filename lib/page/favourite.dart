import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/dasboard.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/mainmenu.dart';
import 'package:quizz/page/courseandquiz.dart';
import 'package:quizz/page/coursehall_2/accounting.dart';
import 'package:quizz/page/coursehall_2/datacourse.dart';
import 'package:quizz/page/coursehall_2/englishcourse.dart';
import 'package:quizz/page/coursehall_2/investcourse.dart';
import 'package:quizz/page/coursehall_2/marketingcourse.dart';
import 'package:quizz/page/coursehall_2/officecourse.dart';
import 'package:quizz/page/enterCode.dart';
import 'package:quizz/page/provider/favouriteprovider.dart';
import 'package:quizz/page/quiz_page.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int _selectedIndex = 1;

  final dataNavigate = [
    const MainMenu(),
    const Favourite(),
    const CourseAndQuiz()
  ];

  Future<void> _loadFavorites() async {
    await Provider.of<FavoriteModel>(context, listen: false).loadFavorites();
  }

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _onItemTapped(int index) {
    _selectedIndex = index;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => dataNavigate[index]));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    if (favoriteModel.isLoaded) {
      favoriteModel.loadFavorites();
    }

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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.grey,
                  ),
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
      body: Consumer<FavoriteModel>(
        builder: (context, favoriteModel, child) {
          final favorites = favoriteModel.favorites.toList();
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No Favorites Yet',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Browse and add items to your favorites',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseAndQuiz()),
                      );
                    },
                    child: const Text(
                      'Explore ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return buildFavoriteCard(favorites[index]);
              },
            );
          }
        },
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
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildFavoriteCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item['courseName'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item['description'],
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Dibuat oleh\n${item['author'] ?? 'Unknown Author'}',
              style: const TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                for (int i = 0; i < 5; i++)
                  Icon(
                    i <
                            (double.tryParse(
                                        item['rating']?.toString() ?? '0') ??
                                    0)
                                .round()
                        ? Icons.star
                        : Icons.star_border,
                    color: i <
                            (double.tryParse(
                                        item['rating']?.toString() ?? '0') ??
                                    0)
                                .round()
                        ? Colors.yellow
                        : Colors.black,
                  ),
                const SizedBox(width: 5),
                Text(item['rating']?.toString() ?? '0'),
                const SizedBox(width: 5),
                Text('(${item['reviews']})')
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  if (item['course'] != null && item['course'].isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          switch (item['course']) {
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

                    const Text(
                      'Start Learn',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    );
                  } else if (item['quiz'] != null && item['quiz'].isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                QuizPage(item['quiz']!, item['title']!)));
                  } else {
                    Container();
                  }
                },
                child: Text(
                  item['course'] != null && item['course'].isNotEmpty
                      ? 'Start Learn'
                      : 'Start Quiz',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
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
