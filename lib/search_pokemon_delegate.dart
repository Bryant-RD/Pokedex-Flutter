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
        }
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      }
    );
  }

@override
Widget buildResults(BuildContext context) {
  // Verifica si el query está vacío
  if (query.trim().isEmpty) {
    return const Text('Búsqueda vacía');
  }

  return FutureBuilder(
    future: getAllPokemonNames(), // Obtiene la lista de nombres de Pokémon
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 4),
        );
      } else if (snapshot.hasError) {
        return const Text('Error en la búsqueda');
      } else if (!snapshot.hasData || (snapshot.data as List<String>).isEmpty) {
        return const Text('No se encontraron resultados');
      } else {
        final allPokemonNames = snapshot.data as List<String>;
        final filteredNames = allPokemonNames.where((name) {
          return name.toLowerCase().contains(query.toLowerCase());
        }).toList();

        return ListView.builder(
          itemCount: filteredNames.length,
          itemBuilder: (context, index) {
            final pokemonName = filteredNames[index];
            return FutureBuilder(
              future: getPokemonByNameOrId(pokemonName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(strokeWidth: 2);
                } else if (snapshot.hasError) {
                  return const Text('Error al cargar el Pokémon');
                } else if (snapshot.hasData) {
                  final Pokemon result = snapshot.data as Pokemon;
                  return ListItemPokemon(pokemon: result);
                } else {
                  return const Text('No se encontraron resultados');
                }
              },
            );
          },
        );
      }
    },
  );
}


  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center();
  }


  
}