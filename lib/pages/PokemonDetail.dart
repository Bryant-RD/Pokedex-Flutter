import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon? pokemon;

  PokemonDetail({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(240.0), // Ajusta la altura según tus preferencias
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coloca la imagen del Pokémon arriba
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Image.network(
                    pokemon?.image ?? '',
                    width: double.infinity,
                    height: 200, // Ajusta la altura de la imagen según tus preferencias
                    fit: BoxFit.cover,
                  ),
                ),
                // Espacio entre la imagen y el TabBar
                const SizedBox(height: 16.0),
              ],
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Sobre",
                ),
                Tab(
                  text: "Evolucion",
                ),
                Tab(
                  text: "Status",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PokemonDetailSobre(pokemon: pokemon), // Contenido de la pestaña "Sobre"
            const PokemonDetailEvolucao(), // Contenido de la pestaña "Evolução"
            const PokemonDetailStatus(), // Contenido de la pestaña "Status"
          ],
        ),
      ),
    );
  }
}

class PokemonDetailSobre extends StatelessWidget {
  final Pokemon? pokemon;

  const PokemonDetailSobre({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nombre: ${pokemon?.name}",
            style: const TextStyle(
              fontSize: 20.0, // Ajusta el tamaño de fuente según tus preferencias
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("ID: ${pokemon?.id}"),
          // Agrega más detalles sobre el Pokémon aquí según tus datos
        ],
      ),
    );
  }
}

class PokemonDetailEvolucao extends StatelessWidget {
  const PokemonDetailEvolucao({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text("Contenido de la pestaña de evolución"),
    );
  }
}

class PokemonDetailStatus extends StatelessWidget {
  const PokemonDetailStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text("Contenido de la pestaña de estado"),
    );
  }
}
