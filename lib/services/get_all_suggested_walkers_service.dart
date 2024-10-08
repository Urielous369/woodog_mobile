import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';

Future<ApiResponse> getAllSuggestedWalkers() async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(suggestedWalkerUrl), headers: {
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);

        apiResponse.data;
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