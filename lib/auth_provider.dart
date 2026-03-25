import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the package
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'; // To handle JSON

//ChangeNotifier is something to announce that thing has change in front end(UI)
class AuthProvider extends ChangeNotifier {
  String? userToken;
  String? userEmail;
  String? userType;
  bool isLoading = false;

  num? temp;

  num? wind;

  String? message;
  String? accountemail;

  String get ismessage => message ?? "";

  bool get isemail => accountemail != null;

  bool isloggin = false;

  bool get isloggedin => userToken != null;

  bool get isLoggedIn => userToken != null;

  String get currentEmail => userEmail ?? "";

  String get currentType => userType ?? "";

  String get tempdata => temp?.toString() ?? "";

  String get winddata => wind?.toString() ?? "";
  final String _accounturl = "http://10.0.2.2:3000/api/accounts";

  Future<void> register(String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("$_accounturl/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        message = data['message'];
        notifyListeners();
      } else {
        message = "Registration failed";
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Error connecting to server: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> savelocal(String token, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    await prefs.setString('user_email', email);
  }

  Future<void> login(String email, String password) async {
    message = "";
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("$_accounturl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        message = data['message'];
        userToken = data['token'];
        userEmail = data['userEmail'];
        savelocal(userToken!, userEmail!);
        notifyListeners(); // Important: Notify UI that userToken is no longer null
      } else {
        message = data['message'];
        userToken = null;
        notifyListeners();
      }
    } catch (e) {
      message = "Login failed";
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // This is the function that talks to Express
  Future<void> loginToExpress(
    String email,
    String password,
    String type,
  ) async {
    // 1. Your Express URL (Use 10.0.2.2 if using Android Emulator)
    final url = Uri.parse('http://10.0.2.2:3000/api/register');

    try {
      // 2. Send the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          // Use jsonEncode here!
          'email': email,
          'password': password,
          'type': type,
        }),
      );

      if (response.statusCode == 200) {
        // 3. Convert the response text to a Map (JSON)
        final data = json.decode(response.body);

        // 4. Update the token with the one from Express/MySQL
        userToken = data['token'];
        userEmail = data['email'];
        userType = data['type'];

        // 5. Refresh the UI
        notifyListeners();
      } else {
        print("Login failed: ${response.body}");
      }
    } catch (e) {
      print("Error connecting to server: $e");
    }
  }

  Future<void> weatherapi() async {
    isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse('http://10.0.2.2:3000/api0/get/weather');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        temp = data['temp'];
        wind = data['wind'];
        notifyListeners();
      }
    } catch (e) {
      print("Error connecting to server: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // Hide loading spinner and show data
    }
  }
}
