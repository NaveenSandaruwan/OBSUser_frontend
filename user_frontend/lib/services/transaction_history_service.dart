import 'dart:convert';
import 'package:http/http.dart' as http;

class TransactionHistoryService {
  final String baseUrl = 'http://192.168.8.156:8080/api/transactions';

  Future<List<Map<String, dynamic>>> getTransactions(String accountNumber) async {
    final url = Uri.parse('$baseUrl?accountNumber=$accountNumber');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((transaction) => transaction as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}