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

  @override
  Widget build(BuildContext context) {
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
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
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
        ),
      ),
    );
  }
}
