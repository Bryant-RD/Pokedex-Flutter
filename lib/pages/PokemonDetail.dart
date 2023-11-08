import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon? pokemon;
  final Color? backgroundColor;

  const PokemonDetail({Key? key, required this.pokemon, this.backgroundColor}) : super(key: key);

  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
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
                          style: _textStyle.copyWith(color: textColor),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${pokemon?.name}',
                          style: _textStyle.copyWith(color: textColor),
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
                                style: _textStyle.copyWith(color: textColor),
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
            PokemonDetailSobre(pokemon: pokemon, color: backgroundColor),
            const PokemonDetailEvolucao(),
            const PokemonDetailStatus(),
          ],
        ),
      ),
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

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildStatRow('assets/alturaicon.png', 'Altura', '${(pokemon?.height ?? 0) / 10} m'),
          const SizedBox(height: 16),
          _buildStatRow('assets/pesoicon.png', 'Peso', '${(pokemon?.weight ?? 0) / 10} kg'),
          const SizedBox(height: 16),
          if (baseStats != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatBar('HP', baseStats.hp, 255),
                const SizedBox(height: 16),
                _buildStatBar('Ataque', baseStats.attack, 255),
                const SizedBox(height: 16),
                _buildStatBar('Defensa', baseStats.defence, 255),
                const SizedBox(height: 16),
                _buildStatBar('Ataque Especial', baseStats.specialAttack, 255),
                const SizedBox(height: 16),
                _buildStatBar('Defensa Especial', baseStats.specialDefence, 255),
                const SizedBox(height: 16),
                _buildStatBar('Velocidad', baseStats.speed, 255),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String icon, String label, String value) {
    return Row(
      children: [
        Image.asset(icon, width: 42, height: 42),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStatBar(String label, int value, int maxValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: $value/$maxValue',
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
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
