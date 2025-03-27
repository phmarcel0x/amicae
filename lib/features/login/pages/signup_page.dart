// ignore_for_file: unused_import

import 'package:amicae/features/nav%20bar/nav_bar.dart';
import 'package:flutter/material.dart';
import "landing_page.dart";
import '../../authentication/services/auth_service.dart';
import '../../user_account_set_up/screens/start_creating_profile.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _authService = AuthService();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Sign-up logic with validation
  Future<void> _signUpUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      try {
        final user = await _authService.signUp(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign Up Successful! Redirecting...')),
          );

          Navigator.pushReplacement(
            context,
            // MaterialPageRoute(builder: (context) => const NavBar()),
            MaterialPageRoute(builder: (context) => const StartScreen()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                      const LandingPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/ae_short_white.png'),
                radius: 50,
              ),
              const Text(
                "Sign up for AMICAE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // First Name Field
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _firstNameController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),
              ),

              // Last Name Field
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _lastNameController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Last Name",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
                ),
              ),

              // Email Field
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
              ),

              // Password Field
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
                ),
              ),

              // Confirm Password Field
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),

                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: const TextStyle(color: Colors.black),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: _signUpUser,
                  child: const Text("SIGN UP"),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
