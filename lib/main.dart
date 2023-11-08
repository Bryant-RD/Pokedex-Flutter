import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';
import 'package:pokedex_final_proyect/pages/PokemoList.dart';
import 'package:pokedex_final_proyect/search_pokemon_delegate.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';
import 'package:pokedex_final_proyect/widgets/MenuLateral.dart';

void main() {
  runApp(MaterialApp(
    home: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  late Future<PokemonPage> pokemonPage;

  @override
  void initState() {
    super.initState();
    pokemonPage = getPokemonsPage(null);
  }


  @override
  Widget build(BuildContext context) {
    const title = "Pokedex";

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.redAccent.shade700
      ),
      title: title,
      home: Scaffold(
        drawer: const MenuLateral(),
          appBar: AppBar(
            title: Image.asset(
              'assets/pokedex.png',
              width: 150,
              height: 150,
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search_rounded),
                tooltip: 'Search a pokemon',
                onPressed: () {
                  showSearch(context: context, delegate: SearchPokemonDelegate());
                },
              )
            ],
          ),
        body: Center(
          child: FutureBuilder(
            future: pokemonPage,
            builder: (context, snapshot) {
              return PokemonList(pokemonPage: snapshot.data);
            }
          ),
        )
      ),
    );
  }
}