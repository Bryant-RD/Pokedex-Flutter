import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/PokemonPage.dart';
import 'package:pokedex_final_proyect/pages/PokemoList.dart';

class itemFiltro extends StatelessWidget {

  final IconData icono;
  final String texto;


  const itemFiltro({
    super.key, required this.icono, required this.texto,
  });

  @override
  Widget build(BuildContext context) {

    PokemonPage pokemonPage;


    return InkWell(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => PokemonList(pokemonPage: pokemonPage),
        //   )
        // );
      },
      child: ListTile(
        leading: Icon(icono), // Agrega un icono a la izquierda
        title: Text(texto),
        onTap: () {
          // Agrega tu lógica de filtrado aquí
        },
      ),
    );
  }
}