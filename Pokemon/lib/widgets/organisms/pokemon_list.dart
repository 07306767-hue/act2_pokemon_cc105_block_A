import 'package:flutter/material.dart';

import '../../models/pokemon.dart';
import '../molecules/pokemon_tile.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemon;
  const PokemonList({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon.isEmpty) {
      return const Center(child: Text('No Pokémon found.'));
    }
    return ListView.separated(
      itemCount: pokemon.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, index) => PokemonTile(pokemon: pokemon[index]),
    );
  }
}
