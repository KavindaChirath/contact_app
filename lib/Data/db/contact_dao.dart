import 'package:contact_app/data/contact.dart';
import 'package:contact_app/data/db/app_database.dart';
import 'package:sembast/sembast.dart';

class ContactDao {
  static const String CONTACT_STORE_NAME = 'contacts';
  final _contactStore = intMapStoreFactory.store(CONTACT_STORE_NAME);

  // Insert the new contacts
  Future insert(Contact contact) async {
    await _contactStore.add(
      await AppDatabase.instance.database,
      contact.toMap(),
    );
  }

  // Update the Contacts
  Future update(Contact contact) async {
    final finder = Finder(filter: Filter.equals('id', contact.id));

    await _contactStore.update(
      await AppDatabase.instance.database,
      contact.toMap(),
      finder: finder,
    );
  }

  // Delete the Contacts
  Future delete(Contact contact) async {
    final finder = Finder(filter: Filter.equals('id', contact.id));

    await _contactStore.delete(
      await AppDatabase.instance.database,
      finder: finder,
    );
  }

  // Get Contacts
  Future<List<Contact>> getAllSortedByName() async {
    final finder = Finder(
      sortOrders: [SortOrder('isFavourite', false), SortOrder('name')],
    );

    final recordSnapshots = await _contactStore.find(
      await AppDatabase.instance.database,
      finder: finder,
    );

    // Making a List<Contact> out of List<RecordSnapshot> give acess to every elements
    return recordSnapshots.map((snapshot) {
      final contact = Contact.fromMap(snapshot.value);
      // An ID is a key of a record from the database
      contact.id = snapshot.key;
      return contact;
    }).toList();
  }
}
