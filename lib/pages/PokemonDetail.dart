import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Evoluciones.dart';
import 'package:pokedex_final_proyect/Entitys/Hability.dart';
import 'package:pokedex_final_proyect/Entitys/Pokemon.dart';

import '../services/FavoritePokemonService.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon? pokemon;
  final Color? backgroundColor;
  final bool isFavorite;
  final List<Hability> pokemonSkills;
  final EvolutionChain pokemonEvolution;

  PokemonDetail({
    Key? key,
    required this.pokemon,
    this.backgroundColor,
    this.isFavorite = false,
    required this.pokemonSkills,
    required this.pokemonEvolution,
  }) : super(key: key);

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  final TextStyle _textStyle = const TextStyle(
    fontFamily: 'Google Sans',
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final textColor = widget.backgroundColor == Colors.white || widget.backgroundColor == Colors.yellow
        ? Colors.black
        : Colors.white;
    final tabLabelColor = widget.backgroundColor ?? Colors.blue; // Color del AppBar

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(300.0),
          child: AppBar(
            backgroundColor: widget.backgroundColor,
            elevation: 0,
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Image.asset(
                    widget.backgroundColor == Colors.white || widget.backgroundColor == Colors.yellow
                        ? 'assets/pokeballblack.png'
                        : 'assets/pokeball.png',
                    height: 300,
                    width: 550,
                    fit: BoxFit.cover,
                  ),
                ),
                Image.network(
                  widget.pokemon?.image ?? '',
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
                          '#${widget.pokemon?.id}',
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
                          capitalize(widget.pokemon?.name ?? ''),
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
                                  for (var tipo in widget.pokemon?.types ?? [])
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
                Positioned(
                  top: 15,
                  right: 15,
                  child: _buildFavoriteButton(),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: widget.backgroundColor,
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
                        "Habilidades",
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
                      PokemonDetailSobre(pokemon: widget.pokemon, color: widget.backgroundColor),
                      PokemonDetailEvolucao(pokemonEvolution: widget.pokemonEvolution),
                      PokemonDetailHability(pokemonHabilities: widget.pokemonSkills, color: widget.backgroundColor),
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
    return GestureDetector(
      onTap: () {
        FavoritePokemonService favService = FavoritePokemonService();
        favService.addToFavorites(widget.pokemon!.name);
        setState(() {
          widget.pokemon!.isFavorite = !widget.pokemon!.isFavorite;
        });
      },
      child: Icon(
        widget.pokemon!.isFavorite ? Icons.star : Icons.star_border,
        color: widget.pokemon!.isFavorite || widget.backgroundColor == Colors.yellow
            ? Colors.orange
            : Colors.orange,
        size: 49.0,
      ),
    );
  }

  String capitalize(String text) {
    return text.isNotEmpty ? text[0].toUpperCase() + text.substring(1) : text;
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
  final EvolutionChain pokemonEvolution;

  const PokemonDetailEvolucao({Key? key, required this.pokemonEvolution}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildEvolutionChain(pokemonEvolution.chain),
        ],
      ),
    );
  }

  Widget _buildEvolutionChain(EvolutionChainNode chainNode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNode(chainNode),
        const SizedBox(height: 16),
        if (chainNode.evolvesTo.isNotEmpty)
          for (var evolvesToNode in chainNode.evolvesTo) _buildEvolutionChain(evolvesToNode),
      ],
    );
  }

  Widget _buildNode(EvolutionChainNode node) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Species: ${node.speciesName}',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('Is Baby: ${node.isBaby}'),
        Text('Evolution Details: ${_formatEvolutionDetails(node.evolutionDetails)}'),
      ],
    );
  }

  String _formatEvolutionDetails(List<EvolutionDetails> details) {
    return details.map((detail) => '${detail.minLevel} ${detail.triggerName} ${detail.triggerUrl}').join(', ');
  }
}

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

