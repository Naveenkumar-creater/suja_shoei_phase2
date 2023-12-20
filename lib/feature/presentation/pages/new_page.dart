import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Details'),
      ),
      body: const Center(
        child: Text('You have scanned the correct barcode!'),
      ),
    );
  }
}
