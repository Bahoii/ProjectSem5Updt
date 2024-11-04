import 'package:flutter/material.dart';

class ScoreProvider with ChangeNotifier {
  final Map<String, double> _scores = {};
  final List<Map<String, String>> _history = [];

  Map<String, double> get scores => _scores;
  List<Map<String, String>> get history => _history;

  void updateScore(String quizType, double score) {
    _scores[quizType] = score;
    notifyListeners();
  }

  void addHistory(String quizType, String date) {
    _history.add({'quizType': quizType, 'date': date});
    notifyListeners();
  }
}
