import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: <Widget>[TextFormField(), TextFormField(), TextFormField()],
      ),
    );
  }
}
