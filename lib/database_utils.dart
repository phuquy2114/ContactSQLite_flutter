import 'package:contact_sqlite_flutter/model/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtils {
  static Future<Database> getInstance() async {
    // Open the database and store the reference.
    Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'contact_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, phone TEXT , email TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return database;
  }

  static Future<void> insertContact(Contacts contacts) async {
    // Get a reference to the database.
    final Database db = await getInstance();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'contacts',
      contacts.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  static Future<List<Contacts>> listContacts() async {
    // Get a reference to the database.

    final Database db = await getInstance();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    print(maps.toList().toString());

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Contacts(
          maps[i]['id'], maps[i]['name'], maps[i]['phone'], maps[i]['email']);
    });
  }

  static Future<void> updateContact(Contacts contacts) async {
    // Get a reference to the database.
    final db = await getInstance();

    // Update the given Dog.
    await db.update(
      'contacts',
      contacts.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [contacts.id],
    );
  }

  static Future<void> deleteContacts(int id) async {
    // Get a reference to the database.
    final db = await getInstance();

    // Remove the Dog from the Database.
    await db.delete(
      'contacts',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
