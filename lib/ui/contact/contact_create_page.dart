import 'package:flutter/material.dart';

class ContactCreatePage extends StatelessWidget {
  final String title;

  ContactCreatePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(child: Text('')),
    );
  }
}
