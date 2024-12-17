import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Replace with your backend API endpoint
  final String apiUrl = "http://192.168.8.156:8080/api/auth/login";

  Future<bool> login(String email, String accountNumber, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'accountNumber': accountNumber,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      String responseData = response.body;
      if (responseData == "Login successful") {
        return true;
      } else {
        print('Login failed: $responseData');
        return false;
      }
    } else {
      // Handle error response
      print('Login failed: ${response.body}');
      return false;
    }
  }
}