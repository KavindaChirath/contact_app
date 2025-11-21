import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import '../../data/contact.dart';

class ContactListPage extends StatefulWidget {
  final String title;

  ContactListPage({required this.title});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> contacts = List.generate(50, (index) {
    final faker = Faker();
    return Contact(
      name: '${faker.person.firstName()} ${faker.person.lastName()}',
      email: faker.internet.email(),
      phoneNumber: faker.randomGenerator.integer(100000).toString(),
    );
  });

  @override
  Widget build(BuildContext context) {
    final FakeData = Faker();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: 50,
        // Runs and builds each item of the list
        itemBuilder: (context, index) {
          // Get dummy data to look like real contact app home
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].email),
          );
        },
      ),
    );
  }
}
