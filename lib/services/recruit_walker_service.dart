import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:woodog_app/services/api_response.dart';
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';

Future<ApiResponse> recruitWalker(int walkerId) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    String token = await getToken();
    final response = await http.post(
      Uri.parse('$walkersUrl/$walkerId/recrute'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.message = jsonDecode(response.body)['message'];
        break;
      case 404:
        apiResponse.message = 'Promeneur non trouvé';
        break;
      default:
        apiResponse.message = 'Erreur lors du recrutement';
        break;
    }
  } catch (e) {
    apiResponse.message = 'Erreur du serveur';
  }

  return apiResponse;
}
