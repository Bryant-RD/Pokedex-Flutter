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
    // TODO: implement buildResults
    if (query.trim().length == 0) {
      return const Text('busqueda vacia');
    }

    return FutureBuilder(
      future: getPokemonByNameOrId(query),
      builder: ( _ , AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final Pokemon result = snapshot.data;
          return ListItemPokemon(pokemon: result);
        } else {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 4),
          );
        }
      });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center();
  }


  
}