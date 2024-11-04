import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/provider/providerUser.dart';

class forgotPasswordPage extends StatefulWidget {
  const forgotPasswordPage({super.key});

  @override
  _forgotPasswordState createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State {
  TextEditingController new_password = TextEditingController(text: '');
  TextEditingController confirm_new_password = TextEditingController(text: '');
  bool _showConfirmPassError = false;
  bool _obscureNewText = true;
  bool _obscureConfirmText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: new_password,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureNewText = !_obscureNewText;
                      });
                    },
                    icon: Icon(
                      _obscureNewText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Fill your new password",
                ),
                obscureText: _obscureNewText,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                  controller: confirm_new_password,
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmText = !_obscureConfirmText;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: "Fill again your new password",
                    errorText: _showConfirmPassError
                        ? "Password not same with the new password"
                        : null,
                  ),
                  obscureText: _obscureConfirmText,
                  onChanged: (text) {
                    setState(() {
                      _showConfirmPassError = false;
                    });
                  }),
              const SizedBox(height: 60.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      final profileProvider =
                          Provider.of<ProfileProvider>(context, listen: false);
                      bool sameNewPassword =
                          new_password.text == confirm_new_password.text;

                      if (sameNewPassword) {
                        profileProvider.forgotPassword(0, new_password.text);
                        setState(() {});
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      } else {
                        setState(() {
                          _showConfirmPassError = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Change Password',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
