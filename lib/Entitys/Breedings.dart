import 'package:pokedex_final_proyect/Entitys/EggCycles.dart';
import 'package:pokedex_final_proyect/Entitys/Gender.dart';

class Breedings {
  final List<String> eggGroups;
  final Gender gender;
  final EggCycles eggCycles;

  Breedings({
    required this.eggGroups,
    required this.gender,
    required this.eggCycles,
  });
}