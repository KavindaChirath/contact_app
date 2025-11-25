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
          SizedBox(height: 10),
          TextFormField(
            onSaved: (value) => name = value ?? '',
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          SizedBox(height: 10),
          TextFormField(
            onSaved: (value) => email = value ?? '',
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          SizedBox(height: 10),
          TextFormField(
            onSaved: (value) => phoneNumber = value ?? '',
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              _formKey.currentState?.save();
              print('Name: $name, Email: $email, Phone: $phoneNumber');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.person, size: 18),
                SizedBox(width: 10),
                Text('SAVE CONTACT', style: TextStyle(color: Colors.white)),
              ],
            ),
            style: ElevatedButton.styleFrom(
              iconColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
