import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';
import 'package:pokedex_final_proyect/Entitys/SpecieData.dart';

Future<PokemonPage> getPokemonsPage(String? url) async {

    final response = await http.get(Uri.parse( url ?? 'https://pokeapi.co/api/v2/pokemon?limit=30'));
    List<Pokemon> tempPokemons = List.empty(growable: true);
    if (response.statusCode == 200) {
       PokemonPage temp =  PokemonPage.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      for (var i = 0; i < temp.urlPokemones.length; i++) {
        final Pokemon aux = await getPokemonByUrl(temp.urlPokemones[i]);
        print(temp.urlPokemones[i]);
        final SpecieData sd = await getSpecieDataBySpecie(aux.species);
        aux.specieData = sd;
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
      Pokemon pokemon =  Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      final SpecieData sd = await getSpecieDataBySpecie(pokemon.species);
      pokemon.specieData = sd;

      return pokemon;

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
      Pokemon pokemon =  Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      final SpecieData sd = await getSpecieDataBySpecie(pokemon.species);
      pokemon.specieData = sd;

      return pokemon;
    } else {
      throw Exception('Failed to load pokemon $code');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<SpecieData> getSpecieDataBySpecie(String specie) async {
  try {
    // print(specie);
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon-species/${specie}'));
    if (response.statusCode == 200) {
      return SpecieData.fromJson(jsonDecode(response.body));
    } else {
       throw Exception('Failed to load Species');
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

Future<List<String>> getPokemonTypes() async {
    try {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
            List<String> pokemonTypes = (data['results'] as List)
          .map((result) => result['name'] as String)
          .toList();
      return pokemonTypes;
    } else {
       throw Exception('Failed to load Species');
    }
  } catch (e) {
     throw Exception(e);
  }
}

Future<List<String>> getPokemonNamesByTypes(String type1, String? type2) async {
  try {
      final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/$type1'));
      final response2 = await http.get(Uri.parse('https://pokeapi.co/api/v2/type/$type2'));
    if (response.statusCode == 200 && response2.statusCode == 200) {
      final List<dynamic> pokemones1 = jsonDecode(response.body)['pokemon'] as List<dynamic>;
      final List<dynamic> pokemones2 = jsonDecode(response2.body)['pokemon'] as List<dynamic>;

      final Set<String> uniquePokemonNames = {
        ...pokemones1.map((pokemon) => pokemon['pokemon']['name'] as String),
        ...pokemones2.map((pokemon) => pokemon['pokemon']['name'] as String),
      };

      // Limitar a 10 Pokémones
    final List<String> limitedPokemonNames = uniquePokemonNames.take(10).toList();

    return limitedPokemonNames;
    } else {
      throw Exception('Failed to load Pokémon by types');
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<List<String>> getPokemonGenerations() async {

  try {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/generation/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> pokemonGenerations = (data['results'] as List)
          .map((result) => result['name'] as String)
          .toList();
      return pokemonGenerations;
      } else {
        throw Exception('Failed to load Species');
      }
  } catch (e) {
    throw Exception(e);
  }
  
}

Future <List<String>> getPokemonsNameByGeneration(String generacion) async {
    try {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/generation/$generacion'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> pokemonGenerations = (data['pokemon_species'] as List)
          .map((result) => result['name'] as String)
          .toList();
      return pokemonGenerations;
      } else {
        throw Exception('Failed to load Species');
      }
  } catch (e) {
    throw Exception(e);
  }
}

