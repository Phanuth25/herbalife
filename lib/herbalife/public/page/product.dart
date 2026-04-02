import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/data/notifier.dart';
import 'package:project2/herbalife/public/model/product_model.dart';
import 'package:project2/herbalife/public/widget/welcome.dart';
import 'package:project2/herbalife/public/widget/item.dart';
import 'package:project2/herbalife/public/page/cart.dart';

class Product extends StatefulWidget {
  const Product(String? id, {super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> with TickerProviderStateMixin {
  bool isSelected = false;
  String searchQuery = "";

  final GlobalKey cartKey = GlobalKey();
  // In your _ProductState
  List<GlobalKey> itemKeys = List.generate(
    products.length,
        (index) => GlobalKey(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) => product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kPrimaryGreen, width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: kPrimaryGreen, width: 3.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cart()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 65, // Increased height to avoid internal overflow
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0), // Reduced top padding
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Stack(
                            key: cartKey,
                            children: [
                              const Positioned(
                                child: Icon(
                                  Icons.card_travel_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              Positioned(
                                left: 20,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 13.0,
                                  child: ValueListenableBuilder(
                                    valueListenable: selectedIndex,
                                    builder: (context, value, child) {
                                      return Text(
                                        '${selectedIndex.value}',
                                        style: kTitleStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ValueListenableBuilder(
                          valueListenable: selectedPoint,
                          builder: (context, value, child) {
                            return Text(
                              "Point : %${selectedPoint.value.toStringAsFixed(2)}",
                              style: kTitleStyle.copyWith(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.52, // Decreased ratio to provide more height for the cards
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  // Using index % itemKeys.length as a fallback if filtering results in fewer items
                  final keyIndex = index % itemKeys.length;
                  return ImageCounterCard(
                    key: itemKeys[keyIndex],
                    id: product.id.toString(),
                    imagepath: product.image,
                    product: product.name,
                    price: product.price.toString(),
                    point: product.point.toString(),
                    onSelect: () => flyToCart(itemKeys[keyIndex], product.image),
                    onSelect2: () => flyFromCart(itemKeys[keyIndex], product.image),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void flyToCart(GlobalKey itemKey, String imagePath) {
    if (itemKey.currentContext == null) return;
    final itemBox = itemKey.currentContext!.findRenderObject() as RenderBox;
    final itemPos = itemBox.localToGlobal(Offset.zero);

    if (cartKey.currentContext == null) return;
    final cartBox = cartKey.currentContext!.findRenderObject() as RenderBox;
    final cartPos = cartBox.localToGlobal(Offset.zero);

    final animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // position animation: item → cart
    final posAnimation = Tween<Offset>(
      begin: itemPos,
      end: cartPos,
    ).animate(CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    ));

    // size animation: big → small
    final sizeAnimation = Tween<double>(
      begin: 80,
      end: 10,
    ).animate(CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    ));

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: animController,
        builder: (context, child) {
          return Positioned(
            left: posAnimation.value.dx,
            top: posAnimation.value.dy,
            child: Image.asset(
              imagePath,
              width: sizeAnimation.value,
              height: sizeAnimation.value,
            ),
          );
        },
      ),
    );

    Overlay.of(context).insert(entry);

    animController.forward().then((_) {
      entry.remove();
      animController.dispose();
    });
  }
  void flyFromCart(GlobalKey itemKey, String imagePath) {
    if (itemKey.currentContext == null) return;
    final itemBox = itemKey.currentContext!.findRenderObject() as RenderBox;
    final itemPos = itemBox.localToGlobal(Offset.zero);

    if (cartKey.currentContext == null) return;
    final cartBox = cartKey.currentContext!.findRenderObject() as RenderBox;
    final cartPos = cartBox.localToGlobal(Offset.zero);

    final animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // position animation: cart → item
    final posAnimation = Tween<Offset>(
      begin: cartPos,
      end: itemPos,
    ).animate(CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    ));

    // size animation: big → small
    final sizeAnimation = Tween<double>(
      begin: 80,
      end: 10,
    ).animate(CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    ));

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: animController,
        builder: (context, child) {
          return Positioned(
            left: posAnimation.value.dx,
            top: posAnimation.value.dy,
            child: Image.asset(
              imagePath,
              width: sizeAnimation.value,
              height: sizeAnimation.value,
            ),
          );
        },
      ),
    );

    Overlay.of(context).insert(entry);

    animController.forward().then((_) {
      entry.remove();
      animController.dispose();
    });
  }
}
