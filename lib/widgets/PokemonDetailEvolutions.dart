import 'package:flutter/material.dart';
import 'package:pokedex_final_proyect/Entitys/Evoluciones.dart';

class PokemonDetailEvolutions extends StatelessWidget {
  final EvolutionChain pokemonEvolution;

  const PokemonDetailEvolutions({Key? key, required this.pokemonEvolution}) : super(key: key);

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
          style: const TextStyle(
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