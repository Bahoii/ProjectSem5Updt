import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.grey,
        title: const Text('Help', style: TextStyle(color: Colors.white)),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              FaqItem(
                question: 'How do I reset my password?',
                answer:
                    'To reset your password, go to the settings page and select the option to reset your password. Follow the prompts to complete the process.',
              ),
              FaqItem(
                question: 'Where can I find my account information?',
                answer:
                    'You can find your account information by navigating to the profile page. Your account details, including username and email address, will be displayed there.',
              ),
              FaqItem(
                question: 'How can I contact customer support?',
                answer:
                    'For any inquiries or issues, you can contact our customer support team at support@example.com or by calling our hotline at 1-800-123-4567.',
              ),
              FaqItem(
                question: 'Can I change my username?',
                answer:
                    'Yes, you can change your username by going to the profile settings and selecting the option to edit your username. Follow the prompts to complete the process.',
              ),
              FaqItem(
                question: 'Is my account information secure?',
                answer:
                    'Yes, we take security very seriously. Your account information is encrypted and stored securely on our servers. We also regularly update our security protocols to ensure your data remains safe.',
              ),
              FaqItem(
                question: 'How do I delete my account?',
                answer:
                    'To delete your account, please contact our customer support team. They will guide you through the process and ensure that your account is permanently deleted.',
              ),
              FaqItem(
                question: 'How do I change my email address?',
                answer:
                    'You can change your email address by going to the account settings page and selecting the option to edit your email address. Follow the prompts to complete the process.',
              ),
              FaqItem(
                question: 'What should I do if I forget my username?',
                answer:
                    'If you forget your username, you can use the "Forgot Username" option on the login screen. Enter your email address, and we will send you instructions on how to recover your username.',
              ),
              FaqItem(
                question: 'How do I update the app?',
                answer:
                    'You can update the app through the app store on your device. Go to the app store, search for our app, and select the option to update.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.answer,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
