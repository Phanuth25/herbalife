import 'package:flutter/material.dart';
import 'package:project2/l10n/app_localizations.dart';

class ImageCounterCard extends StatefulWidget {
  final String imagepath;
  final String product;

  // Constructor allows you to pass data into the widget
  const ImageCounterCard({
    super.key,
    required this.imagepath,
    required this.product,
  });

  @override
  State<ImageCounterCard> createState() => _ImageCounterCardState();
}

class _ImageCounterCardState extends State<ImageCounterCard> {
  bool _isSelected = false;
  int _counter = 1;

  @override
  void initState() {
    super.initState();
    // Initialize the counter with the passed-in value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isSelected = !_isSelected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isSelected ? Colors.blue : Colors.grey.shade300,
            width: 3,
          ),
          // boxShadow: [
          //   if (_isSelected)
          //     BoxShadow(
          //       color: Colors.blue.withOpacity(0.2),
          //       blurRadius: 10,
          //       offset: const Offset(0, 4),
          //     )
          // ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(widget.imagepath, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product,
              style:
                  (AppLocalizations.of(context)!.product != "Mint & Chocolate")
                  ? TextStyle(
                      fontFamily: 'KhmerFont',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    )
                  : TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
            ),
            if (_isSelected) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => setState(() {
                      _counter--;
                    }),
                    icon: Icon(Icons.remove, color: Colors.red, size: 20),
                  ),
                  Text(
                    '$_counter',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      _counter++;
                    }),
                    icon: Icon(Icons.add, color: Colors.red, size: 20),
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
