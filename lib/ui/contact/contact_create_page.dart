import 'package:contact_app/data/contact.dart';
import 'package:contact_app/ui/contact/widget/contact_form.dart';
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
      body: ContactForm(
        editedContact: Contact(name: '', email: '', phoneNumber: ''),
        editedContactIndex: -1,
        onSave: (contact) {
          // Pop and return the new contact to the previous screen
        },
      ),
    );
  }
}
