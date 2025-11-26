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
            validator: _validateName,

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
            validator: _validateEmail,
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
            validator: _validatePhoneNumber,
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
              // Access the Form using the _formKey
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                print('Name: $name, Email: $email, Phone: $phoneNumber');
              }
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

  // use validator: return an error string or null if the value is in the correct format
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter a name';
    }
    return null;
  }

  // Validate the Email Address
  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (value == null || value.isEmpty) {
      return 'Enter an email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Validate the Email Address
  String? _validatePhoneNumber(String? value) {
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

    if (value == null || value.isEmpty) {
      return 'Enter a phone number';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}
