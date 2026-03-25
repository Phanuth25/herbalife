import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController Controller = TextEditingController();
  TextEditingController Controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: Controller,
              decoration: InputDecoration(hint: Text("First Name"),border: OutlineInputBorder()),
              onEditingComplete: () {
                setState(() {});
              },
            ),
            SizedBox(height: 10,),
            TextField(
              controller: Controller2,
              decoration: InputDecoration(hint: Text("Last Name"),border: OutlineInputBorder()),
              onEditingComplete: () {
                setState(() {});
              },
            ),
            Text(Controller.text+' '+Controller2.text),

          ],
        ),
      ),
    );
  }
}
