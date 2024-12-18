import 'package:flutter/material.dart';
import 'package:user_frontend/widgets/displayFeild.dart';

class AccountPage extends StatelessWidget {
  final String name;
  final String email;
  final String accountNumber;
  final String userId;
  final String phoneNumber;
  final String address;

  const AccountPage({
    super.key,
    required this.name,
    required this.email,
    required this.accountNumber,
    required this.userId,
    required this.phoneNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text('ACCOUNT'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(Icons.settings),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Icon
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Display Fields
            DisplayField(label: 'YOUR NAME', value: name),
            DisplayField(label: 'ACCOUNT NUMBER', value: accountNumber),
            DisplayField(label: 'EMAIL', value: email),
            DisplayField(label: 'PHONE NUMBER', value: phoneNumber),
            DisplayField(label: 'YOUR ADDRESS', value: address),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

