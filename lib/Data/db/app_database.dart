import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  Database? _database;

  Future<Database> get database async {
    final appDocumenrDir = await getApplicationDocumentsDirectory();
    final dbpath = path.join(appDocumenrDir.path, 'contacts.db');
    // open the database
    final database = await databaseFactoryIo.openDatabase(dbpath);
    return database;
  }
}
