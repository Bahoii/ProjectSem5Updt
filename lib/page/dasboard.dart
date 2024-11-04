import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/contactus.dart';
import 'package:quizz/page/courseandquiz.dart';
import 'package:quizz/page/help.dart';
import 'package:quizz/page/history.dart';
import 'package:quizz/page/profile_page.dart';
import 'package:quizz/page/provider/providerUser.dart';
import 'package:quizz/page/score.dart';
import 'package:quizz/page/setting.dart';
import 'package:quizz/page/about_us.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardModal extends StatelessWidget {
  const DashboardModal({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    String username = profileProvider.account.isNotEmpty
        ? profileProvider.account[0].name
        : '';
    String email = profileProvider.account.isNotEmpty
        ? profileProvider.account[0].email
        : '';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.grey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color.fromARGB(255, 98, 97, 99),
                        backgroundImage: profileProvider.account.isNotEmpty
                            ? profileProvider.account[0].profilePicture != null
                                ? MemoryImage(
                                    profileProvider.account[0].profilePicture!)
                                : null
                            : null,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(' Profile'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.score),
            title: const Text('Score'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Score()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Courses & Quizzes'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CourseAndQuiz()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Quiz History'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QuizHistory()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('Contact'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpPage()));
            },
          ),
          // Tambahkan opsi "About Us"
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          // Tombol logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              await prefs.remove('username');
              await prefs.remove('password');
              await prefs.remove('userId');

              // Navigate to the login page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
