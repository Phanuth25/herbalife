import 'package:flutter/material.dart';
import 'package:project2/Home_figma.dart';
import 'package:project2/profile_figma.dart';

class Trainer extends StatelessWidget {
  const Trainer({super.key});

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
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: Colors.white70,
              leading: Icon(
                Icons.person_2_rounded,
                color: Colors.orange,
                size: 50,
              ),
              title: Text(
                "Vorn Viva",
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Tel: 099 123 456 789",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.person_2_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Peak Mi",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 787",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.person_2_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Chorn Sovanareach",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 786",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.person_2_rounded,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Preab Sovath",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 785",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.woman_outlined,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Ork Sokunkanha",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 784",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.woman_outlined,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Selena Gomez",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 783",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.woman_outlined,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Taylor Swift",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 783",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.white70,
                leading: Icon(
                  Icons.woman_outlined,
                  color: Colors.orange,
                  size: 50,
                ),
                title: Text(
                  "Kakada Sophorn",
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Tel: 099 123 456 782",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                trailing: Icon(Icons.handshake, color: Colors.orange, size: 50),
              ),
            ),
          ],
        ),
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
              MaterialPageRoute(builder: (context) => Trainer()),
            );
          }
        },
      ),
    );
  }
}
