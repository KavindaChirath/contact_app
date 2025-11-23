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
  List<Contact> contacts = [];

  // Runs When the Widget is Initialized
  @override
  void initState() {
    super.initState();
    contacts = List.generate(50, (index) {
      final faker = Faker();
      return Contact(
        name: '${faker.person.firstName()} ${faker.person.lastName()}',
        email: faker.internet.email(),
        phoneNumber: faker.randomGenerator.integer(100000).toString(),
      );
    });
  }

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
            trailing: IconButton(
              icon: Icon(
                contacts[index].isFavorite ? Icons.star : Icons.star_border,
                color: contacts[index].isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  contacts[index].isFavorite = !contacts[index].isFavorite;
                  contacts.sort((a, b) {
                    if (a.isFavorite) {
                      return -1;
                    } else if (b.isFavorite) {
                      return 1;
                    } else {
                      return 0;
                    }
                  });
                });
              },
            ),
          );
        },
      ),
    );
  }
}
