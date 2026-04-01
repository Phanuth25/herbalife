import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Authprovider extends ChangeNotifier {
  String? message;
  bool isLoading = false;
  final String _accounturl = "http://10.0.2.2:3000/api";
  String? userToken;
  String? userId; // Store as String
  String? id; // Store as String

  //
  Future<void> login(String userid, String password) async {
    message = "";
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("$_accounturl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userid': userid, 'password': password}),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        message = data['message'];
        userToken = data['token'];
        // Safely convert to String in case they are integers in the DB
        userId = data['userid']?.toString();
        id = data['id']?.toString();
      } else {
        message = data['message'];
        userToken = null;
      }
    } catch (e) {
      message = "Login failed: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //
  String? email;
  String? phone;
  String? address;
  String? name;
  String? point;
  String? position;
  String? discount;

  String get isemail => email ?? "No data";

  String get isphone => phone ?? "No data";

  String get isaddress => address ?? "No data";

  String get isname => name ?? "No data";
  String get ispoint => point ?? "No data";
  String get isposition => position ?? "No data";
  String get isdiscount => discount ?? "No data";

  //

  //
  Future<void> getProfile() async {
    if (id == null) return; // Prevent calling if we don't have an ID
    message = "";
    isLoading = true; // Set loading state first
    notifyListeners(); // Notify listeners that loading has started
    try {
      final response = await http.get(
        Uri.parse("$_accounturl/profile/$id"),
        headers: {
          'Authorization': 'Bearer $userToken', // Standard practice
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        // Note: backend profile.js might not send 'message', so we check for it or set a default
        message = data['message'] ?? "Profile loaded";
        email = data['email'];
        phone = data['phone']?.toString();
        address = data['address'];
        name = data['name'];
        point = data['point']?.toString();
        position = data['position']?.toString();
        discount = data['discount']?.toString();
      } else {
        message = data['message'] ?? "Failed to load profile";
      }
    } catch (e) {
      message = "Network error $e";
    } finally {
      isLoading = false; // Set loading to false when done
      notifyListeners(); // Final notification to update UI with data or error
    }
  }
}
