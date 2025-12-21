import 'dart:io';

class Contact {
  // Database id
  late int id;
  String name;
  String email;
  // all phone numbers are not formatted the same way
  String phoneNumber;
  bool isFavorite = false;
  File? ImageFile;

  // Required using to named parameters because string can't be not null
  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.ImageFile,
  });
  // Convet Contact object to Map for store
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'isFavorite': isFavorite,
      'ImageFilePath': ImageFile?.path,
      // we cannot store File object with SEMBAST directly (iamge file)
    };
  }

  // Convert Map into Contact
  static Contact fromMap(Map<String, dynamic> Map) {
    return Contact(
      name: Map['name'],
      email: Map['email'],
      phoneNumber: Map['phoneNumber'],
      isFavorite: Map['isFavorite'],
      ImageFile: Map['ImageFilePath'] != null
          ? File(Map['ImageFilePath'])
          : null,
      //  if there is no image file path Set ImageFile to null
      // Otherwise convert it into File
    );
  }
}
