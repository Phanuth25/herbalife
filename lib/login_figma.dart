import "package:flutter/material.dart";
import 'package:project2/Home_figma.dart';
import 'package:project2/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final String type1;

  const Login({super.key, required this.type1});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  String? selectedValue;
  final List<String> options = ['Blue', 'Platinum', 'Platinum Plus'];

  @override
  void initState() {
    super.initState();
    if (options.contains(widget.type1)) {
      selectedValue = widget.type1;
    } else {
      selectedValue = options[0];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/gym.png"),
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              height: 700,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 10),
                      child: SizedBox(
                        width: 300,
                        height: 80, // Reduced from 150
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          controller: emailController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Email or Phone number",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                width: 10,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 300,
                      height: 80, // Reduced from 150
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              width: 10,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 300,
                        height: 80, // Reduced from 150
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          controller: typeController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Credit card number",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                width: 10,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent, // Background color
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          // Removes the default tiny bottom line
                          child: DropdownButton<String>(
                            value: selectedValue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            dropdownColor: Colors.blueAccent,
                            // Matches the container
                            items: options.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() => selectedValue = newValue);
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ElevatedButton(
                        onPressed: () async {
                          // 1. Call the logic in the AuthProvider
                          final auth = await Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).loginToExpress(
                            emailController.text,
                            passwordController.text,
                            selectedValue ?? "",
                          );

                          // 2. After it finishes, check if we are logged in
                          if (Provider.of<AuthProvider>(
                            context,
                            listen: false,
                          ).isLoggedIn) {
                            // Success
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Login Successfully"),
                              ),
                            );
                            // ! Go back to the purchase screen
                            Navigator.pop(context);
                          } else {
                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Login Failed")),
                            );
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Builder(
                        builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Homepage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.home_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
