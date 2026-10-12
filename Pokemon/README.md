# Pokédex

A Flutter Pokémon browser powered by the free [PokéAPI](https://pokeapi.co/).

| Screen | Powered by | What it does |
|---|---|---|
| Pokédex | `FutureBuilder` | Loads the first 30 Pokémon with names and sprites |
| Pokémon Cycle | `StreamBuilder` | Cycles through Pokémon details every 5 seconds |

## Setup
```
flutter create . --project-name iron_log
flutter pub get
```
Run with `flutter run`. Android internet access is enabled in the manifest.

## Structure (Atomic Design)
- `widgets/atoms/` LoadingSpinner, InfoChip, RetryButton, CaptionText
- `widgets/molecules/` ErrorMessage, StatusBanner, PokemonTile
- `widgets/organisms/` PokemonList, PokemonCard
- `widgets/templates/` ScreenTemplate (shared app bar + body layout)
- `pages/` PokedexPage (Future), PokemonCyclePage (Stream), HomePage (tabs)
- `models/` typed `Pokemon` with list and detail JSON parsers
- `services/` http + status check + 10 s timeout

## Airplane-mode test
- Pokédex: error message + Retry button.
- Pokémon Cycle: keeps the last Pokémon with a red banner and retries automatically.
