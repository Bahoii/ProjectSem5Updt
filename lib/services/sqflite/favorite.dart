import 'package:quizz/services/firebase/course/model/course_model.dart';
import 'package:quizz/services/sqflite/database.dart';
import 'package:sqflite/sqflite.dart';

class Favorite {
  final Database db;

  Favorite(this.db);

  Future<void> toggleFavorite(Course course) async {
    final isFavorite = await isCourseFavorite(course.courseName);

    if (isFavorite) {
      await removeFavorite(course.courseName);
    } else {
      await addFavorite(course);
    }
  }

  Future<bool> isCourseFavorite(String courseName) async {
    final List<Map<String, dynamic>> favorites = await db.query(
      'favorites',
      where: 'course_name = ?',
      whereArgs: [courseName],
    );
    return favorites.isNotEmpty;
  }

  Future<void> addFavorite(Course course) async {
    int rating = 0;
    int feedbackCount = 0;

    if (course.category.feedback.isNotEmpty) {
      feedbackCount = course.category.feedback.length;
      rating = _averageRating(course.category.feedback);
    } else {
      print('No feedback available for this course.');
    }

    final courseData = {
      'course_name': course.courseName,
      'description': course.description,
      'course': course.mainCourse,
      'author': course.user.name,
      'category': course.category.categoryName,
      'rating': rating,
      'reviews': feedbackCount
    };

    await insertFavorite(db, courseData);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final List<Map<String, dynamic>> favoriteData = await db.query('favorites');

    final processedFavorites = favoriteData.map((item) {
      return {
        'courseName': item['course_name'],
        'description': item['description'],
        'course': item['course'],
        'author': item['author'],
        'category': item['category'],
        'rating': item['rating'],
        'reviews': item['reviews'], // Add deserialized reviews here
      };
    }).toList();

    return processedFavorites;
  }

  Future<void> removeFavorite(String courseName) async {
    await db.delete(
      'favorites',
      where: 'course_name = ?',
      whereArgs: [courseName],
    );
  }
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
