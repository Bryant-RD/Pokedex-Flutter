import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';
import 'package:pokedex_final_proyect/widgets/ListItemPokemon.dart';

class PokemonListFiltro extends StatefulWidget {
  final List<String> pokemonNames;

  const PokemonListFiltro({Key? key, required this.pokemonNames}) : super(key: key);

  @override
  State<PokemonListFiltro> createState() => _PokemonListFiltroState();
}

class _PokemonListFiltroState extends State<PokemonListFiltro> {
  late List<Future<Pokemon>> pokemonFutures;

  @override
  void initState() {
    super.initState();
    pokemonFutures = widget.pokemonNames.map((pokemonName) {
      return getPokemonByNameOrId(pokemonName);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemonFutures.length,
      itemBuilder: (context, index) {
        return FutureBuilder<Pokemon>(
          future: pokemonFutures[index],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(strokeWidth: 2);
            } else if (snapshot.hasError) {
              return const Text('Error al cargar el Pokémon');
            } else if (snapshot.hasData) {
              final Pokemon result = snapshot.data as Pokemon;
              print(result.name);
              return(Text(result.name));
              // return ListItemPokemon(pokemon: result);
            } else {
              return const Text('No se encontraron resultados');
            }
          },
        );
      },
    );
  }
}
