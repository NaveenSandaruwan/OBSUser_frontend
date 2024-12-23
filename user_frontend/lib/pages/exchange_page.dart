import 'package:flutter/material.dart';
import 'package:user_frontend/services/exchange_service.dart'; // Import the ExchangeService

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  final ExchangeService _exchangeService = ExchangeService();
  late Future<Map<String, dynamic>> _exchangeRatesFuture;
  String? _fromCurrency;
  String? _toCurrency;
  double? _inputValue;
  double? _convertedValue;

  @override
  void initState() {
    super.initState();
    _exchangeRatesFuture = _exchangeService.getExchangeRates();
  }

  void _convertCurrency(Map<String, dynamic> exchangeRates) {
    if (_fromCurrency != null && _toCurrency != null && _inputValue != null) {
      double fromRate = exchangeRates[_fromCurrency].toDouble();
      double toRate = exchangeRates[_toCurrency];
      setState(() {
        _convertedValue = (_inputValue! / fromRate) * toRate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'CURRENCY EXCHANGE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [Icon(Icons.settings)],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _exchangeRatesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exchange rates found.'));
          } else {
            final exchangeRates = snapshot.data!;
            final currencies = exchangeRates.keys.toList();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'From Currency:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _fromCurrency,
                    hint: const Text('Select Currency'),
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _fromCurrency = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'To Currency:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _toCurrency,
                    hint: const Text('Select Currency'),
                    items: currencies.map((String currency) {
                      return DropdownMenuItem<String>(
                        value: currency,
                        child: Text(currency),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _toCurrency = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Amount:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter amount',
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _inputValue = double.tryParse(value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity, // Make the button take the full width
                    child: ElevatedButton(
                      onPressed: () {
                        _convertCurrency(exchangeRates);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'CONVERT',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_convertedValue != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Converted Value:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '$_convertedValue $_toCurrency',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}