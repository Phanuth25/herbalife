import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/model/product_model.dart';
import 'package:project2/herbalife/public/widget/welcome.dart';
import 'package:project2/herbalife/public/widget/item.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool isSelected = false;
  int counter = 1;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) => product.name.contains(searchQuery))
        .toList();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image(image: AssetImage("assets/images/Herblogo.png")),
        ),
        actions: [
          Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(color: Colors.green),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.question_mark, color: Colors.white, size: 25),
                Text("Help", style: kTitleStyle.copyWith(color: Colors.white)),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
            },
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.exit_to_app, color: Colors.white, size: 25),
                  Text(
                    "Help",
                    style: kTitleStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value; // your answer!
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kPrimaryGreen, width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kPrimaryGreen, width: 3.5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.card_travel_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                      CircleAvatar(
                        child: Text(
                          "1",
                          style: kTitleStyle.copyWith(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Text(
                        "Point :",
                        style: kTitleStyle.copyWith(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ImageCounterCard(
                      imagepath: product.image,
                      product: product.name,
                      price: product.price.toString(),
                      point: product.point.toString(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
