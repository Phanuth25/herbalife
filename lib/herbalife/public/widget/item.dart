import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';

class ImageCounterCard extends StatefulWidget {
  final String imagepath;
  final String product;
  final String price;
  final String point;


  // Constructor allows you to pass data into the widget
  const ImageCounterCard({
    super.key,
    required this.imagepath,
    required this.product,
    required this.price,
    required this.point,
  });

  @override
  State<ImageCounterCard> createState() => _ImageCounterCardState();
}

class _ImageCounterCardState extends State<ImageCounterCard> {
  bool isSelected = false;
  int counter = 1;

  @override
  void initState() {
    super.initState();
    // Initialize the counter with the passed-in value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isSelected = !isSelected),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? kPrimaryGreen
                : Colors.white,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(widget.imagepath,height: 140,),
            Text(
              widget.product,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "KhmerFont",
                color: kPrimaryGreen,wordSpacing: 5
              ),
            ),
            Text(
              "\$ ${widget.price}",
              style: kTitleStyle,
            ),
            Text(
              "% ${widget.point}",
              style: kTitleStyle,
            ),
            if (isSelected) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      counter--;
                    }),
                    icon: Icon(
                      Icons.remove,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                  Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      counter++;
                    }),
                    icon: Icon(
                      Icons.add,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
