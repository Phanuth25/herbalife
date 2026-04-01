import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/widget/welcome.dart';
import 'package:project2/herbalife/public/model/cart_model.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 200,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Image(image: AssetImage("assets/images/Herblogo.png")),
        ),
        actions: [
          Container(
            width: 80,
            height: 40,
            decoration: const BoxDecoration(color: Colors.green),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.question_mark, color: Colors.white, size: 25),
                Text("Help", style: kTitleStyle.copyWith(color: Colors.white)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Welcome()),
              );
            },
            child: Container(
              width: 80,
              height: 40,
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.exit_to_app, color: Colors.white, size: 25),
                  Text(
                    "Exit",
                    style: kTitleStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(
              child: Text(
                "Please remember all of your",
                style: kTitleStyle.copyWith(fontSize: 27),
              ),
            ),
            Text(
              "purchases are the price after discounted",
              style: kTitleStyle,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: CartModel.items.length, // Updated to use CartModel
                itemBuilder: (context, index) {
                  final item = CartModel.items[index];
                  return ListTile(
                    leading: Image.asset(item.image),
                    title: Text(item.name,style: TextStyle(fontFamily: 'KhmerFont'),),
                    subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                    trailing: Text("${item.point} pts", style: kTitleStyle),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
