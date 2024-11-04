import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> initDatabase() async {
  final dbPath = await getDatabasesPath();
  return openDatabase(join(dbPath, 'coursess.db'), version: 1,
      onCreate: (db, version) async {
    try {
      await db.execute('''
      CREATE TABLE favorites(
        favoriteId INTEGER PRIMARY KEY AUTOINCREMENT,
        course_name TEXT,
        course TEXT,
        description TEXT,
        author TEXT,
        category TEXT,
        rating REAL,
        reviews TEXT
      )
    ''');
    } catch (e) {
      'Error Parsing: $e';
    }
  });
}

Future<void> insertFavorite(
    Database db, Map<String, dynamic> courseData) async {
  await db.insert(
    'favorites',
    courseData,
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
