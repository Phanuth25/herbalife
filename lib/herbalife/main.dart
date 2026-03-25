import 'package:flutter/material.dart';
import 'package:project2/herbalife/l10n/app_localizations.dart';
import 'package:project2/herbalife/public/widget/welcome.dart';
import 'package:project2/herbalife/public/data/notifier.dart';
import 'package:project2/herbalife/public/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Authprovider()),
        ],
        child: const Main(),
      ),
    );

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
        valueListenable: appLocale,
        builder: (context, value, child) {
          return ValueListenableBuilder<bool>(
              valueListenable: isDark,
              builder: (context, isDarkMode, child) {
                return MaterialApp(
                  useInheritedMediaQuery: true,
                  locale: value,
                  localizationsDelegates: AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.teal,
                      brightness: isDarkMode ? Brightness.dark : Brightness.light,
                    ),
                  ),
                  home: Scaffold(body: Welcome()),
                );
              });
        });
  }
}
