import 'dart:async';

import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PokemonDB {
  static final PokemonDB instance = PokemonDB._init();

  static Database? _database;
  
  PokemonDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pokemon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
          final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path, onCreate: _onCreateDB);
    } catch (e) {
      throw Exception(e);
    }
  }

  

  Future _onCreateDB(Database db, int version) async {
    try {
        //   await db.execute('''
        //   CREATE TABLE types (
        //     id INTEGER PRIMARY KEY,
        //     name TEXT
        //   )
        // ''');

      await db.execute(
        '''
          CREATE TABLE Pokemon(
              id INTEGER PRIMARY KEY,
              name TEXT,
              image TEXT,
              height DOUBLE,
              weight DOUBLE,
              species TEXT,
              types TEXT,
          )
        '''
      );
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<void> insertPokemon(Pokemon pokemon) async {
    final db = await instance.database;
    await db.insert('Pokemon', pokemon.toMap());
    
  }

  Future<int> deletePokemon(String id) async {
    final db = await instance.database;
    return await db.delete('Pokemon', where: 'id = ?', whereArgs: [id]);
  }
}