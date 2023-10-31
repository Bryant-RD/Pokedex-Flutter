import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';
import 'package:pokedex_final_proyect/widgets/ListItemPokemon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonList extends StatefulWidget {

  PokemonPage? pokemonPage;

  PokemonList({super.key, required this.pokemonPage});

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  
  bool isLoading = false;

  

Future<void> loadMoreData() async {
  if (!isLoading) {
    setState(() {
      isLoading = true;
    });

    // Utiliza FutureBuilder para cargar datos de forma asincrónica
    final newPokemonPage = await getPokemonsPage(widget.pokemonPage?.next);

    if (newPokemonPage.pokemones!.isNotEmpty) {
      setState(() {
        widget.pokemonPage!.pokemones?.addAll(newPokemonPage.pokemones as Iterable<Pokemon>);
        widget.pokemonPage?.next = newPokemonPage.next;
        isLoading = false;
      });
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final pokemones = widget.pokemonPage?.pokemones;

    return ListView.builder(
      itemCount: pokemones?.length ?? 0,
      itemBuilder: (context, index) {
        if (index == pokemones!.length - 10) {
          // Cuando se alcanza el último elemento, carga más datos
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            loadMoreData();
          });
        }
        return ListItemPokemon(pokemon: pokemones[index]);
      },
    );
  }
}
