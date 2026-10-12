import 'package:flutter_test/flutter_test.dart';
import 'package:iron_log/main.dart';

void main() {
  testWidgets('app builds with Pokédex and Pokémon Cycle tabs', (tester) async {
    await tester.pumpWidget(const PokemonApp());
    expect(find.text('Pokédex'), findsWidgets);
    expect(find.text('Pokémon Cycle'), findsOneWidget);
  });
}
