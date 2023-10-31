import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';

Future<PokemonPage> getPokemonsPage() async {

    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
    List<Pokemon> tempPokemons = List.empty(growable: true);
    if (response.statusCode == 200) {
       PokemonPage temp =  PokemonPage.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      for (var i = 0; i < temp.urlPokemones.length; i++) {
        final Pokemon aux = await getPokemonByUrl(temp.urlPokemones[i]);
        // print(aux.name);
        tempPokemons.add(aux);
      }
      temp.pokemones = tempPokemons;
       return temp;
    } else {
      throw Exception('Failed to load pokemons');
    }

}

Future<Pokemon> getPokemonByUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load pokemons');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<Pokemon> getPokemonByNameOrId(String code) async {
  try {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$code'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load pokemons');
    }
  } catch (e) {
    throw Exception(e);
  }
}


Future<List<String>> getAllPokemonNames() async {
  List<String> names = [];

  try {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000')); // Asegúrate de obtener todos los Pokémon

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      for (var result in results) {
        final name = result['name'];
        names.add(name);
      }
    }
  } catch (e) {
    throw Exception(e);
  }

  return names;
}


Future<List<String>> getPokemonSpeciesByColor(String color) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-color/$color/'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final species = data['pokemon_species'] as List;

    return species.map((specie) => specie['name'] as String).toList();
  } else {
    print('Error al obtener especies de color $color');
    return [];
  }
}

