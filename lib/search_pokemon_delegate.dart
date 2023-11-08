import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';
import 'package:pokedex_final_proyect/widgets/ListItemPokemon.dart';

class SearchPokemonDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Text('Búsqueda vacía');
    }

    return FutureBuilder(
      future: searchPokemon(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        } else if (snapshot.hasError) {
          return const Text('Error al cargar el Pokémon');
        } else if (snapshot.hasData) {
          final result = snapshot.data;
          return ListItemPokemon(pokemon: result);
        } else {
          return const Text('No se encontraron resultados');
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Text('Sugerencias de búsqueda aquí');
  }

  Future<Pokemon?> searchPokemon(String query) async {
    if (esNumero(query)) {
      // Busca por ID
      return getPokemonByNameOrId(query);
    } else {
      // Busca por nombre
      final allPokemonNames = await getAllPokemonNames();
      final filteredNames = allPokemonNames.where((name) {
        return name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      if (filteredNames.isNotEmpty) {
        return getPokemonByNameOrId(filteredNames[0]);
      }
    }

    return null;
  }

  bool esNumero(String str) {
    final pattern = r'^[0-9]+$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(str);
  }
}
