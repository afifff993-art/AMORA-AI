import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/settings/settings_controller.dart';
import 'core/theme/amora_theme.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await SettingsController.load();
  runApp(AmoraApp(settings: settings));
}

class AmoraApp extends StatelessWidget {
  const AmoraApp({super.key, required this.settings});

  final SettingsController settings;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsController>.value(
      value: settings,
      child: Consumer<SettingsController>(
        builder: (context, s, _) => MaterialApp(
          title: 'AMORA',
          debugShowCheckedModeBanner: false,
          theme: AmoraTheme.light(),
          darkTheme: AmoraTheme.dark(),
          themeMode: s.themeMode,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
