import 'package:flutter/material.dart';
import 'package:project2/auth_provider.dart';
import 'package:project2/data/notifier.dart';
import 'package:project2/youtube/home.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int email = 123;
  int password = 123;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void check() {
    if (email.toString() == emailController.text &&
        password.toString() == passwordController.text) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        actions: [
          ValueListenableBuilder(
            valueListenable: isFav,
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  isFav.value = !isFav.value;
                },
                icon: isFav.value
                    ? const Icon(Icons.favorite, color: Colors.grey)
                    : const Icon(Icons.favorite, color: Colors.red),
              );
            },
          ),
        ],
      ),
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
                    const Text(
                      "Login Page",
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
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white12,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Verify",
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
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.password),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: auth.isLoading
                      ? null
                      : () async {
                          await auth.login(
                            emailController.text,
                            passwordController.text,
                          );

                          if (!mounted) return;

                          if (auth.isloggedin) {
                            token.value = auth.currentEmail;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(auth.ismessage)),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const Home()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(auth.ismessage)),
                            );
                          }
                        },
                  style: const ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Colors.teal),
                  ),
                  child: auth.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Login",
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
