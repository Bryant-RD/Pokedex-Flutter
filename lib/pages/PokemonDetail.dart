import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Evoluciones.dart';
import 'package:pokedex_final_proyect/Entitys/Hability.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';
class PokemonDetail extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? backgroundColor;
  final bool isFavorite;

  const PokemonDetail(
    {Key? key, required this.pokemon, this.backgroundColor, this.isFavorite = false, required List<Hability> pokemonSkills, required EvolutionChain pokemonEvolution}
    ) : super(key: key);

  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  get color => null;

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = backgroundColor == Colors.white || backgroundColor == Colors.yellow ? Colors.black : Colors.white;
    final tabLabelColor = backgroundColor ?? Colors.blue; // Color del AppBar

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
                  width: 550,
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
                          style: _textStyle.copyWith(
                            color: textColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          capitalize(pokemon?.name ?? ''),
                          style: _textStyle.copyWith(
                            color: textColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Card(
                            color: const Color.fromARGB(70, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: [
                                  for (var tipo in pokemon?.types ?? [])
                                    Image.asset(
                                      'assets/icon_types/$tipo.png',
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Mover la estrella a la esquina superior derecha
                Positioned(
                  top: 10,
                  right: 10,
                  child: _buildFavoriteButton(),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: backgroundColor,
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(
                      child: Text(
                        "Sobre",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Evolucion",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  indicatorColor: Colors.white,
                  labelColor: tabLabelColor,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      PokemonDetailSobre(pokemon: pokemon, color: backgroundColor),
                      const PokemonDetailEvolucao(),
                      const PokemonDetailStatus(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color: isFavorite || color == Colors.yellow ? Colors.orange : Colors.orange,
        size: 49.0,
      ),
      onPressed: () {
        // Lógica para cambiar el estado de favorito
        // Puedes implementar esto de acuerdo a tu lógica de manejo de favoritos
      },
    );
  }
}

class PokemonDetailSobre extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? color;

  const PokemonDetailSobre({Key? key, required this.pokemon, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseStats = pokemon?.baseStats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildStatRow('Altura', '${(pokemon?.height ?? 0) / 10} m'),
        const SizedBox(height: 16),
        _buildStatRow('Peso', '${(pokemon?.weight ?? 0) / 10} kg'),
        const SizedBox(height: 16),
        if (baseStats != null) ...[
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildStatsSection('Estadísticas', [
            _buildStatBar('HP', baseStats.hp, 255),
            _buildStatBar('Ataque', baseStats.attack, 255),
            _buildStatBar('Defensa', baseStats.defence, 255),
            _buildStatBar('Ataque Especial', baseStats.specialAttack, 255),
            _buildStatBar('Defensa Especial', baseStats.specialDefence, 255),
            _buildStatBar('Velocidad', baseStats.speed, 255),
          ]),
        ],
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(String sectionTitle, List<Widget> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        ...stats,
      ],
    );
  }

  Widget _buildStatBar(String label, int value, int maxValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: LinearProgressIndicator(
            value: value / maxValue,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.blue),
            minHeight: 10.0,
          ),
        ),
      ],
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
