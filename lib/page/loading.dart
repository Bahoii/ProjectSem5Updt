import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:quizz/page/mainmenu.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _isLoadingComplete = false;
  bool _showError = false;

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 4));
    // throw Exception("Simulated error"); // Uncomment ini untuk simulasi error
    setState(() {
      _isLoadingComplete = true;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadData().then((_) {
        if (_isLoadingComplete) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainMenu()),
            );
          });
        }
      }).catchError((error) {
        setState(() {
          _showError = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'UPP SKILL',
                    textStyle: const TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: _isLoadingComplete
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 50.0,
                      key: UniqueKey(),
                    )
                  : CircularProgressIndicator(
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      key: UniqueKey(),
                    ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                _isLoadingComplete ? 'Loading Complete!' : 'Loading...',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_showError)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _showError ? 50 : 0,
                height: _showError ? 50 : 0,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            const SizedBox(height: 10),
            if (_showError)
              const Text(
                'There is a problem. Please try again later.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
