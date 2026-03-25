import 'package:flutter/material.dart';
import 'package:project2/Home_figma.dart';
import 'package:provider/provider.dart';
import 'package:project2/auth_provider.dart';
import 'package:project2/login_figma.dart';
// void main() => runApp(const MaterialApp(home: Member()));

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  int value = 0;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   backgroundColor: Colors.orange,
      //   child: Column(
      //     children: [
      //       Builder(
      //         builder: (context) {
      //           return Expanded(
      //             child: ListView(
      //               padding: const EdgeInsets.only(top: 200),
      //               children: [
      //                 ListTile(
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(builder: (context) => homepage()),
      //                     );
      //                   },
      //                   title: Text(
      //                     '.Home',
      //                     style: const TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 25,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 50),
      //                 ListTile(
      //                   title: Text(
      //                     '.Profile',
      //                     style: const TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 25,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 50),
      //                 ListTile(
      //                   title: Text(
      //                     '.Log out',
      //                     style: const TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 25,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      // appBar: AppBar(
      //   title: Padding(
      //     padding: EdgeInsets.only(left: 230),
      //     child: Text(
      //       "Techno",
      //       style: const TextStyle(
      //         color: Colors.orange,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 25,
      //       ),
      //     ),
      //   ),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/gym.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            SizedBox(height: 150),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size(350, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final auth = Provider.of<AuthProvider>(context, listen: false);
                // 2. After it finishes, check if we are logged in
                if (!auth.isLoggedIn) {
                  // Success! Go back to the purchase screen
                  final snackbar = ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Oop! You have to login first before purchase",
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  await snackbar.closed;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(type1: 'Blue'),
                    ),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("You already purchased this membership"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Text(
                    "Blue \$21.99",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Get access to one local gym and machines",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                fixedSize: Size(350, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final auth = Provider.of<AuthProvider>(context, listen: false);
                // 2. After it finishes, check if we are logged in
                if (!auth.isLoggedIn) {
                  final snackbar = ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Oop! You have to login first before purchase",
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  await snackbar.closed;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(type1: 'Platinum'),
                    ),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("You already purchased this membership"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Text(
                    "Platinum \$23.99",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Get access to all of TECHNO gym and machines",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                fixedSize: Size(350, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final auth = Provider.of<AuthProvider>(context, listen: false);
                // 2. After it finishes, check if we are logged in
                if (!auth.isLoggedIn) {
                  // Success
                  final snackbar = ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Oop! You have to login first before purchase",
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  await snackbar.closed;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(type1: 'Platinum Plus'),
                    ),
                  );
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("You already purchased this membership"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Text(
                    "Platinum Plus \$32.99",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Get access to all of TECHNO gym, machines, steam , locker\nboxing and more..",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            SizedBox(
              height: 220,
              width: 220,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset("assets/images/membership2.png"),
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
              MaterialPageRoute(builder: (context) => Member()),
            );
          }
        },
      ),
    );
  }
}
