import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/atoms/loading_spinner.dart';
import '../widgets/molecules/error_message.dart';
import '../widgets/molecules/status_banner.dart';
import '../widgets/organisms/pokemon_card.dart';
import '../widgets/templates/screen_template.dart';

class PokemonCyclePage extends StatefulWidget {
  const PokemonCyclePage({super.key});

  @override
  State<PokemonCyclePage> createState() => _PokemonCyclePageState();
}

class _PokemonCyclePageState extends State<PokemonCyclePage> {
  late final Stream<PokemonUpdate> _stream = pokemonCycleStream();
  PokemonUpdate? _lastGood;

  String _clock(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}:'
      '${time.second.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Pokémon Cycle',
      body: StreamBuilder<PokemonUpdate>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return _stuck('${snapshot.error}');
          if (!snapshot.hasData) return const LoadingSpinner();

          final update = snapshot.data!;
          if (update.pokemon != null) _lastGood = update;
          if (_lastGood == null) return _stuck(update.error ?? 'Unknown error');

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (update.error != null)
                StatusBanner(
                  title: update.error!,
                  subtitle: 'Showing the last Pokémon. Retrying...',
                ),
              PokemonCard(
                pokemon: _lastGood!.pokemon!,
                footer: 'Next Pokémon every 5 s  |  updated '
                    '${_clock(_lastGood!.at)}',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _stuck(String message) => ErrorMessage(
        icon: Icons.catching_pokemon,
        message: message,
        footer: 'Trying again every 5 seconds...',
      );
}
