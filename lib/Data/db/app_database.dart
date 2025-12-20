import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();
  static AppDatabase get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;
  // this is singleton instance ,from this privete constructor we can create new instance
  AppDatabase._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      // if completer is null, database is not yet opened
      _dbOpenCompleter = Completer<Database>();
      _openDatabase();
    }
    // if the database is already opened return immediately
    // otherwise until call completer in _openDatabase
    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    final appDocumenrDir = await getApplicationDocumentsDirectory();
    final dbpath = path.join(appDocumenrDir.path, 'contacts.db');
    // open the database
    final database = await databaseFactoryIo.openDatabase(dbpath);
    _dbOpenCompleter!.complete(database);
  }
}
