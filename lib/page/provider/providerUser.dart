import 'dart:typed_data';

import 'package:flutter/material.dart';

class Account {
  int id;
  String name;
  String username;
  Uint8List? profilePicture;
  String email;
  String password;
  String phone;
  String birthDate;
  String status;

  Account({
    this.id = 0,
    this.name = '',
    this.username = '',
    this.profilePicture,
    this.email = '',
    this.password = '',
    this.phone = '',
    this.birthDate = '',
    this.status = 'No status available',
  });
}

class ProfileProvider extends ChangeNotifier {
  List<Account> account = [];

  get profilePicture => null;

  void addAccount(Account a) {
    a.id = account.length;
    account.add(a);
    notifyListeners();
  }

  void changeFullName(int id, String name) {
    for (var a in account) {
      if (a.id == id) {
        a.name = name;
        break;
      }
    }
    notifyListeners();
  }

  void changeUsername(int id, String username) {
    for (var a in account) {
      if (a.id == id) {
        a.username = username;
        break;
      }
    }
    notifyListeners();
  }

  void changePhone(int id, String phone) {
    for (var a in account) {
      if (a.id == id) {
        a.phone = phone;
        break;
      }
    }
    notifyListeners();
  }

  void changeBirthDate(int id, String birthDate) {
    for (var a in account) {
      if (a.id == id) {
        a.birthDate = birthDate;
        break;
      }
    }
    notifyListeners();
  }

  void changeStatus(int id, String status) {
    for (var a in account) {
      if (a.id == id) {
        a.status = status;
        break;
      }
    }
    notifyListeners();
  }

  void changeProfilePicture(int index, Uint8List imageBytes) {
    if (account.isNotEmpty) {
      account[index].profilePicture = imageBytes;
    }
    notifyListeners();
  }

  void changePassword(int id, String oldPass, String newPass) {
    for (var a in account) {
      if (a.id == id) {
        if (a.password == oldPass) {
          a.password = newPass;
          break;
        }
      }
    }
    notifyListeners();
  }

  void forgotPassword(int id, String newPass) {
    for (var a in account) {
      if (a.id == id) {
        a.password = newPass;
        break;
      }
    }
    notifyListeners();
  }
}
