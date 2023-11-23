import 'package:pokedex_final_proyect/Entitys/BaseStats.dart';
import 'package:pokedex_final_proyect/Entitys/SpecieData.dart';

class Pokemon {
  final int id;
  final String name;
  final String image;
  String? description;
  final int height;
  final int weight;
  final String species;
  final List<String> types;
  SpecieData? specieData; //
  BaseStats? baseStats; //

  // final int evYield;
  final int baseExp;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.height,
    required this.weight,
    required this.species,
    required this.types,
    // required this.evYield,
    required this.baseExp,
    this.specieData,
    this.baseStats,
  });

  //pokemon[base-experience]//Pokemon[stats][effort]

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['sprites']['other']['official-artwork']['front_default'],
        height = json['height'],
        weight = json['weight'],
        species = json['species']['name'],
        baseStats = BaseStats.fromJson(json['stats']),
        // evYield = json['stats']['effort'],
        baseExp = json['base_experience'],
        types = (json['types'] as List)
            .map((typeEntry) => typeEntry['type']['name'].toString())
            .toList();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'height': height,
      'weight': weight,
      'species': species,
      'types': types
    };
  }
}