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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Calculating totals inside build so they refresh if the list changes
    double totalPrice = CartModel.items.fold(
      0,
      (sum, item) => sum + item.price,
    );
    double totalPoint = CartModel.items.fold(
      0,
      (sum, item) => sum + item.point,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            child: const Image(image: AssetImage("assets/images/Herblogo.png")),
            onTap: () {

            },
          ),
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Align(
          //   alignment: Alignment.center,
          //   child: Text(
          //     "Please remember all of your",
          //     style: kTitleStyle.copyWith(fontSize: 27),
          //   ),
          // ),
          // Text(
          //   "purchases are the price after discounted",
          //   style: kTitleStyle,
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: CartModel.items.length,
              itemBuilder: (context, index) {
                final item = CartModel.items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Container(
                    color: Colors.grey[300],
                    child: ListTile(
                      leading: Image.asset(item.image, width: 50),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: 'KhmerFont',
                          color: kPrimaryGreen,
                        ),
                      ),
                      subtitle: Text(
                        "\$${item.price.toStringAsFixed(2)}",
                        style: kTitleStyle.copyWith(fontSize: 22),
                      ),
                      trailing: Text("${item.point} pts", style: kTitleStyle),
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Summary Section ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 60.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left Side: Point and Amount Rows
                  Expanded(
                    child: Column(
                      children: [
                        // Total Point Row
                        Row(
                          children: [
                            Container(
                              color: Colors.deepOrangeAccent,
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Total point:",
                                style: kTitleStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.orange,
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "%${totalPoint.toString()}",
                                  style: kTitleStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4), // Small gap between rows
                        // Total Amount Row
                        Row(
                          children: [
                            Container(
                              width: 160,
                              // Fixed width to align with top row label if needed
                              color: Colors.deepOrangeAccent,
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Total amount:",
                                style: kTitleStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.orange,
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "\$${totalPrice.toStringAsFixed(2)}",
                                  style: kTitleStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Right Side: The kPrimaryGreen Container
                  Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: kPrimaryGreen,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
