
class PokemonDTO {
  final int id;
  final String name;
  final bool isFavorite;


  PokemonDTO({
    required this.id,
    required this.name,
    required this.isFavorite
  });


  PokemonDTO.fromMap(Map<String, dynamic> map) 
  : id = map['id'],
    name = map['name'],
    isFavorite = map['isFavorite'];

}