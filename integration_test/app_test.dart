import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:music_app/main.dart' as app;
import 'package:music_app/presentation/pages/album_details_page.dart';
import 'package:music_app/presentation/pages/search_page.dart';
import 'package:music_app/presentation/widgets/album_widget.dart';
import 'package:music_app/presentation/widgets/appbar_search_button.dart';
import 'package:music_app/presentation/widgets/tite_description_widget.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Open album details page, verify content',
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
          await tester.tap(find.widgetWithText(AlbumsWidget, 'Arrival'));
          await tester.pumpAndSettle();

          expect(find.byType(AlbumDetailsPage), findsOneWidget);
          expect(find.widgetWithText(TitleDescriptionWidget, 'Album'), findsOneWidget);
          expect(find.widgetWithText(TitleDescriptionWidget, 'Arrival'), findsOneWidget);
          expect(find.widgetWithText(TitleDescriptionWidget, 'Artist'), findsOneWidget);
          expect(find.widgetWithText(TitleDescriptionWidget, 'ABBA'), findsOneWidget);

          // TODO: it seems like pumpAndSettle don't wait for this content being loaded, additional research required
          // expect(find.widgetWithText(TitleDescriptionWidget, 'Arrival Tracks:'), findsOneWidget);
          // expect(find.text('1-When I Kissed the Teacher'), findsOneWidget);
        });
  });
}