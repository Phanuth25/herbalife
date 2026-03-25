import 'package:flutter/material.dart';
import 'package:project2/youtube/image_counter_card.dart';
import 'package:project2/l10n/app_localizations.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: "panel",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          "assets/images/bg.jpg",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 230,
                        ),
                      ),
                    ),
                    Text(
                      "Flutter Home",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25,
                        letterSpacing: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white12,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Basic Layout",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            Text(
                              "The description of this",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ),
                ),
              ),
              GridView.extent(
                shrinkWrap: true,
                maxCrossAxisExtent: 198,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  ImageCounterCard(imagepath: "assets/images/herb1.png",product: AppLocalizations.of(context)!.product),
                  ImageCounterCard(imagepath: "assets/images/herb1.png",product: "Herb"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
