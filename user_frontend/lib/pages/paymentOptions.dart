import 'package:flutter/material.dart';
import 'package:user_frontend/widgets/PaymentOptionButton.dart';
import 'package:user_frontend/services/balanceService.dart'; // Import the BalanceService
import 'card.dart'; // Import the CardPage
import 'accountPage.dart'; // Import the AccountPage
import 'exchange_page.dart'; // Import the ExchangePage
import 'payment_page.dart'; // Import the PaymentPage
import 'transaction_page.dart'; // Import the TransactionPage

class PaymentOptionScreen extends StatefulWidget {
  final String name;
  final String email;
  final String balance;
  final String accountNumber;
  final String userId;
  final String phoneNumber;
  final String address;

  const PaymentOptionScreen({
    super.key,
    required this.name,
    required this.email,
    required this.balance,
    required this.accountNumber,
    required this.userId,
    required this.phoneNumber,
    required this.address,
  });

  @override
  _PaymentOptionScreenState createState() => _PaymentOptionScreenState();
}

class _PaymentOptionScreenState extends State<PaymentOptionScreen> {
  late String balance;
  final BalanceService _balanceService = BalanceService();

  @override
  void initState() {
    super.initState();
    balance = widget.balance;
    _refreshBalance();
  }

  Future<void> _refreshBalance() async {
    try {
      String newBalance = await _balanceService.getBalance(widget.accountNumber);
      setState(() {
        balance = newBalance;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch balance: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            children: [
              // Blue Top Section
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.47, // 40% of screen height
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder for Profile Image
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your asset
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Account Number Section
                    const Text(
                      'ACCOUNT NUMBER',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.accountNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Balance Section
                    const Text(
                      'BALANCE',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$$balance',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Profile Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the AccountPage with user information
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountPage(
                              name: widget.name,
                              email: widget.email,
                              accountNumber: widget.accountNumber,
                              userId: widget.userId,
                              phoneNumber: widget.phoneNumber,
                              address: widget.address,
                            ),
                          ),
                        ).then((_) => _refreshBalance());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Add some space between the top section and the buttons
              const SizedBox(height: 20),
              // Payment Options Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Payment Option Buttons
                    PaymentOptionButton(
                      title: 'Transaction',
                      onPressed: () {
                        // Navigate to the TransactionPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionPage(
                              accountNumber: widget.accountNumber,
                            ),
                          ),
                        ).then((_) => _refreshBalance());
                      },
                    ),
                    PaymentOptionButton(
                      title: 'Payment',
                      onPressed: () {
                        // Navigate to the PaymentPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(
                              userId: int.parse(widget.userId),
                              name: widget.name,
                              email: widget.email,
                              accountNumber: widget.accountNumber,
                            ),
                          ),
                        ).then((_) => _refreshBalance());
                      },
                    ),
                    PaymentOptionButton(
                      title: 'Exchange',
                      onPressed: () {
                        // Navigate to the ExchangePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExchangePage(),
                          ),
                        ).then((_) => _refreshBalance());
                      },
                    ),
                    PaymentOptionButton(
                      title: 'Card',
                      onPressed: () {
                        // Navigate to the CardPage with user information
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardPage(
                              userId: int.parse(widget.userId),
                              name: widget.name,
                              email: widget.email,
                              accountNumber: widget.accountNumber,
                            ),
                          ),
                        ).then((_) => _refreshBalance());
                      },
                    ),
                    const SizedBox(height: 20),
                    // More Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement more options functionality
                        },
                        child: const Text(
                          'more>>',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}