import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/search_page.dart';
import 'package:music_app/presentation/widgets/album_widget.dart';
import 'package:music_app/presentation/widgets/appbar_search_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Add an album to favorites, verify its display on the homepage',
            (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppbarSearchButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), "ABBA");
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppbarSearchButton));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ArtistWidget, 'ABBA'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.widgetWithText(AlbumsWidget, 'Arrival'),
          matching: find.byType(FavoriteButton)));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AlbumsWidget, 'Arrival'), findsOneWidget);
      expect(find.text("No Albums added yet"), findsNothing);

      await tester.tap(find.descendant(of: find.widgetWithText(AlbumsWidget, 'Arrival'),
          matching: find.byType(FavoriteButton)));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AlbumsWidget, 'Arrival'), findsNothing);
      expect(find.text("No Albums added yet"), findsOneWidget);
    });
  });
}