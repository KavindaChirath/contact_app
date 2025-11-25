import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // keys allows us to access widget from a different place in code
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[TextFormField(), TextFormField(), TextFormField()],
      ),
    );
  }
}
