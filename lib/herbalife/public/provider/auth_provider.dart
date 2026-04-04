import 'dart:io';

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
  File? image;
  String get isUserid => userId ?? "No id";

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

  int? invoiceId;

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
        id = data['id']?.toString();
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

  //
  Future<void> postitem(int userid, int product, int quantity) async {
    message = "";
    try {
      final response = await http.post(
        Uri.parse("$_accounturl/postitem"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userid': userid,
          'product': product,
          'quantity': quantity,
        }),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        message = data['message'];
        invoiceId = data['invoiceId']; // Optional: get the ID of the new row
      } else {
        message = data['message'];
      }
    } catch (e) {
      message = "Network failed: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteitem(int invoiceId) async {
    message = "";
    try {
      final response = await http.delete(
        Uri.parse("$_accounturl/deleteitem/$invoiceId"),
        headers: {'Content-Type': 'application/json'},
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        message = data['message'];
      } else {
        message = data['message'];
      }
    } catch (e) {
      message = "Network failed: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //

  Future<void> register(
    String name,
    String address,
    String phone,
    String email,
    File image,
  ) async {
    message = "";
    isLoading = true;
    notifyListeners();
    try {
      var request = http.MultipartRequest('POST', Uri.parse("$_accounturl/register"));
      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['phone'] = phone;
      request.fields['email'] = email;

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Backend returns "Registered successfully"
        message = "successfully"; 
        userId = data['userid']?.toString();
      } else {
        message = data['error'] ?? data['message'] ?? "Registration failed";
      }
    } catch (e) {
      message = "Network failed: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //
  Future<void> register2(int userid, int password, int userids) async {
    message = "";
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse("$_accounturl/register2"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userid': userid,
          'password': password,
          'userids': userids,
        }),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        message = data['message'];
        userId = data['userids']?.toString();
      } else {
        message = data['message'];
      }
    } catch (e) {
      message = "Network failed";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
