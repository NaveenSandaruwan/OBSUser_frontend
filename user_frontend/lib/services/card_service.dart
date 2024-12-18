import 'dart:convert';
import 'package:http/http.dart' as http;

class CardService {
  final String baseUrl = 'http://192.168.8.156:8080/api/cards';

  Future<List<Map<String, dynamic>>> getCards(String accountNumber) async {
    final url = Uri.parse('$baseUrl/account/$accountNumber');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((card) => card as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load card details');
    }
  }
}