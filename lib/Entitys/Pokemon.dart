import 'package:pokedex_final_proyect/Entitys/BaseStats.dart';
import 'package:pokedex_final_proyect/Entitys/Breedings.dart';
import 'package:pokedex_final_proyect/Entitys/Training.dart';
import 'package:pokedex_final_proyect/Entitys/TypeDefences.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  String? description;
  final int height;
  final int weight;
  final String species;
  final List<String> types;
  Training? training;
  Breedings? breedings;
  BaseStats? baseStats;
  TypeDefences? typeDefences;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.height,
    required this.weight,
    required this.species,
    required this.types,
    this.training,
    this.breedings,
    this.baseStats,
    this.typeDefences,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['sprites']['other']['official-artwork']['front_default'],
        height = json['height'],
        weight = json['weight'],
        species = json['species']['name'],
        baseStats = BaseStats.fromJson(json['stats']),
        types = (json['types'] as List)
            .map((typeEntry) => typeEntry['type']['name'].toString())
            .toList();
}