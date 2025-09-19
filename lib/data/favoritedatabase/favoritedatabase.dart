

import 'dart:io';

import 'package:localmarket/models/usermodels.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class FavoriteDatabase {
  Database?_database;

  final TABLE = "favorites";

  Future<Database?>get database async{
    if(_database != null){
      return _database;
    }else{
      _database =await initilaizedata();
      return _database;
    }
  }

  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "fav.db");
    await deleteDatabase(path);
  }


  initilaizedata()async{
    Directory directory = await getApplicationDocumentsDirectory();
    final paths = join(directory.path,"fav.db");
    final databse = await openDatabase(paths,version: 1,onCreate:_createdatabase);
    return databse;
  }

  _createdatabase(Database datbase,int version)async{
    const String createFavoritesTable = '''
CREATE TABLE favorites (
  userid INTEGER PRIMARY KEY AUTOINCREMENT,
  useremail TEXT NOT NULL,
 owneremail TEXT NOT NULL,
  product TEXT NOT NULL
);
''';

    await datbase.execute(createFavoritesTable);
  }


  Future<void> addFavoriteProduct(Favoritemodels favoritemodel) async {
    final db = await database;
    try {
      await db!.insert(
        TABLE,
        favoritemodel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace, // duplicate handle
      );
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  Future<List<Favoritemodels>> getAllFavorites() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> query = await db!.query(TABLE);
      return query.map((row) => Favoritemodels.fromJson(row)).toList();
    } catch (e) {
      print("Error fetching favorites: $e");
      return [];
    }
  }

  Future<void> deleteFavoriteProduct(int userid) async {
    final db = await database;
    try {
      await db!.delete(TABLE, where: "userid = ?", whereArgs: [userid]);
    } catch (e) {
      print("Error deleting favorite: $e");
    }
  }

}