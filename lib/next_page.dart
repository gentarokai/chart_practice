import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final int touchedIndex;
  const NextPage({super.key, required this.touchedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('next page'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('$touchedIndexです'),
      ),
    );
  }
}
