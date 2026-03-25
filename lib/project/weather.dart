import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project2/auth_provider.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  @override
  void initState() {
    super.initState();
    // Use read() here because we just want to trigger the action, not listen yet
    // microtask ensures the context is ready
    Future.microtask(() =>
        context.read<AuthProvider>().weatherapi()
    );
  }

  @override
  Widget build(BuildContext context) {
    // watch() only listens for data changes now
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: auth.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center( // Added Center for better layout
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${auth.tempdata}°C", // Example formatting
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                "Wind: ${auth.winddata}",
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
