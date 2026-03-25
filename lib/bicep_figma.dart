import 'package:flutter/material.dart';
import 'package:project2/Home_figma.dart';
import 'package:project2/profile_figma.dart';
import 'package:project2/youtube.dart';

void main() => runApp(MaterialApp(home: Bicep()));

class Bicep extends StatelessWidget {
  const Bicep({super.key});

  final String myVideoId = "ez3YoWf62Eg";
  final String myVideoId2 = "XhIsIcjIbCw";
  final String myVideoId3 = "eYrAV7rnol0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
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
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        title: Text(
                          '.Profile',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
        // ADDED: Back button in the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 170),
          // Reduced padding so it fits with the back button
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: SizedBox(
                  height: 70,
                  width: 350,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      "There are 3 exercise to target Bicep :",
                      style: TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      "1. Standing Barbell Curl",
                      style: TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/gym3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.red,
                      ),
                      label: const Text('Watch Tutorial'),
                      onPressed: () {
                        launchYouTube(myVideoId);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      "2. Incline Dumbbell Curls",
                      style: TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/gym4.jpg"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.red,
                      ),
                      label: const Text('Watch Tutorial'),
                      onPressed: () {
                        launchYouTube(myVideoId2);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      "3.Machine bicep curls",
                      style: TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/gym5.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.play_circle_fill,
                        color: Colors.red,
                      ),
                      label: const Text('Watch Tutorial'),
                      onPressed: () {
                        launchYouTube(myVideoId3);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Home button at bottom for convenience
            const SizedBox(height: 30),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
              icon: Icon(Icons.home_rounded, color: Colors.orange, size: 40),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
