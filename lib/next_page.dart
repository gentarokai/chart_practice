import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final int touchedIndex;

  const NextPage({super.key, required this.touchedIndex});

  @override
  Widget build(BuildContext context) {
    List<String> titles = ["フルーツ", "ナッツ", "シロップ", "フラワー"];
    return Scaffold(
      appBar: AppBar(title: const Text("Next Page")),
      body: Center(
        child: Text(
          touchedIndex >= 0 && touchedIndex < titles.length
              ? "Selected: ${titles[touchedIndex]}"
              : "No selection",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
