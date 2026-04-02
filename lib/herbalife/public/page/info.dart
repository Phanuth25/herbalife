import 'package:flutter/material.dart';
import 'package:project2/herbalife/public/constants/Constants.dart';
import 'package:project2/herbalife/public/page/product.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  final String? userId; // Store the ID passed to constructor
  const Info(this.userId, {super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  void initState() {
    super.initState();
    // Fetch profile data after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<Authprovider>().getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    // context.watch ensures the widget rebuilds when data changes in the provider
    final authProvider = context.watch<Authprovider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Herbalife",
          style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryGreen,fontSize: 25),
        ),

        actions: [Text("Point: ${authProvider.ispoint}pt, Discount: ${authProvider.isdiscount}%", style: kTitleStyle.copyWith(fontSize: 18))],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: authProvider.isLoading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset('assets/images/herb2.png', width: 400),
                      const SizedBox(height: 20),
                      // 1. DYNAMIC NAME
                      Text(
                        'Hello, ${authProvider.isname}!',
                        style: kTitleStyle
                            .copyWith(fontSize: 25)
                            .copyWith(fontFamily: 'KhmerFont'),
                      ),
                      // Display error message if any
                      if (authProvider.message != null &&
                          authProvider.message!.isNotEmpty &&
                          authProvider.message != "Profile loaded")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            authProvider.message!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 5),

                      Text(
                        'Address',
                        style: kTitleStyle.copyWith(fontSize: 25),
                      ),
                      Container(
                        width: 300,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          authProvider.isaddress,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text('Phone', style: kTitleStyle.copyWith(fontSize: 25)),
                      Container(
                        width: 300,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // 2. ADDED PHONE DATA
                        child: Text(
                          "0${authProvider.isphone}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text('Email', style: kTitleStyle.copyWith(fontSize: 25)),
                      Container(
                        width: 300,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // 3. ADDED EMAIL DATA
                        child: Text(
                          authProvider.isemail,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),

                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(300, 60),
                          backgroundColor: kPrimaryGreen,
                          shape: const RoundedRectangleBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Product(authProvider.userId)),
                          );
                        },
                        child: Text(
                          'Continue',
                          style: kTitleStyle.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
