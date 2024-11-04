import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz/page/provider/DarkmodeProvider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSoundEnabled = true;
  bool _areNotificationsEnabled = false;
  String _selectedLanguage = 'Indonesia';
  bool _accessPhotos = true;
  bool _accessCamera = false;
  bool _accessContacts = false;
  bool _accessNotifications = false;

  void _toggleSound(bool value) {
    setState(() {
      _isSoundEnabled = value;
    });
  }

  void _toggleNotifications(bool? value) {
    if (value != null) {
      setState(() {
        _areNotificationsEnabled = value;
      });
    }
  }

  void _changeLanguage(String? language) {
    if (language != null) {
      setState(() {
        _selectedLanguage = language;
      });
    }
  }

  void _toggleAccessLocation(bool? value) {
    if (value != null) {
      setState(() {
        _accessPhotos = value;
      });
    }
  }

  void _toggleAccessCamera(bool? value) {
    if (value != null) {
      setState(() {
        _accessCamera = value;
      });
    }
  }

  void _toggleAccessContacts(bool? value) {
    if (value != null) {
      setState(() {
        _accessContacts = value;
      });
    }
  }

  void _toggleAccessNotifications(bool? value) {
    if (value != null) {
      setState(() {
        _accessNotifications = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<darkModeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Toggle',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Sound',
                  ),
                  Switch(
                    value: _isSoundEnabled,
                    onChanged: _toggleSound,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Dark Mode',
                  ),
                  Switch(
                    value: prov.enableDarkMode,
                    onChanged: (val) {
                      prov.setBrightness = val;
                    },
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 27,
              ),
              const Text(
                'Single Check',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Allow notifications'),
                      Radio(
                        value: true,
                        groupValue: _areNotificationsEnabled,
                        onChanged: _toggleNotifications,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Turn Off notifications'),
                      Radio(
                        value: false,
                        groupValue: _areNotificationsEnabled,
                        onChanged: _toggleNotifications,
                      ),
                    ],
                  )
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 27,
              ),
              ListTile(
                title: const Text('Language'),
                subtitle: Text(_selectedLanguage),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Select Language'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: const Text('Indonesia'),
                              onTap: () {
                                _changeLanguage('Indonesia');
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('English'),
                              onTap: () {
                                _changeLanguage('English');
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const Divider(),
              const SizedBox(
                height: 27,
              ),
              const Text(
                'Multiple Check',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              CheckboxListTile(
                title: const Text('Access Location'),
                value: _accessPhotos,
                onChanged: _toggleAccessLocation,
              ),
              CheckboxListTile(
                title: const Text('Access Camera'),
                value: _accessCamera,
                onChanged: _toggleAccessCamera,
              ),
              CheckboxListTile(
                title: const Text('Access Contacts'),
                value: _accessContacts,
                onChanged: _toggleAccessContacts,
              ),
              CheckboxListTile(
                title: const Text('Access Notifications'),
                value: _accessNotifications,
                onChanged: _toggleAccessNotifications,
              ),
              const SizedBox(
                height: 27,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
