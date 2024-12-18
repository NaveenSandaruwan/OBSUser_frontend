import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  final int userId;
  final String name;
  final String email;
  final String accountNumber;

  const CardPage({
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
        title: Text(
          'ADD CARD',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios),
        actions: [Icon(Icons.settings)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card Image
              Center(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(Icons.credit_card,
                        size: 100, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Name Field
              Text("YOUR NAME",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              TextField(
                decoration: InputDecoration(
                  hintText: name,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Card Number Field
              Text("CARD NUMBER",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "4507 8754 3851 7860",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Expiry Date
              Text("EXPIRED DATE",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Day Dropdown
                  DropdownButton<String>(
                    value: '1',
                    items: List.generate(31, (index) => (index + 1).toString())
                        .map((String day) {
                      return DropdownMenuItem<String>(
                        value: day,
                        child: Text(day),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),

                  // Month Dropdown
                  DropdownButton<String>(
                    value: 'January',
                    items: [
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December'
                    ].map((String month) {
                      return DropdownMenuItem<String>(
                        value: month,
                        child: Text(month),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),

                  // Year Dropdown
                  DropdownButton<String>(
                    value: '2024',
                    items: List.generate(10, (index) => (2024 + index).toString())
                        .map((String year) {
                      return DropdownMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Password Field
              Text("PASSWORD",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "*************",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Phone Number Field
              Text("PHONE NUMBER",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Row(
                children: [
                  // Country Code Dropdown
                  DropdownButton<String>(
                    value: '+92',
                    items: ['+92', '+1', '+44', '+91'].map((String code) {
                      return DropdownMenuItem<String>(
                        value: code,
                        child: Text(code),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "1234567890",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Note
              Text(
                "*Note that this app store's your information on cloud and may be used by us.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 20),

              // Link Card Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Link Card Logic Here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    "LINK CARD",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}