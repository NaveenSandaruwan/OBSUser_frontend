import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // Replace with your backend API endpoint
  final String userDetailsUrl = "http://192.168.8.156:8080/api/auth/user-details";

  Future<Map<String, String>?> getUserDetails(String email) async {
    final response = await http.get(
      Uri.parse('$userDetailsUrl?email=$email'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'firstName': data['firstName'],
        'lastName': data['lastName'],
      };
    } else {
      print('Failed to fetch user details: ${response.body}');
      return null;
    }
  }
}