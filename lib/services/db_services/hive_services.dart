import 'package:hive/hive.dart';
import 'package:hivetest/services/db_services/hive_db.dart';
import 'package:hivetest/utils/globals.dart';

class HiveService {
  static Future<void> saveUserData(List<UserModel> userData) async {
    final box = await Hive.openBox<UserModel>(Gloabals.userBoxKey);
    await box.clear();
    for (var user in userData) {
      await box.add(user);
    }
  }

  static Future<List<UserModel>> getUserData() async {
    final box = await Hive.openBox<UserModel>(Gloabals.userBoxKey);
    final List<UserModel> userData = box.values.toList();
    return userData;
  }
}
