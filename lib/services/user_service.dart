import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woodog_app/models/user_model.dart';
import 'package:woodog_app/routers/app_routes.dart';
import 'package:woodog_app/screens/login_page.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';

// login
Future<ApiResponse> login(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    debugPrint("statut du body : ${response.body}");
    debugPrint("statut de la réponse : ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['token'] != null) {
          User user = User(token: jsonResponse['token']);
          apiResponse.data = user;
          apiResponse.message = 'Connecté avec succès';
        } else {
          apiResponse.message = "Erreur : Le token est absent";
        }
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.message = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.message = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.message =
            "Une erreur est survenue (${response.statusCode})";
        break;
    }
  } catch (e) {
    apiResponse.message = serverError;
  }

  return apiResponse;
}

// register user
Future<ApiResponse> registerUser(
    String fullName, String email, String password, BuildContext? context) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse(registerUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': fullName,
        'email': email,
        'password': password,
      }),
    );
    debugPrint('Réponse du body : ${response.body}');

    switch (response.statusCode) {
      case 201:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        apiResponse.message = 'Inscription réussie';
        break;
      case 400:
      case 422:
        final errors = jsonDecode(response.body);
        apiResponse.message =
            'Erreur: ${errors['message'] ?? "Un problème est survenu"}';
        break;
      default:
        apiResponse.message =
            'Une erreur est survenue. Code: ${response.statusCode}, ${response.body}';
        break;
    }
  } catch (e) {
    debugPrint("Erreur capturée : $e");
    apiResponse.message = 'Erreur du serveur ou problème réseau';
  }

  return apiResponse;
}


Future<ApiResponse> getUserProfile() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 401:
        apiResponse.message = unauthorized;
        break;
      default:
        apiResponse.message = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.message = serverError;
  }

  return apiResponse;
}


// get user token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString("token") ?? '';
}

Future<String> getRefreshToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  return pref.getString("refresh_token") ?? '';
}

//get uerId
Future<int> getUserid() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userid') ?? 0;
}

// logout
Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove("token");
}
