import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/data/notifier.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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

class _ImageCounterCardState extends State<ImageCounterCard>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;
  int counter = 0;
  final List<int> _invoiceIds = [];
  AnimationController? _selectAnim;
  Animation<double>? _scaleAnim;

  @override
  void initState() {
    super.initState();
    final ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _selectAnim = ctrl;
    _scaleAnim = ctrl;
  }

  @override
  void dispose() {
    _selectAnim?.dispose();
    super.dispose();
  }

  double _getEffectivePrice(int discount) {
    final double originalPrice = double.parse(widget.price);
    if (discount > 0) {
      return originalPrice * (1 - discount / 100);
    }
    return originalPrice;
  }

  void _onTap() async {
    await _selectAnim?.reverse();
    setState(() {
      isSelected = !isSelected;
      if (!isSelected) {
        selectedIndex.value = selectedIndex.value - counter;
        selectedPoint.value = max(
          0,
          selectedPoint.value - (double.parse(widget.point) * counter),
        );
        counter = 0;
      }
    });
    _selectAnim?.forward();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authprovider>();
    final int userId = int.parse(authProvider.id ?? '0');
    final int productId = int.parse(widget.id);

    int discount = 0;
    if (authProvider.discount != null) {
      discount = double.tryParse(authProvider.discount!)?.toInt() ?? 0;
    }

    final double effectivePrice = _getEffectivePrice(discount);

    return ValueListenableBuilder(
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: selectedPoint,
          builder: (context, value, child) {
            return ScaleTransition(
              scale: _scaleAnim ?? const AlwaysStoppedAnimation(1.0),
              child: GestureDetector(
                onTap: _onTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? kPrimaryGreen
                          : const Color(0xFFDCEEDC),
                      width: isSelected ? 2.0 : 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? const Color(0xFF388E3C).withValues(alpha: 0.15)
                            : Colors.black.withValues(alpha: 0.05),
                        blurRadius: isSelected ? 16 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── product image ──────────────────────────────
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 130,
                              color: const Color(0xFFF0F8F0),
                              child: Image.asset(
                                widget.imagepath,
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                            ),
                            // selected badge
                            if (isSelected)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2E7D32),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            // discount badge
                            if (discount > 0)
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade500,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "-$discount%",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // ── product info ───────────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                        child: Column(
                          children: [
                            Text(
                              widget.product,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "KhmerFont",
                                color: Color(0xFF1B5E20),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // price row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${effectivePrice.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1B5E20),
                                  ),
                                ),
                                if (discount > 0) ...[
                                  const SizedBox(width: 5),
                                  Text(
                                    "\$${double.parse(widget.price).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade400,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),

                            // points chip
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F5E9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.stars_rounded,
                                    size: 12,
                                    color: Color(0xFF43A047),
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    "${widget.point} pts",
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ── counter row ────────────────────────────────
                      if (isSelected) ...[
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5FBF5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFDCEEDC),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // minus
                                GestureDetector(
                                  onTap: () async {
                                    if (counter > 0 &&
                                        _invoiceIds.isNotEmpty &&
                                        selectedIndex.value > 0) {
                                      final int invoiceId =
                                          _invoiceIds.last;

                                      await authProvider.deleteitem(invoiceId);

                                      if (authProvider.message ==
                                          "Removed successfully") {
                                        widget.onSelect2();
                                        _invoiceIds.removeLast();
                                        setState(() => counter--);
                                        selectedIndex.value--;
                                        selectedPoint.value =
                                            selectedPoint.value -
                                            double.parse(widget.point);

                                        if (mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .remove_shopping_cart_rounded,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  const Text(
                                                    "Removed from cart",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              backgroundColor:
                                                  Colors.red.shade700,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.remove_rounded,
                                      color: Colors.red.shade400,
                                      size: 18,
                                    ),
                                  ),
                                ),

                                // count
                                Text(
                                  '$counter',
                                  style: const TextStyle(
                                    color: Color(0xFF1B5E20),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),

                                // plus
                                GestureDetector(
                                  onTap: () async {
                                    await authProvider.postitem(
                                      userId,
                                      productId,
                                      counter + 1,
                                    );
                                    if (authProvider.invoiceId != null &&
                                        authProvider.message != null) {
                                      widget.onSelect();
                                      _invoiceIds.add(authProvider.invoiceId!);
                                      setState(() => counter++);
                                      selectedIndex.value++;
                                      selectedPoint.value =
                                          selectedPoint.value +
                                          double.parse(widget.point);

                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add_shopping_cart_rounded,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                const SizedBox(width: 8),
                                                const Text(
                                                  "Added to cart",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: const Color(
                                              0xFF2E7D32,
                                            ),
                                            behavior:
                                                SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F5E9),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add_rounded,
                                      color: Color(0xFF2E7D32),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
