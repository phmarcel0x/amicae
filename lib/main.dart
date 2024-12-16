import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: LandingPage(),
  ));
}

//Landing Page
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/ae_short_black.png"),
                  radius: 100,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("Welcome to AMICAE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black
                  )
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                            (context) => const LoginPage()
                          )
                        );
                      },
                      child: const Text("LOG IN"),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                            (context) => const SignupPage()
                          )
                        );
                      },
                      child: const Text("SIGN UP")
                    )
                  ),
                ],
              )
            ],
          )
        ),
      )
    );
  }
}

//Login Page
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                child: Text("Log in to AMICAE",
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
                      foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:
                        (context) => const HomePage()
                      )
                    );
                  },
                  child: const Text("LOG IN"),
                )
              ),
            ],
          )
        ),
      )
    );
  }
}

//Signup Page
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
                      foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:
                        (context) => const HomePage()
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

//Home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text("home page goes here")
              ),
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
            ],
          ),
        )
      )
    );
  }
}