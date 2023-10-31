import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? backgroundColor;

  const PokemonDetail({super.key, required this.pokemon, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(300.0),
            child: AppBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              flexibleSpace: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/pokeball.png',
                    height: 300,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                  // Imagen del Pokémon
                  Image.network(
                    pokemon?.image ?? '',
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 140,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '#${pokemon?.id}',
                            style: const TextStyle(
                              fontFamily: 'Google Sans',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${pokemon?.name}',
                            style: const TextStyle(
                              fontFamily: 'Google Sans',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: pokemon?.types.map((tipo) {
                            return Card(
                              color: const Color.fromARGB(70, 255, 255, 255),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tipo,
                                  style: const TextStyle(
                                    fontFamily: 'Google Sans',
                                    fontSize: 18.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList() ?? [],
                        ),
                      ],
                    ),
                  ),
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
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
