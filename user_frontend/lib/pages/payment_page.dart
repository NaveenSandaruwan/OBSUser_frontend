import 'package:flutter/material.dart';
import 'package:user_frontend/widgets/PaymentOptionButton.dart';
import 'payment_detail_page.dart'; // Import the PaymentDetailPage

class PaymentPage extends StatelessWidget {
  final int userId;
  final String name;
  final String email;
  final String accountNumber;

  const PaymentPage({
    super.key,
    required this.userId,
    required this.name,
    required this.email,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'PAYMENT TYPES',
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Payment Option Buttons
            PaymentOptionButton(
              title: 'Telecommunication',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentDetailPage(
                      paymentType: 'Telecommunication',
                      userId: userId,
                      accountNumber: accountNumber,
                    ),
                  ),
                );
              },
            ),
            PaymentOptionButton(
              title: 'Water',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentDetailPage(
                      paymentType: 'Water',
                      userId: userId,
                      accountNumber: accountNumber,
                    ),
                  ),
                );
              },
            ),
            PaymentOptionButton(
              title: 'Current',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentDetailPage(
                      paymentType: 'Electricity',
                      userId: userId,
                      accountNumber: accountNumber,
                    ),
                  ),
                );
              },
            ),
            PaymentOptionButton(
              title: 'Insurance',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentDetailPage(
                      paymentType: 'Insurance',
                      userId: userId,
                      accountNumber: accountNumber,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}