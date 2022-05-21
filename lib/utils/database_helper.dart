import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:healthapp/models/user_model.dart';

class DatabaseHelper{
   static   DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static    Database _database;                // Singleton Database

   String usertable = 'user_table';
   String colId = 'id';
   String colname = 'name';
   String colAdress = 'adress';
   String colPreference = 'preferences';
   String coltype = 'type';
   DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;


  }



    Future<Database> get database async
   {
     if (_database==null)
       {
         _database ??=  await initializeDatabase();
       }
     return _database;
   }

  Future<Database>  initializeDatabase() async{
    Directory.current= await getApplicationDocumentsDirectory();

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';
   var db=await openDatabase(path,version: 1,onCreate:createDb );
   return db;
  }

   void createDb(Database db, int newVersion) async {

     await db.execute('CREATE TABLE $usertable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colname TEXT, '
         '$colAdress TEXT, $colPreference INTEGER, $coltype INTEGER)');
   }



   // Fetch Operation: Get all note objects from database
   Future<List<Map<String, dynamic>>> getUserMapList() async {
     Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
     var result = await db.query(usertable, orderBy: '$colId ASC');
     return result;
   }

   // Insert Operation: Insert a Note object to database
   Future<int> insertUser(User note) async {
    debugPrint("insertinguser ${note.name}");
     Database db = await this.database;
     var result = await db.insert(usertable, note.toMap());
     if(result!=0)
       {
         debugPrint("SUCCESS INSERT");

       }else{
       debugPrint("FAILUERE INSERT");
     }
     return result;
   }

   // Update Operation: Update a Note object and save it to database
   Future<int> updateUser(User note) async {
     var db = await this.database;
     var result = await db.update(usertable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
     return result;
   }

   // Delete Operation: Delete a Note object from database
   Future<int> deleteUser(int id) async {
     var db = await this.database;
     int result = await db.rawDelete('DELETE FROM $usertable WHERE $colId = $id');
     return result;
   }

   // Get number of Note objects in database
   Future<int> getCount() async {
     Database db = await this.database;
     List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $usertable');
     int result = Sqflite.firstIntValue(x);
     return result;
   }

   // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
   Future<List<User>> getUSerList() async {

     var userMapList = await getUserMapList(); // Get 'Map List' from database
     int count = userMapList.length;         // Count the number of map entries in db table

     List<User> noteList = <User>[];
     // For loop to create a 'Note List' from a 'Map List'
     for (int i = 0; i < count; i++) {
       noteList.add(User.fromMapObject(userMapList[i]));
       debugPrint(" get username -->${noteList[i].name}");

     }

     return noteList;
   }


}