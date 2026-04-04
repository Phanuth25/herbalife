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
  final String id;
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
    required this.id,
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
    final int userId = int.parse(authProvider.id ?? '0');
    final int productId = int.parse(widget.id);
    
    // FIX 1: invoiceId is already an int? in Authprovider. No need to parse it as String.
    final int invoiceId = authProvider.invoiceId ?? 0;

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
                            // FIX 2: Added async to await the deletion process
                            onPressed: () async {
                              if (counter > 0) {
                                widget.onSelect2();
                                setState(() {
                                  counter--;
                                });
                                if (selectedIndex.value > 0) {
                                  selectedIndex.value--;
                                  selectedPoint.value =
                                      selectedPoint.value -
                                      double.parse(widget.point);
                                  
                                  if (CartModel.items.isNotEmpty) {
                                    CartModel.items.removeLast();
                                  }

                                  // FIX 3: Await the server response
                                  await authProvider.deleteitem(invoiceId);
                                  
                                  if (mounted && authProvider.message != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Removed from cart", style: kTitleStyle),
                                      ),
                                    );
                                  }
                                }
                              }
                            },
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
                            // FIX 4: Added async to await the post process
                            onPressed: () async {
                              widget.onSelect();
                              setState(() {
                                counter++;
                              });
                              // Use effectivePrice so cart always has the correct price
                              CartModel.add(
                                Product(
                                  id: int.parse(widget.id),
                                  name: widget.product,
                                  price: effectivePrice,
                                  image: widget.imagepath,
                                  point: double.parse(widget.point),
                                ),
                              );

                              await authProvider.postitem(
                                userId,
                                productId,
                                counter,
                              );

                              if (mounted && authProvider.message != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Added to cart", style: kTitleStyle),
                                  ),
                                );
                              }
                              
                              selectedIndex.value++;
                              selectedPoint.value =
                                  selectedPoint.value +
                                  double.parse(widget.point);
                            },
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
