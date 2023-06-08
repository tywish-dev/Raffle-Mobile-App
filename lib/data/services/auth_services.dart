import 'dart:convert';
import '/data/models/user_model.dart';
import '/data/services/user_services.dart';
import '/data/models/user_auth.dart';
import '/data/constants/constants.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Uri getAuthUrl(String process) =>
      Uri.parse("$baseAuthUrl$process?key=$authApiKey");

  Future<User?> signUp(UserAuth userAuth, User user) async {
    http.Response response = await http.post(
      getAuthUrl("signUp"),
      body: userAuth.toJson(),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = jsonDecode(response.body);
      user.localId = data["localId"];
      UserServices().postUser(user, user.localId!);
      return user;
    }
    return null;
  }

  Future<bool> signInBoolean(UserAuth userAuth, User user) async {
    http.Response response = await http.post(
      getAuthUrl("signInWithPassword"),
      body: userAuth.toJson(),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var data = jsonDecode(response.body);
      user.localId = data["localId"];
      return data["registered"];
    }
    return false;
  }
}
