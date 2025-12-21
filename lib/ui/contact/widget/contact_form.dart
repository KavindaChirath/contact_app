import 'dart:io';

import 'package:contact_app/data/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactForm extends StatefulWidget {
  final Contact editedContact;
  final int editedContactIndex;
  ContactForm({
    Key? key,
    required this.editedContact,
    required this.editedContactIndex,
    required Null Function(dynamic updatedContact) onSave,
  }) : super(key: key);
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  // keys allows us to access widget from a different place in code
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phoneNumber = '';
  File? _ImageFile;

  bool get hasSelectedCustomImage => _ImageFile != null;

  // show the existing profile picture when edit contact (after saved)
  @override
  void initState() {
    super.initState();
    _ImageFile = widget.editedContact.ImageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          buildContactPicture(),
          SizedBox(height: 10),
          TextFormField(
            onSaved: (value) => name = value ?? '',
            validator: _validateName,
            // TO Show Existing Name that you Entered for  Editing
            // due to using elvis operator put the ? after editedContact (if is't we can't save new contact)
            initialValue: widget.editedContact.name,

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
            // TO Show Existing email that you Entered for  Editing
            // due to using elvis operator put the ? after editedContact (if is't we can't save new contact)
            initialValue: widget.editedContact.email,

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
            // TO Show Existing phone number that you Entered for  Editing
            // due to using elvis operator put the ? after editedContact (if is't we can't save new contact)
            initialValue: widget.editedContact.phoneNumber,

            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 10),

          ElevatedButton(
            onPressed: _onSaveContactButtonPressed,
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

  // ShowAvatar when create or edit contact
  Widget buildContactPicture() {
    final halfScreenDiameter = MediaQuery.of(context).size.width / 2;
    return Hero(
      tag: (widget.editedContactIndex >= 0 && widget.editedContact.name != null)
          ? 'contact_${widget.editedContactIndex}'
          : 'new_contact',
      child: GestureDetector(
        onTap: onContactPictureTapped,
        child: CircleAvatar(
          radius: halfScreenDiameter / 2,
          child: _buildCircleAvatarContent(halfScreenDiameter),
        ),
      ),
    );
  }

  Future<void> onContactPictureTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) return; // when user cancel the picker
    setState(() {
      _ImageFile = File(pickedImage.path);
    });
  }

  // Build the circle Avatar when create or edit content (if edit show first letter of name )
  Widget _buildCircleAvatarContent(double halfScreenDiameter) {
    if (widget.editedContactIndex >= 0 && widget.editedContact.name != null) {
      return _buildEditModeCircleAvatarContent(halfScreenDiameter);
    } else {
      return Icon(Icons.person, size: halfScreenDiameter / 2);
    }
  }

  Widget _buildEditModeCircleAvatarContent(double halfScreenDiameter) {
    if (_ImageFile == null) {
      return Text(
        widget.editedContact.name[0],
        style: TextStyle(fontSize: halfScreenDiameter / 2),
      );
    } else {
      return ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.file(_ImageFile!, fit: BoxFit.cover),
        ),
      );
    }
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

  void _onSaveContactButtonPressed() {
    // Access the Form using the _formKey
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // To print name , email and phone number in debug console
      //print('Name: $name, Email: $email, phone: $phoneNumber');
      final newContact = Contact(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        isFavorite: widget.editedContact.isFavorite,
        ImageFile: _ImageFile,
      );
      if (widget.editedContactIndex >= 0) {
        // id doesn't change after editing other contact fields
        newContact.id = widget.editedContact.id;
        // Editing existing contact
        // Update the existing contact's details
        newContact.isFavorite = widget.editedContact.isFavorite;
      }
      // To return to home page after saving contact
      Navigator.of(context).pop(newContact);
    }
  }
}
