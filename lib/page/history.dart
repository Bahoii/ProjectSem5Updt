import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/provider/providerScore.dart';

class QuizHistory extends StatelessWidget {
  const QuizHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title:
            const Text('Quiz History', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Consumer<ScoreProvider>(
          builder: (context, scoreProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'History:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildHistoryList(scoreProvider),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHistoryList(ScoreProvider scoreProvider) {
    List<Widget> historyItems = [];

    for (var history in scoreProvider.history) {
      historyItems.add(
        HistoryInfoItem(
          icon: Icons.book,
          label: history['quizType']!,
          value: history['date']!,
        ),
      );
    }

    if (historyItems.isEmpty) {
      historyItems.add(
        const HistoryInfoItem(
          icon: Icons.not_interested,
          label: 'No Quiz Were Made',
          value: '',
        ),
      );
    }

    return Column(children: historyItems);
  }
}

class HistoryInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const HistoryInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30.0,
            color: Colors.grey,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
