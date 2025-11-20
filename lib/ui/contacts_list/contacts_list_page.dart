import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final FakeData = Faker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: 30,
        // Runs and builds each item of the list
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              FakeData.person.firstName() + " " + FakeData.person.lastName(),
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
