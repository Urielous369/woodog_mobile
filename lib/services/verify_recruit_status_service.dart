import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:woodog_app/services/user_service.dart';
import 'package:woodog_app/utils/constants/api_constants.dart';

Future<bool> checkIfIsRecruited(int walkerId) async {
  bool isRecruited = false;

  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$walkersUrl/$walkerId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final walkerData = jsonDecode(response.body);
      isRecruited = walkerData['isRecruited'] ?? false;
    }
  } catch (e) {
    print('Erreur lors de la vérification du statut de recrutement: $e');
  }

  return isRecruited;
}
