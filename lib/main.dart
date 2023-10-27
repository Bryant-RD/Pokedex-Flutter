import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';
import 'package:pokedex_final_proyect/pages/PokemoList.dart';
import 'package:pokedex_final_proyect/services/PokemonService.dart';

void main() {
  runApp(const MainApp());
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
    pokemonPage = getPokemonsPage();
  }


  @override
  Widget build(BuildContext context) {
    const title = "Pokedex";

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Pokedex"),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Show the menu',
              onPressed: () {
                print("funciona");
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