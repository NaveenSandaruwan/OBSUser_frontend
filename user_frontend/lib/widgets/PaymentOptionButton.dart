import 'package:flutter/material.dart';

class PaymentOptionButton extends StatelessWidget {
  final String title;

  const PaymentOptionButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FractionallySizedBox(
        widthFactor: 0.95, // 95% of the display width
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement payment option functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}