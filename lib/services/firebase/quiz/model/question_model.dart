// import 'package:quizz/services/firebase/quiz/model/quiz_model.dart';

// class QuestionModel {
//   String id;
//   QuizModel quiz;
//   String questionText;
//   String answerOptions;
//   String correctAnswer;

//   QuestionModel({
//     required this.id,
//     required this.quiz,
//     required this.questionText,
//     required this.answerOptions,
//     required this.correctAnswer,
//   });

//   factory QuestionModel.fromJson(Map<String, dynamic> json) {
//     return QuestionModel(
//       id: json['id'],
//       quiz: (json['quiz'] != null && json['quiz'] is Map<String, dynamic>)
//           ? QuizModel.fromJson(json['quiz'])
//           : QuizModel(
//               id: 'No ID',
//               title: 'Unknown',
//               course: json['courseId'],
//               totalMarks: 0,
//             ),
//       questionText: json['title'] ?? '',
//       answerOptions: json['answerOptions'] ?? 0,
//       correctAnswer: json['correctAnswer'] ?? 0,
//     );
//   }
// }
