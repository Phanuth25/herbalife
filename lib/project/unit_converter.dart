import 'package:flutter/material.dart';
import 'package:project2/project/textstyle.dart';
import 'package:project2/project/beginner/personal business card app.dart';
class Converter extends StatefulWidget {
  const Converter({super.key});

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final TextEditingController textController = TextEditingController();
  int m = 1000;
  int? result;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Textfield(textController: textController),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 230, 0),
                child: result == null
                    ? Text(
                        "Result: ",
                        style: Textstyle.normaltext.copyWith(
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                      )
                    : Text(
                        "Result:  $result",
                        style: Textstyle.normaltext.copyWith(
                          color: Colors.orange,
                          fontSize: 20,
                        ),
                      ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    result = int.parse(textController.text) * m;
                  });
                },
                child: Text("Convert"),
                style: ElevatedButtonStyle.styleFrom,
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            NavigationDestination(
              icon: Icon(Icons.calculate),
              label: "Converter",
            ),
          ],
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Beginner()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Converter()),
              );
            }
          },
          selectedIndex: index,
        ),
      ),
    );
  }
}
