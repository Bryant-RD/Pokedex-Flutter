import 'dart:async';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonDTO.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PokemonDB {
  static final PokemonDB instance = PokemonDB._init();

  static Database? _database;
  
  PokemonDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // sqfliteFfiInit();

    _database = await _initDB('pokemon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
          final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(path, version: 1 ,onCreate: _onCreateDB);
    } catch (e) {
      throw Exception(e);
    }
  }

  

  Future _onCreateDB(Database db, int version) async {
    try {
      await db.execute(
        '''
          CREATE TABLE Pokemon(
              id INTEGER PRIMARY KEY,
              name TEXT,
              isFavorite bool,
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


  Future<List<PokemonDTO>> getAllFavoritePokemons() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('Pokemon');

    return List.generate(maps.length, (i) {
      return PokemonDTO(id: maps[i]['id'], name: maps[i]['name'], isFavorite: maps[i]['isFavorite']);
    });
  }

  Future<PokemonDTO?> getFavoritePokemonByName(String name) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Pokemonb',
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return PokemonDTO.fromMap(maps.first);
    } else {
      return null; // Si no se encuentra ningún registro con el ID proporcionado
    }
  }


}