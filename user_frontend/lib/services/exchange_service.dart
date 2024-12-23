import 'dart:convert';
import 'package:http/http.dart' as http;

class ExchangeService {
  final String baseUrl = 'https://v6.exchangerate-api.com/v6/50699aee5cd8a1ce4f0d95dc/latest/USD';

  Future<Map<String, dynamic>> getExchangeRates() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['conversion_rates'];
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}