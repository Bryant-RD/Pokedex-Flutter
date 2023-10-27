import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';
import 'package:pokedex_final_proyect/widgets/ListItemPokemon.dart';


class PokemonList extends StatelessWidget {

  final PokemonPage? pokemonPage;

    
  PokemonList({required this.pokemonPage});

  @override
  Widget build(BuildContext context) {

    print(pokemonPage?.pokemones?.length);
    final pokemones = pokemonPage?.pokemones;

        return ListView(
        children: pokemones?.map((e) => ListItemPokemon(pokemon: e,)).toList() ?? [],
      );
  }
}





