import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // Replace with your backend API endpoint
  final String userDetailsUrl = "http://192.168.8.156:8080/api/auth/user-details";
  final String baseUrl = 'http://192.168.8.156:8080/api/customers';
  Future<Map<String, String>?> getUserDetails(String email) async {
    final response = await http.get(
      Uri.parse('$userDetailsUrl?email=$email'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        "userId": data['userId'].toString(),
        'firstName': data['firstName'],
        'lastName': data['lastName'],
        'phoneNumber': data['phone'],
        'address': data['address'],
      };
    } else {
      print('Failed to fetch user details: ${response.body}');
      return null;
    }
  }
  Future<bool> createUser(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to create user: ${response.body}');
      return false;
    }
  }
}