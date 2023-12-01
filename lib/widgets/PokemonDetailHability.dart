import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Hability.dart';

class PokemonDetailHability extends StatelessWidget {
  final List<Hability> pokemonHabilities;
  final Color? color;

  const PokemonDetailHability({Key? key, required this.pokemonHabilities, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemonHabilities.length,
      itemBuilder: (context, index) {
        final hability = pokemonHabilities[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(hability.name),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  hability.description,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }
}