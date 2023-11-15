import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';
import 'package:pokedex_final_proyect/widgets/ListItemPokemon.dart';

class PokemonListFiltro extends StatefulWidget {

  final List<String> pokemonNames;

  const PokemonListFiltro({super.key, required this.pokemonNames});

  @override
  State<PokemonListFiltro> createState() => _PokemonListFiltroState();
}

class _PokemonListFiltroState extends State<PokemonListFiltro> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.pokemonNames.length,
      itemBuilder: (context, index) {
        final pokemonName = widget.pokemonNames[index];

        return (
          FutureBuilder(
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
            }
          )
        );
      },
    );
  }
}