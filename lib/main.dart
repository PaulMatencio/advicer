import 'package:advicer/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '2_application/core/services/theme_service.dart';
import '2_application/pages/advice/advice_page.dart';
import 'injection.dart' as di; // di = dependency injection

void main() async {  //!  must be async  because of the injection container
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, themeService, child) {
      return MaterialApp(
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const AdvicerPageWrapperProvider(),   //!advice_page.dart
      );
    });
  }
}
