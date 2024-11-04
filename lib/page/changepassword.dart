import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/LoginPage.dart';
import 'package:quizz/page/provider/providerUser.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State {
  TextEditingController old_password = TextEditingController(text: "");
  TextEditingController new_password = TextEditingController(text: '');
  TextEditingController confirm_new_password = TextEditingController(text: '');
  bool _showNewPassError = false;
  bool _showOldPassError = false;
  bool _obscureOldText = true;
  bool _obscureNewText = true;
  bool _obscureConfirmText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
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
                controller: old_password,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureOldText = !_obscureOldText;
                      });
                    },
                    icon: Icon(
                      _obscureOldText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: "Fill your old password",
                  errorText: _showOldPassError ? "Wrong password" : null,
                ),
                obscureText: _obscureOldText,
                onChanged: (text) {
                  setState(() {
                    _showOldPassError = false;
                  });
                },
              ),
              const SizedBox(height: 16.0),
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
                    errorText: _showNewPassError
                        ? "Password not same with the new password"
                        : null,
                  ),
                  obscureText: _obscureConfirmText,
                  onChanged: (text) {
                    setState(() {
                      _showNewPassError = false;
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
                      bool validatePass = old_password.text ==
                          profileProvider.account[0].password;
                      if (validatePass) {
                        if (sameNewPassword) {
                          profileProvider.changePassword(
                              0, old_password.text, new_password.text);
                          setState(() {
                            _showNewPassError = true;
                          });
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        } else {
                          setState(() {
                            _showNewPassError = true;
                          });
                        }
                      } else {
                        setState(() {
                          _showNewPassError = true;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
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
