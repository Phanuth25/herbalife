import 'package:flutter/material.dart';
import 'package:project2/auth_provider.dart';
import 'package:project2/youtube/home.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: "panel",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          "assets/images/bg.jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 230,
                        ),
                      ),
                    ),
                    Text(
                      "Register Page",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        letterSpacing: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // CHANGE: Removed SizedBox with height 10 which was hiding the card content
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white12,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            Text(
                              "Your identity",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true, // CHANGE: Added obscureText for password security
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          // CHANGE: Correctly await the register call so the code waits for the server response
                          await auth.register(
                            emailController.text,
                            passwordController.text,
                          );

                          // CHANGE: Check if widget is still mounted before navigating or showing snacks
                          if (!mounted) return;

                          // Note: In your AuthProvider, register sets 'message' but not 'userToken'
                          // Usually you'd check if registration was successful via a flag or message
                          if (auth.ismessage.contains("success") || auth.isemail) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(auth.ismessage)));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(auth.ismessage)));
                          }
                        },
                  style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.teal),
                  ),
                  child: auth.isLoading
                      ? CircularProgressIndicator(color: Colors.white) // CHANGE: Show loading spinner
                      : Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
