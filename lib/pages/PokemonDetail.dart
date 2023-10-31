import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon? pokemon;

  PokemonDetail({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon?.name ?? 'Pokemon Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Mostrar la imagen del Pokémon
            Image.network(
              pokemon?.image ?? '',
              width: 200, // Ajusta el ancho de la imagen según tus preferencias
              height: 200, // Ajusta la altura de la imagen según tus preferencias
            ),
            Text('Name: ${pokemon?.name}'),
            Text('ID: ${pokemon?.id}'),
            // Agrega más detalles del Pokémon aquí según tus necesidades
          ],
        ),
      ),
    );
  }
}
