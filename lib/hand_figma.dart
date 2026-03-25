import 'package:flutter/material.dart';
import 'package:project2/Home_figma.dart';
import 'package:project2/profile_figma.dart';
import 'package:project2/bicep_figma.dart';

void main() => runApp(MaterialApp(home: Hand()));

class Hand extends StatelessWidget {
  const Hand({super.key});

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "Select your muscle target :",
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
            padding: EdgeInsets.only(top: 70),
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bicep()),
                    );
                  },
                  child: Text(
                    "Bicep",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: Size(350, 80),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Tricep",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(350, 80),
                backgroundColor: Colors.orange,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Shoulder",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: Size(350, 80),
                backgroundColor: Colors.orange,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.orange,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            label: "Back",
          ),
          NavigationDestination(
            icon: Icon(Icons.home, color: Colors.white),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            label: "Next",
          ),
        ],
        selectedIndex: 0,
        onDestinationSelected: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Hand()),
            );
          }
        },
      ),
    );
  }
}
