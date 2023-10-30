import 'package:pokedex_final_proyect/Entitys/BaseFriendship.dart';
import 'package:pokedex_final_proyect/Entitys/CatchRate.dart';

class Training {
  final String evYield;
  final String catchRate;
  final BaseFriendship baseFriendship;
  final int baseExp;
  final String growthRate;

  Training({
    required this.evYield,
    required this.catchRate,
    required this.baseFriendship,
    required this.baseExp,
    required this.growthRate,
  });
}