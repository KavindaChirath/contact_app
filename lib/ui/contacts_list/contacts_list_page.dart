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

  void addContact(Contact contct) {
    contacts.add(contct);
    setState(() {});
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
                  sortContacts();
                });
              },
            ),
          );
        },
      ),
      // create save icon in home page
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {},
      ),
    );
  }

  void sortContacts() {
    contacts.sort((a, b) {
      int comparisonResult;

      //sorting based on whather or not the contact is favorite
      comparisonResult = compareAlphabetically(a, b);
      // If the the favourite status of two contacts isidential, sort alphabetacally
      //secondary alphabetical sorting
      if (comparisonResult == 0) {
        comparisonResult = compareAlphabetically(a, b);
      }
      return comparisonResult;
    });
  }

  int comapareBasedOnFavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      //contact 1 should be before contact 2
      return -1;
    } else if (b.isFavorite) {
      //contact 2 should be before contact 1
      return 1;
    } else {
      // The position doesn't channge
      return 0;
    }
  }

  int compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
}
