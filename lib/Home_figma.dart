import "package:flutter/material.dart";
import 'package:project2/feature_figma.dart';
import 'package:project2/profile_figma.dart';
import 'package:provider/provider.dart';
import 'package:project2/auth_provider.dart';
void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: Homepage(),
  ),
);

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.orange,
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 200),
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: Text(
                            '.Home',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Builder(
                          builder: (context) {
                            return ListTile(
                              title: Text(
                                '.Profile',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(left: 230),
            child: Text(
              "Techno",
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 30, top: 120),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'TO',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'OUR',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'GYM',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'APP',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      fontStyle: FontStyle.italic,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => feature()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.fromLTRB(180, 0, 0, 0),
                          child: Text(
                            "click here to start",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
