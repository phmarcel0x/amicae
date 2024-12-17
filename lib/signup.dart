import 'package:flutter/material.dart';
import "nav_bar.dart";

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.black,
          )
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  }
                )
              ),
              const Padding(
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/ae_short_white.png"),
                  radius: 50,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Sign up for AMICAE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black
                  )
                )
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                )
              ),
              const Padding(
                padding: EdgeInsets.all(5),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                )
              ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:
                        (context) => const NavBar()
                      )
                    );
                  },
                  child: const Text("SIGN UP"),
                )
              ),
            ],
          )
        ),
      )
    );
  }
}
