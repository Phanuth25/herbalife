import 'package:flutter/material.dart';
import 'package:project2/data/notifier.dart';
import 'package:project2/youtube/home.dart';

// import 'package:lottie/lottie.dart';
import 'package:project2/youtube/login.dart';
import 'package:project2/youtube/register.dart';
import 'package:project2/l10n/app_localizations.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.3,
                      child: TweenAnimationBuilder(
                        duration: Duration(seconds: 4),
                        tween: Tween<Offset>(begin: const Offset(0, 1000), end: const Offset(0, 0)),
                        child: Image.asset("assets/images/hotair.png"),
                        builder: (context, Offset offset, child) {
                          return Transform.translate(
                            offset: offset,
                            child: child,
                          );
                        },
                      ),
                    ),
                    // Lottie.asset(
                    //  'assets/lotties/Christmas Tree Animation - 1699891737968.json',
                    // ),
                    SizedBox(height: 40),
                    FittedBox(
                      child: Text(
                        "Phanuth App",
                        style: TextStyle(
                          letterSpacing: 15,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ValueListenableBuilder(
                        valueListenable: token,
                        builder: (context, value, child) {
                          if (token.value.isEmpty) {
                            return LayoutBuilder(
                              builder: (context, BoxConstraints constraints) {
                                print(
                                  "Current Logical Width: ${constraints.maxWidth}",
                                );
                                return FractionallySizedBox(
                                  widthFactor: constraints.maxWidth > 600
                                      ? 0.7
                                      : 1,
                                  //600 ? 0.7 : 1
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ),
                                      );
                                    },

                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50.0),
                                      backgroundColor: Colors.teal,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.getStarted,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                return FractionallySizedBox(
                                  widthFactor: constraints.maxWidth > 600
                                      ? 0.7
                                      : 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Home(),
                                        ),
                                      );
                                    },

                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50.0),
                                      backgroundColor: Colors.teal,
                                    ),
                                    child: Text(
                                      "Home",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return FractionallySizedBox(
                            widthFactor: constraints.maxWidth > 600 ? 0.7 : 1,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Register(),
                                  ),
                                );
                              },

                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50.0),
                                backgroundColor: Colors.teal,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.register,
                                style:
                                    (AppLocalizations.of(context)!.register !=
                                        "Register")
                                    ? TextStyle(
                                        fontFamily: 'KhmerFont',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      )
                                    : TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                              ),
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
