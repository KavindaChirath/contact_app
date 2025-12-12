import 'package:contact_app/ui/contact/contact_create_page.dart';
import 'package:contact_app/ui/contact/contact_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:contact_app/data/contact.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    // Genetate 5 dummy Contacts
    contacts = List.generate(5, (index) {
      final faker = Faker();
      return Contact(
        name: '${faker.person.firstName()} ${faker.person.lastName()}',
        email: faker.internet.email(),
        phoneNumber: faker.randomGenerator.integer(100000).toString(),
      );
    });
  }

  void updateContact(Contact contact, int contactIndex) {
    contacts[contactIndex] = contact;
    setState(() {});
  }

  // to delete the contact
  void deleteContact(int Index) {
    contacts.removeAt(Index);
    setState(() {});
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
        itemCount: contacts.length,
        // Runs and builds each item of the list
        itemBuilder: (context, index) {
          // Get dummy data to look like real contact app home

          //set the slidable widget to enable swipe to delete
          return Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      deleteContact(index); // To delete the contact
                    });
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                title: Text(contacts[index].name),
                subtitle: Text(contacts[index].email),
                leading: CircleAvatar(
                  child: Text(contacts[index].name[0]),
                ), // when have't profle picture show first letter of name
                trailing: IconButton(
                  icon: Icon(
                    contacts[index].isFavorite ? Icons.star : Icons.star_border,
                    color: contacts[index].isFavorite
                        ? Colors.amber
                        : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      contacts[index].isFavorite = !contacts[index].isFavorite;
                    });
                  },
                ),

                // Navigate to Contact Edit page when tapped and update on return
                onTap: () async {
                  final updatedContact = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactEditPage(
                        editedContact: contacts[index],
                        editedContactIndex: index,
                      ),
                    ),
                  );
                  if (updatedContact != null) {
                    setState(() {
                      contacts[index] = updatedContact;
                    });
                  }
                },
              ),
            ),
          );
        },
      ),
      // create save icon in home page
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        // Navigate to contact create page when button is Pressed
        onPressed: () async {
          final newContact = await Navigator.of(context).push<Contact?>(
            MaterialPageRoute(
              builder: (context) => ContactCreatePage(title: 'Create Contact'),
            ),
          );
          if (newContact != null) {
            addContact(newContact);
          }
        },
      ),
    );
  }
}
