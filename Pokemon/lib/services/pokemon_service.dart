  import 'dart:async';

import '../models/pokemon.dart';
import 'api_client.dart';

const _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

Future<List<Pokemon>> fetchPokemonList({int limit = 30}) async {
  final body = await getJson('$_baseUrl?limit=$limit&offset=0');
  try {
    final map = body as Map<String, dynamic>;
    final results =
        (map['results'] as List<dynamic>).cast<Map<String, dynamic>>();
    return results.map(Pokemon.fromListJson).toList();
  } on FormatException {
    rethrow;
  } catch (_) {
    throw const ApiException('Pokémon list data was in an unexpected format.');
  }
}

Future<Pokemon> fetchPokemon(int id) async {
  final body = await getJson('$_baseUrl/$id');
  try {
    return Pokemon.fromDetailJson(body as Map<String, dynamic>);
  } on FormatException {
    rethrow;
  } catch (_) {
    throw const ApiException('Pokémon details were in an unexpected format.');
  }
}

Stream<PokemonUpdate> pokemonCycleStream() {
  final controller = StreamController<PokemonUpdate>();
  Timer? timer;
  var cancelled = false;
  var fetching = false;
  List<Pokemon>? pokedex;
  var nextIndex = 0;

  Future<void> emitNext() async {
    if (cancelled || fetching) return;
    fetching = true;
    try {
      final availablePokemon =
          pokedex ??= await fetchPokemonList(limit: 100000);
      if (availablePokemon.isEmpty) {
        throw const ApiException('PokéAPI returned no Pokémon.');
      }
      final pokemon = await fetchPokemon(availablePokemon[nextIndex].id);
      if (cancelled) return;
      controller.add(PokemonUpdate.ok(pokemon));
      nextIndex = (nextIndex + 1) % availablePokemon.length;
    } catch (error) {
      if (!cancelled) controller.add(PokemonUpdate.failed(error.toString()));
    } finally {
      fetching = false;
    }
  }

  controller
    ..onListen = () {
      unawaited(emitNext());
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        unawaited(emitNext());
      });
    }
    ..onCancel = () {
      cancelled = true;
      timer?.cancel();
    };
  return controller.stream;
}
