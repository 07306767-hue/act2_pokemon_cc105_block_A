import 'package:flutter/material.dart';

import '../../models/pokemon.dart';

class PokemonTile extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonTile({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: SizedBox(
          width: 48,
          height: 48,
          child: Image.network(
            pokemon.imageUrl,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.catching_pokemon),
          ),
        ),
        title: Text(pokemon.displayName),
        subtitle: Text('#${pokemon.id.toString().padLeft(3, '0')}'),
      );
}
