import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/pokemon_service.dart';
import '../widgets/atoms/loading_spinner.dart';
import '../widgets/molecules/error_message.dart';
import '../widgets/organisms/pokemon_list.dart';
import '../widgets/templates/screen_template.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late Future<List<Pokemon>> _pokemonFuture;

  @override
  void initState() {
    super.initState();
    _pokemonFuture = fetchPokemonList();
  }

  void _retry() => setState(() => _pokemonFuture = fetchPokemonList());

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(
      title: 'Pokédex',
      body: FutureBuilder<List<Pokemon>>(
        future: _pokemonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSpinner();
          }
          if (snapshot.hasError) {
            return ErrorMessage(
              icon: Icons.catching_pokemon,
              message: '${snapshot.error}',
              onRetry: _retry,
            );
          }
          return PokemonList(pokemon: snapshot.data ?? const []);
        },
      ),
    );
  }
}
