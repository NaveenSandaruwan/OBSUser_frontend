import 'dart:convert';
import 'package:http/http.dart' as http;

class TransactionService {
  final String baseUrl = 'http://192.168.8.156:8080/api/transactions';

  Future<String> createTransaction(Map<String, dynamic> transactionData) async {
    final url = Uri.parse(baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(transactionData),
    );

    if (response.statusCode == 200) {
      return 'success';
    } else if (response.statusCode == 400 && response.body.contains('Insufficient funds')) {
      return 'insufficient_funds';
    } else {
      return 'error';
    }
  }
}