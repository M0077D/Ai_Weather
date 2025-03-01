import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task1/features/auth/presentation/Screens/sign_in_page.dart';
import 'package:task1/features/auth/presentation/controller/providers.dart';
import 'package:task1/features/auth/presentation/widgets/auth_text_field.dart';

class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController =
      TextEditingController(); // Add username controller

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "SIGN UP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "CREATE AN ACCOUNT TO MAKE SDFDSF",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              /// Name Input Field
              AuthTextField(
                controller: _usernameController,
                labelText: 'Username',
              ),
              const SizedBox(height: 15),

              /// Email Input Field
              AuthTextField(
                controller: _emailController,
                labelText: 'Email',
              ),
              const SizedBox(height: 15),

              /// Password Input Field
              AuthTextField(
                controller: _passwordController,
                labelText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),

              /// Page Indicator

              const SizedBox(height: 30),

              /// Next Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  try {
                    await authProvider.signUp(
                      _emailController.text,
                      _passwordController.text,
                      _usernameController.text, // Pass username
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signed up successfully')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to sign up: $e')),
                    );
                  }
                },
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Already Have an Account? Sign In
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
                child: const Text(
                  "HAVE AN ACCOUNT?",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
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
