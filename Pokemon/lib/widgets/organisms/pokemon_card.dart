import 'package:flutter/material.dart';

import '../../models/pokemon.dart';
import '../atoms/caption_text.dart';
import '../atoms/info_chip.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final String footer;
  const PokemonCard({super.key, required this.pokemon, required this.footer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                pokemon.imageUrl,
                height: 220,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox(
                  height: 220,
                  child: Center(child: Icon(Icons.catching_pokemon, size: 96)),
                ),
              ),
            ),
            Text(
              '#${pokemon.id.toString().padLeft(3, '0')}  ${pokemon.displayName}',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final type in pokemon.types)
                  InfoChip(label: _capitalize(type)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Height  ${(pokemon.height / 10).toStringAsFixed(1)} m'
              '    Weight  ${(pokemon.weight / 10).toStringAsFixed(1)} kg',
            ),
            if (pokemon.abilities.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                  'Abilities: ${pokemon.abilities.map(_capitalize).join(', ')}'),
            ],
            if (pokemon.stats.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Base stats', style: theme.textTheme.titleMedium),
              const SizedBox(height: 6),
              for (final stat in pokemon.stats.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Expanded(child: Text(_capitalize(stat.key))),
                      SizedBox(
                        width: 40,
                        child: Text(
                          '${stat.value}',
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            const Divider(height: 28),
            CaptionText(footer),
          ],
        ),
      ),
    );
  }

  String _capitalize(String text) =>
      text.isEmpty ? text : '${text[0].toUpperCase()}${text.substring(1)}';
}
