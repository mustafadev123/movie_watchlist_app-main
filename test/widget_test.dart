import 'package:flutter_test/flutter_test.dart';

import 'package:movie_watchlist_app/main.dart';

void main() {
  testWidgets('Movie Watchlist app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieWatchlistApp());

    expect(find.text('REEL ARCHIVE'), findsOneWidget);
    expect(find.text('Stories worth\nwatching.'), findsOneWidget);
    expect(find.text('5 FILMS'), findsOneWidget);
  });
}
