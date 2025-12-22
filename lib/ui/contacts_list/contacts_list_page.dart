import 'package:contact_app/data/db/contact_dao.dart';
import 'package:contact_app/ui/contact/contact_create_page.dart';
import 'package:contact_app/ui/contact/contact_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:contact_app/data/contact.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ContactListPage extends StatefulWidget {
  final String title;

  ContactListPage({required this.title});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

bool _isLoading = true;
bool get isLoading => _isLoading;

class _ContactListPageState extends State<ContactListPage> {
  final ContactDao _contactDao = ContactDao();
  List<Contact> contacts = [];

  Future loadContacts() async {
    _isLoading = true;
    setState(() {});
    contacts = await _contactDao.getAllINSortedOrder();
    _isLoading = false;
    setState(() {});
  }

  // Runs When the Widget is Initialized
  @override
  void initState() {
    super.initState();
    loadContacts();
    // Genetate 5 dummy Contacts
  }

  // to add new contact
  Future addContact(Contact contct) async {
    await _contactDao.insert(contct);
    await loadContacts();
    setState(() {});
  }

  // to update contact
  Future updateContact(Contact contact) async {
    await _contactDao.update(contact);
    await loadContacts();
    setState(() {});
  }

  // to delete the contact
  Future deleteContact(Contact contact) async {
    await _contactDao.delete(contact);
    await loadContacts();
    setState(() {});
  }

  Future changeFavoriteStatus(Contact contact) async {
    contact.isFavorite = !contact.isFavorite;
    await _contactDao.update(contact);
    await loadContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        // Runs and builds each item of the list
        itemBuilder: (context, index) {
          //set the slidable widget to enable swipe to delete
          return Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                // To delete the contact
                SlidableAction(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  onPressed: (context) async {
                    await ContactDao().delete(contacts[index]);
                    await loadContacts();
                    setState(() {});
                  },
                ),
                SlidableAction(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.call,
                  label: 'Call',
                  onPressed: (context) async {
                    await loadContacts();
                    setState(() {});
                  },
                ),
              ],
            ),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: ListTile(
                title: Text(contacts[index].name),
                subtitle: Text(contacts[index].email),
                leading: _buildCircleAvatar(
                  contacts[index],
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

  // Hero Widget to nice Animation when clicking on contacts
  Hero _buildCircleAvatar(Contact displayedContact) {
    return Hero(
      tag: displayedContact.hashCode,
      child: CircleAvatar(child: _buildCircleAvatarContent(displayedContact)),
    );
  }

  Widget _buildCircleAvatarContent(Contact displayedContact) {
    if (displayedContact.ImageFile != null) {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(displayedContact.ImageFile!, fit: BoxFit.cover),
        ),
      );
    } else {
      return Text(
        displayedContact.name.isNotEmpty ? displayedContact.name[0] : '',
      );
    }
  }
}
