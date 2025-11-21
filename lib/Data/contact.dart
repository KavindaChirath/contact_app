class Contact {
  String name;
  String email;
  // all phone numbers are not formatted the same way
  String phoneNumber;

  // Required using to named parameters because string can't be not null
  Contact({required this.name, required this.email, required this.phoneNumber});
}
