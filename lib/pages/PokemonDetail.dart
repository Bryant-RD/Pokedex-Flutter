import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? backgroundColor;

  const PokemonDetail({Key? key, required this.pokemon, this.backgroundColor}) : super(key: key);

  // Establecer un TextStyle personalizado
  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    // Verificar si el fondo es blanco o amarillo y ajustar el color del texto en consecuencia
    final textColor = backgroundColor == Colors.white || backgroundColor == Colors.yellow ? Colors.black : Colors.white;

    return DefaultTabController(
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
                  backgroundColor == Colors.white || backgroundColor == Colors.yellow
                      ? 'assets/pokeballblack.png'
                      : 'assets/pokeball.png',
                  height: 300,
                  width: 400,
                  fit: BoxFit.cover,
                ),
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
                          style: _textStyle.copyWith(color: textColor), // Usar el estilo personalizado
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${pokemon?.name}',
                          style: _textStyle.copyWith(color: textColor), // Usar el estilo personalizado
                        ),
                      ),
                      Row(
                        children: pokemon?.types.map((tipo) {
                          return Card(
                            color: const Color.fromARGB(70, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                tipo,
                                style: _textStyle.copyWith(color: textColor), // Usar el estilo personalizado
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
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
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

  const PokemonDetailSobre({Key? key, required this.pokemon}) : super(key: key);

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
  const PokemonDetailEvolucao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text("Contenido de la pestaña de evolución"),
    );
  }
}

class PokemonDetailStatus extends StatelessWidget {
  const PokemonDetailStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text("Contenido de la pestaña de estado"),
    );
  }
}
