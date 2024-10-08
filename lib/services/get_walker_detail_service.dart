import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:woodog_app/models/walker_model.dart';
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';

Future<ApiResponse> getWalkerDetails(int id) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$walkersUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = Walker.fromJson(jsonDecode(response.body));
        break;
      case 401:
        apiResponse.message = unauthorized;
        break;
      case 404:
        apiResponse.message = 'Promeneur non trouvé';
        break;
      default:
        apiResponse.message = somethingWentWrong;
        break;
    }
  } catch (e) {
    print('printttttttt wakler detail error ${e}');
    apiResponse.message = serverError;
  }

  return apiResponse;
}
