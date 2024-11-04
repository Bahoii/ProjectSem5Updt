import 'package:flutter/material.dart';
import 'package:quizz/services/firebase/course/model/course_model.dart';
import 'package:quizz/services/sqflite/favorite.dart';

class FavoriteModel with ChangeNotifier {
  final Favorite _favoriteService;
  final Set<Map<String, dynamic>> _favorites = <Map<String, dynamic>>{};
  bool isLoaded = false;

  FavoriteModel(this._favoriteService);

  Set<Map<String, dynamic>> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final favoritesList = await _favoriteService.getFavorites();

    _favorites.clear();
    _favorites.addAll(favoritesList);
    isLoaded = true;
    notifyListeners();
  }

  Future<void> toggleFavorite(Course course) async {
    int rating = 0;
    if (course.category.feedback.isNotEmpty) {
      var feedback = course.category.feedback[0];

      if (feedback is Map<String, dynamic> && feedback['rating'] is int) {
        rating = feedback['rating'];
      } else {
        print('Invalid feedback structure: $feedback');
      }
    } else {
      print('No feedback available for this course.');
    }
    Map<String, dynamic> courseData = {
      'courseName': course.courseName,
      'course': course.mainCourse,
      'description': course.description,
      'author': course.user.name,
      'category': course.category,
      'rating': rating,
      'reviews': rating,
    };

    try {
      if (isFavorite(course.courseName)) {
        _favorites.removeWhere(
            (element) => element['courseName'] == course.courseName);
        await _favoriteService.removeFavorite(course.courseName);
        print('remove $courseData to favorites');
      } else {
        _favorites.add(courseData);
        await _favoriteService.addFavorite(course);
        print('Added $courseData to favorites');
      }
      notifyListeners(); // Update UI
    } catch (e) {
      // Handle error for add/remove favorite
      print("Error toggling favorite: $e");
    }
  }

  /// Check if a course is a favorite
  bool isFavorite(String courseName) {
    return _favorites.any((element) => element['courseName'] == courseName);
  }
}
