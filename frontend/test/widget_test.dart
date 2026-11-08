import 'package:amora/core/settings/settings_controller.dart';
import 'package:amora/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('home screen shows AMORA and switches orb preview state',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final settings = (await tester.runAsync(SettingsController.load))!;

    await tester.pumpWidget(AmoraApp(settings: settings));
    // The orb animates forever, so never use pumpAndSettle here.
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('AMORA'), findsOneWidget);
    expect(find.byType(ChoiceChip), findsNWidgets(5));

    final listening = find.widgetWithText(ChoiceChip, 'Listening');
    await tester.ensureVisible(listening);
    await tester.tap(listening);
    await tester.pump(const Duration(milliseconds: 300));

    final label = tester.widget<Text>(find.byKey(const Key('orb-state-label')));
    expect(label.data, 'Listening');
  });
}
