class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int height;
  final int weight;
  final Map<String, int> stats;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.types = const [],
    this.abilities = const [],
    this.height = 0,
    this.weight = 0,
    this.stats = const {},
  });

  String get displayName => name
      .split('-')
      .map((part) => part.isEmpty
          ? part
          : '${part[0].toUpperCase()}${part.substring(1)}')
      .join(' ');

  factory Pokemon.fromListJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'];
    if (name is! String || url is! String) {
      throw const FormatException('Pokémon list entry is incomplete.');
    }
    final match = RegExp(r'/pokemon/(\d+)/?$').firstMatch(url);
    final id = int.tryParse(match?.group(1) ?? '');
    if (id == null) {
      throw const FormatException('Pokémon list entry has an invalid URL.');
    }

    return Pokemon(
      id: id,
      name: name,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  factory Pokemon.fromDetailJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    if (id is! int || name is! String) {
      throw const FormatException('Pokémon details are incomplete.');
    }

    final rawTypes = json['types'];
    final rawAbilities = json['abilities'];
    final rawStats = json['stats'];
    if (rawTypes is! List ||
        rawAbilities is! List ||
        rawStats is! List ||
        json['height'] is! int ||
        json['weight'] is! int) {
      throw const FormatException('Pokémon details have an unexpected format.');
    }

    return Pokemon(
      id: id,
      name: name,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
      types: rawTypes.map((item) {
        final type = (item as Map<String, dynamic>)['type'];
        return (type as Map<String, dynamic>)['name'] as String;
      }).toList(),
      abilities: rawAbilities.map((item) {
        final ability = (item as Map<String, dynamic>)['ability'];
        return (ability as Map<String, dynamic>)['name'] as String;
      }).toList(),
      height: json['height'] as int,
      weight: json['weight'] as int,
      stats: {
        for (final item in rawStats)
          (item as Map<String, dynamic>)['stat']['name'] as String:
              item['base_stat'] as int,
      },
    );
  }
}

class PokemonUpdate {
  final Pokemon? pokemon;
  final String? error;
  final DateTime at;

  PokemonUpdate.ok(this.pokemon)
      : error = null,
        at = DateTime.now();

  PokemonUpdate.failed(this.error)
      : pokemon = null,
        at = DateTime.now();
}
