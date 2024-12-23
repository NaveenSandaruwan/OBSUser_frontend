import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  final String baseUrl = 'http://192.168.8.156:8080/api/bill-payments';

  Future<String> payElectricityBill(Map<String, dynamic> paymentData) async {
    final url = Uri.parse('$baseUrl/electricity');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(paymentData),
    );

    if (response.statusCode == 200) {
      return 'success';
    } else if (response.statusCode == 400 && response.body.contains('Insufficient funds')) {
      return 'insufficient_funds';
    } else {
      return 'error';
    }
  }

  Future<String> payWaterBill(Map<String, dynamic> paymentData) async {
    final url = Uri.parse('$baseUrl/water');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(paymentData),
    );

    if (response.statusCode == 200) {
      return 'success';
    } else if (response.statusCode == 400 && response.body.contains('Insufficient funds')) {
      return 'insufficient_funds';
    } else {
      return 'error';
    }
  }

  Future<String> payTelecommunicationBill(Map<String, dynamic> paymentData) async {
    final url = Uri.parse('$baseUrl/telecommunication');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(paymentData),
    );

    if (response.statusCode == 200) {
      return 'success';
    } else if (response.statusCode == 400 && response.body.contains('Insufficient funds')) {
      return 'insufficient_funds';
    } else {
      return 'error';
    }
  }

  Future<String> payInsuranceBill(Map<String, dynamic> paymentData) async {
    final url = Uri.parse('$baseUrl/insurance');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(paymentData),
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