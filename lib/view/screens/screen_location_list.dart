import 'package:flutter/material.dart';

class ScreenLocationList extends StatelessWidget {
  const ScreenLocationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      body: const Center(
        child: Text('location list'),
      ),
    );
  }
}
