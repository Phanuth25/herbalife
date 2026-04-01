import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Fetch posts from API
  Future<List<Post>> fetchPostList() async {
    try {
      String url =
          "https://jsonplaceholder.typicode.com/posts?userId=5";
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        List list = json.decode(response.body);
        return list.map((x) => Post.fromMap(x)).toList();
      } else {
        throw Exception(
            "Failed to load data. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // Build the list UI
  Widget _buildListView(List<Post> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[200],
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              items[index].title,
              style: TextStyle(fontSize: 22.0),
            ),
            subtitle: Text(items[index].body),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder Example"),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPostList(),
        builder: (context, snapshot) {

          // Show error if any
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Error: ${snapshot.error.toString()}",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          // When data is loaded
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildListView(snapshot.data!);
            } else {
              return Center(
                child: Text("No Data"),
              );
            }
          }

          // While loading show spinner
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}