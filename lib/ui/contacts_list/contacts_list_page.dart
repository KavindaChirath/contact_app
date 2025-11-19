import 'package:flutter/material.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return Center(
            child: Text('Contact Test', style: TextStyle(fontSize: 20)),
          );
        },
      ),
    );
  }
}
