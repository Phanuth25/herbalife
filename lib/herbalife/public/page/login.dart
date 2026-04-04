import 'package:flutter/material.dart';
import 'package:project2/herbalife/l10n/app_localizations.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/page/info.dart';
import 'package:project2/herbalife/public/page/register.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authProvider = Provider.of<Authprovider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Herbalife",
          style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryGreen),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Herblogo.png", width: 300),
              const SizedBox(height: 20),
              Container(
                width: 320,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: kPrimaryGreen, width: 5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        l10n.login,
                        style: l10n.login == "Login"
                            ? kTitleStyle.copyWith(fontSize: 35)
                            : const TextStyle(
                                fontFamily: 'KhmerFont',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryGreen,
                              ),
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      // ID Field
                      SizedBox(
                        width: 280,
                        child: TextField(
                          controller: _idController,
                          style: l10n.id == "Enter your ID"
                              ? kTitleStyle
                              : const TextStyle(
                                  fontFamily: 'KhmerFont',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                          decoration: kTextFieldDecoration(hintText: l10n.id),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      SizedBox(
                        width: 280,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: kTextFieldDecoration(
                            hintText: l10n.password,
                          ),
                          style: l10n.password == "Enter your Password"
                              ? kTitleStyle
                              : const TextStyle(
                                  fontFamily: 'KhmerFont',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Login Button
                      ElevatedButton(
                        style: kButtonStyle,
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                await authProvider.login(
                                  _idController.text,
                                  _passwordController.text,
                                );
                                if (authProvider.message != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(authProvider.message!),
                                    ),
                                  );
                                  if (authProvider.message ==
                                      "Login successful") {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Info(authProvider.userId)),
                                    );
                                  }
                                }
                              },
                        child: authProvider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                l10n.enter,
                                style: l10n.enter == "Enter"
                                    ? kTitleStyle.copyWith(color: Colors.white)
                                    : const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'KhmerFont',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                              ),
                      ),
                      const SizedBox(height: 20),

                      LoginButton(
                        label: "Register",
                        isLoading: false,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                      ),

                    ],
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
