import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/data/notifier.dart';
import 'package:project2/herbalife/public/model/cart_model.dart';
import 'package:project2/herbalife/public/model/product_model.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ImageCounterCard extends StatefulWidget {
  final String imagepath;
  final String product;
  final String price;
  final String point;
  final VoidCallback onSelect;
  final VoidCallback onSelect2;

  const ImageCounterCard({
    super.key,
    required this.imagepath,
    required this.product,
    required this.price,
    required this.point,
    required this.onSelect,
    required this.onSelect2,
  });

  @override
  State<ImageCounterCard> createState() => _ImageCounterCardState();
}

class _ImageCounterCardState extends State<ImageCounterCard> {
  bool isSelected = false;
  int counter = 0;

  /// Returns the effective price after applying discount (if any).
  /// When discount is 0 or null, returns the original price unchanged.
  double _getEffectivePrice(int discount) {
    final double originalPrice = double.parse(widget.price);
    if (discount > 0) {
      return originalPrice * (1 - discount / 100);
    }
    return originalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authprovider>();

    // Parse discount safely — handles "25.0" style strings
    int discount = 0;
    if (authProvider.discount != null) {
      discount = double.tryParse(authProvider.discount!)?.toInt() ?? 0;
    }

    // Single source of truth for price used in both UI and cart
    final double effectivePrice = _getEffectivePrice(discount);

    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: selectedPoint,
          builder: (context, value, child) {
            return GestureDetector(
              onTap: () => setState(() {
                isSelected = !isSelected;
                if (!isSelected) {
                  // Deselecting: remove all counted items from totals
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

                    // Always show effectivePrice — equals original when no discount
                    Text(
                      "\$ ${effectivePrice.toStringAsFixed(2)}",
                      style: kTitleStyle,
                    ),

                    Text("% ${widget.point}", style: kTitleStyle),

                    // Show discount badge only when a discount is applied
                    if (discount > 0)
                      Text(
                        "Discount: $discount%",
                        style: kTitleStyle.copyWith(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),

                    // Show original price crossed out when discounted
                    if (discount > 0)
                      Text(
                        "\$ ${double.parse(widget.price).toStringAsFixed(2)}",
                        style: kTitleStyle.copyWith(
                          fontSize: 11,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

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
                                  CartModel.items.removeLast();
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
                              // Use effectivePrice so cart always has the correct price
                              CartModel.add(
                                Product(
                                  name: widget.product,
                                  price: effectivePrice,
                                  image: widget.imagepath,
                                  point: double.parse(widget.point),
                                ),
                              );
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
