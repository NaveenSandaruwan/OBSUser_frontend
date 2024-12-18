import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_frontend/services/auth_service.dart'; // Import the AuthService
import 'package:user_frontend/services/user_service.dart'; // Import the UserService
import 'package:user_frontend/services/balanceService.dart'; // Import the BalanceService
import 'signup.dart'; // Import the SignUpScreen
import 'paymentOptions.dart'; // Import the PaymentOptionScreen
import 'card.dart'; // Import the CardPage
import 'package:user_frontend/widgets/textFeild.dart'; // Import the CustomTextField

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  final BalanceService _balanceService = BalanceService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text;
    String accountNumber = _accountNumberController.text;
    String password = _passwordController.text;

    bool success = await _authService.login(email, accountNumber, password);
    if (success) {
      // Fetch user details
      final userDetails = await _userService.getUserDetails(email);
      if (userDetails != null) {
        String name = '${userDetails['firstName']} ${userDetails['lastName']}';
        int userId = int.parse(userDetails['userId'].toString());
        // Fetch user balance
        try {
          String balance = await _balanceService.getBalance(accountNumber);

          // Navigate to the PaymentOptionScreen with user information
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentOptionScreen(
              name: name,
              email: email,
              balance: balance,
              accountNumber: accountNumber,
              userId: userId.toString(),
              ),
            ),
            );
        } catch (e) {
          // Show an error message if balance could not be fetched
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch balance: $e')),
          );
        }
      } else {
        // Show an error message if user details could not be fetched
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch user details')),
        );
      }
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to blue
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // This will shift the page upward when the keyboard appears
      body: SafeArea(
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Column(
            children: [
              // Blue Top Half
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35, // 35% of screen height
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'WELCOME!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Placeholder for Bank Image
                    Image.asset(
                      'assets/bank.jpg', // Replace with your asset
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              // White Bottom Half
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    // Account Number Field
                    CustomTextField(
                      controller: _accountNumberController,
                      labelText: 'Account Number',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Forgot Password
                    TextButton(
                      onPressed: () {
                        // TODO: Implement Forgot Password functionality
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New to Bank Apps?',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the SignUpScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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