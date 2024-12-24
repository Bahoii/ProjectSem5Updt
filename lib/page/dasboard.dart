import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/language.dart';
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
            title: Text(AppLocale.translate(context, 'skor')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Score()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(AppLocale.translate(context, 'kursusdanquiz')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CourseAndQuiz()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(AppLocale.translate(context, 'riwayatQuiz')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const QuizHistory()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: Text(AppLocale.translate(context, 'kontak')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ContactUsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocale.translate(context, 'setelan')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(AppLocale.translate(context, 'bantuan')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpPage()));
            },
          ),
          // Tambahkan opsi "About Us"
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(AppLocale.translate(context, 'Tentang Kami')),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          // Tombol logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocale.translate(context, 'keluar')),
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
