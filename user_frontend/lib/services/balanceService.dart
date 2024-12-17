import 'dart:convert';
import 'package:http/http.dart' as http;

class BalanceService {
  final String baseUrl = 'http://192.168.8.156:8080/api/accounts';

  Future<String> getBalance(String accountNumber) async {
    final url = Uri.parse('$baseUrl/balance?accountNumber=$accountNumber');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data.toString(); // Convert the balance to a string
    } else {
      throw Exception('Failed to load balance');
    }
  }
}