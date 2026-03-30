import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/data/notifier.dart';

class ImageCounterCard extends StatefulWidget {
  final String imagepath;
  final String product;
  final String price;
  final String point;
  final VoidCallback onSelect; // 👈 add this
  final VoidCallback onSelect2;

  // Constructor allows you to pass data into the widget
  const ImageCounterCard({
    super.key,
    required this.imagepath,
    required this.product,
    required this.price,
    required this.point,
    required this.onSelect,
    required this.onSelect2, // 👈 add this
  });

  @override
  State<ImageCounterCard> createState() => _ImageCounterCardState();
}

class _ImageCounterCardState extends State<ImageCounterCard> {
  bool isSelected = false;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the counter with the passed-in value
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: selectedPoint,
          builder: (context, value, child) {
            return GestureDetector(
              onTap: () => setState(() {
                isSelected = !isSelected;
                if (isSelected) {
                  // Selecting: add 1 item
                  counter++;
                  selectedIndex.value++;
                  selectedPoint.value =
                      selectedPoint.value + double.parse(widget.point);
                } else {
                  // Deselecting: remove all counted items
                  selectedIndex.value = selectedIndex.value - counter;
                  selectedPoint.value =
                      selectedPoint.value -
                      (double.parse(widget.point) * counter);
                  counter = 0;
                }
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? kPrimaryGreen : Colors.white,
                    width: 3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(widget.imagepath, height: 140),
                    Text(
                      widget.product,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "KhmerFont",
                        color: kPrimaryGreen,
                        wordSpacing: 5,
                      ),
                    ),
                    Text("\$ ${widget.price}", style: kTitleStyle),
                    Text("% ${widget.point}", style: kTitleStyle),
                    if (isSelected) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => setState(() {
                              widget.onSelect2();
                              if (counter > 0) {
                                counter--;
                                if (selectedIndex.value > 0) {
                                  selectedIndex.value--;
                                  selectedPoint.value =
                                      selectedPoint.value -
                                      double.parse(widget.point);
                                }
                              }
                            }),
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          Text(
                            '$counter',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            onPressed: () => setState(() {
                              widget.onSelect();
                              counter++;
                              selectedIndex.value++;
                              selectedPoint.value =
                                  selectedPoint.value +
                                  double.parse(widget.point);
                            }),
                            icon: const Icon(
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
          },
        );
      },
    );
  }
}
