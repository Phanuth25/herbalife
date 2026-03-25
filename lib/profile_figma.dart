import "package:flutter/material.dart";
import "package:project2/Home_figma.dart";
import "package:project2/auth_provider.dart";
import 'package:provider/provider.dart';

void main() => runApp(Profile());

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _LoginState();
}

class _LoginState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/gym.png"),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Container(
              height: 450,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/gym2.png",
                      width: 200,
                      height: 200,
                    ),
                    Text(
                      authProvider.currentEmail,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 50,
                        width: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: () {
                            if (authProvider.currentType == "Blue") {
                              return Colors.blue;
                            } else if (authProvider.currentType == "Platinum") {
                              return Colors.white70;
                            } else if (authProvider.currentType == "Platinum Plus"){
                              return Colors.amberAccent;
                            }
                          }(),
                        ),
                        child: Center(
                          child: () {
                            if (authProvider.currentType == "Blue") {
                              return Text("Blue");
                            } else if (authProvider.currentType == "Platinum") {
                              return Text("Platinum");
                            } else if(authProvider.currentType == "Platinum Plus"){
                              return Text("Platinum Plus");
                            }
                          }(),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                      icon: Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                        size: 40,
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
