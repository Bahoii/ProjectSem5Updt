import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quizz/l10n/l10n.dart';
import 'package:quizz/l10n/languageprovide.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/provider/DarkmodeProvider.dart';
import 'package:quizz/page/provider/TimerProvider.dart';
import 'package:quizz/page/provider/favouriteprovider.dart';
import 'package:quizz/page/provider/providerScore.dart';
import 'package:quizz/page/provider/providerUser.dart';
import 'package:quizz/services/sqflite/database.dart';
import 'package:quizz/services/sqflite/favorite.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await deleteDatabase(join(await getDatabasesPath(), 'coursess.db'));
  // await Firebase.initializeApp();

  final Database db = await initDatabase();
  final Favorite favoriteService = Favorite(db);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProfileProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ScoreProvider(),
      ),
      ChangeNotifierProvider(create: (context) => darkModeProvider()),
      ChangeNotifierProvider(create: (context) => TimerModel()),
      ChangeNotifierProvider(
          create: (context) => FavoriteModel(favoriteService)),
      ChangeNotifierProvider(
        create: (context) =>
            LocaleProvider(), // Tambahkan LocaleProvider di sini
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<darkModeProvider>(context);
    final localeProv = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      locale: localeProv.locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      title: 'SKILL UP',
      theme: prov.enableDarkMode == true ? prov.dark : prov.light,
      home: const LoginPage(),
    );
  }
}
