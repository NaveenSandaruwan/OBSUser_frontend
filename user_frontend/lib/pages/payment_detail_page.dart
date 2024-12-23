import 'package:flutter/material.dart';
import 'package:user_frontend/services/payment_service.dart'; // Import the PaymentService

class PaymentDetailPage extends StatefulWidget {
  final String paymentType;
  final int userId;
  final String accountNumber;

  const PaymentDetailPage({
    super.key,
    required this.paymentType,
    required this.userId,
    required this.accountNumber,
  });

  @override
  _PaymentDetailPageState createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  final PaymentService _paymentService = PaymentService();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _accountLabel;

  @override
  void initState() {
    super.initState();
    switch (widget.paymentType) {
      case 'Electricity':
        _accountLabel = 'Electricity Account No';
        break;
      case 'Water':
        _accountLabel = 'Water Account No';
        break;
      case 'Telecommunication':
        _accountLabel = 'Telecommunication No';
        break;
      case 'Insurance':
        _accountLabel = 'Insurance No';
        break;
    }
  }

  void _submitPayment() async {
    final accountNo = _accountController.text;
    final amount = double.tryParse(_amountController.text);

    if (accountNo.isEmpty || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid account number and amount')),
      );
      return;
    }

    final paymentData = {
      'userId': widget.userId,
      'accountNumber': widget.accountNumber,
      'amount': amount,
    };

    String result;
    switch (widget.paymentType) {
      case 'Electricity':
        paymentData['electricityAccountNo'] = accountNo;
        result = await _paymentService.payElectricityBill(paymentData);
        break;
      case 'Water':
        paymentData['waterAccountNo'] = accountNo;
        result = await _paymentService.payWaterBill(paymentData);
        break;
      case 'Telecommunication':
        paymentData['telNo'] = accountNo;
        result = await _paymentService.payTelecommunicationBill(paymentData);
        break;
      case 'Insurance':
        paymentData['insuranceNo'] = accountNo;
        result = await _paymentService.payInsuranceBill(paymentData);
        break;
      default:
        result = 'error';
    }

    if (result == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful')),
      );
      Navigator.pop(context);
    } else if (result == 'insufficient_funds') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Insufficient balance')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          '${widget.paymentType} Payment',
          style: const TextStyle(fontWeight: FontWeight.bold),
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
            Text(
              'Enter ${widget.paymentType} Payment Details',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _accountController,
              decoration: InputDecoration(
                labelText: _accountLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'PAY',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}