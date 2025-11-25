import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // keys allows us to access widget from a different place in code
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(onSaved: (value) => name = value ?? ''),
          TextFormField(onSaved: (value) => email = value ?? ''),
          TextFormField(onSaved: (value) => phoneNumber = value ?? ''),

          ElevatedButton(
            onPressed: () {
              _formKey.currentState?.save();
              print('Name: $name, Email: $email, Phone: $phoneNumber');
            },
            child: Text('Save Contact'),
          ),
        ],
      ),
    );
  }
}
