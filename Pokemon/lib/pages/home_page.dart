import 'package:flutter/material.dart';

import 'pokemon_cycle_page.dart';
import 'pokedex_page.dart';

/// Page shell: bottom navigation between the two pages.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;
  bool _cycleVisited = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps each page's Future/Stream alive between tabs.
      body: IndexedStack(
        index: _tab,
        children: [
          const PokedexPage(),
          _cycleVisited ? const PokemonCyclePage() : const SizedBox.shrink(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() {
          _tab = i;
          if (i == 1) _cycleVisited = true;
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokédex',
          ),
          NavigationDestination(
            icon: Icon(Icons.autorenew),
            label: 'Pokémon Cycle',
          ),
        ],
      ),
    );
  }
}
