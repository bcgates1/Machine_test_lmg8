import 'package:flutter/material.dart';
import 'package:hivetest/services/api_services.dart/api_call.dart';
import 'package:hivetest/services/db_services/hive_db.dart';
import 'package:hivetest/services/db_services/hive_services.dart';

class UserDataProvider extends ChangeNotifier {
  UserDataProvider() {
    initUserData();
  }
  List<UserModel> _userData = [];
  String? _error;
  bool isLoading = true;

  List<UserModel> get userData => _userData;
  String? get error => _error;

  void initUserData({bool isrefresh = false}) async {
    _error = null;
    if (!isrefresh) {
      isLoading = true;
      notifyListeners();
    }
    await HiveService.getUserData().then((value) {
      if (value.isNotEmpty && userData.isEmpty) {
        _userData = value;
      }
    });

    await GetAPi.fetchUserData().then((value) async {
      if (value.isNotEmpty) {
        _userData = value;
        await HiveService.saveUserData(userData);
      }
    }).catchError((error) {
      _error = '$error';
    });

    isLoading = false;
    notifyListeners();
  }
}
