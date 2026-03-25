import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project2/auth_provider.dart';
import 'package:project2/language_provider.dart';
import 'package:project2/youtube/welcome.dart';
import 'package:project2/data/notifier.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project2/l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
        child: const WidgetTree(),
      ),
    ),
  );
}

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  void initState() {
    savedata();
    tryAutoLogin();
    super.initState();
  }

  void savedata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('isDarkMode');
    isDarkMode.value = repeat ?? true;
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user_token')) {
      var userEmail = prefs.getString('user_email');
      token.value = userEmail ?? "";
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_token');
    prefs.remove('user_email');
    token.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, currentAppLocale, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isDarkMode,
          builder: (context, isDark, child) {
            return MaterialApp(
              useInheritedMediaQuery: true,
              locale: currentAppLocale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: DevicePreview.appBuilder,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.teal,
                  brightness: isDark ? Brightness.dark : Brightness.light,
                ),
              ),
              home: Scaffold(
                drawer: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Drawer(
                    backgroundColor: Colors.orange,
                    child: Column(
                      children: [
                        DrawerHeader(
                          decoration: const BoxDecoration(),
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 25 / 9,
                              child: Image.asset("assets/images/setting.png"),
                            ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            return Expanded(
                              child: ListView(
                                padding: const EdgeInsets.only(top: 200),
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    title: TextButton(
                                      onPressed: () async {
                                        logout();
                                        final prefs =
                                            await SharedPreferences.getInstance();
                                        if (!prefs.containsKey('user_token')) {
                                          return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Logged out'),
                                                content: const Text(
                                                  'You have been successfully logged out.',
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Log out',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                appBar: AppBar(
                  title: const Text("Flutter"),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        isDarkMode.value = !isDarkMode.value;
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool('isDarkMode', isDarkMode.value);
                      },
                      icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
                    ),
                    DropdownButton(hint: const Text("Select Language"),
                      items: [
                        DropdownMenuItem(
                          child: Text("English 🇺🇸"),
                          value: const Locale("en"),
                        ),
                        DropdownMenuItem(
                          child: Text("Khmer 🇰🇭"),
                          value: const Locale("km"),
                        ),
                      ],
                      onChanged: (value) {
                        if(value != null)
                        updateLanguage(value.languageCode);
                      },
                    ),
                  ],
                ),
                body: const Welcome(),
              ),
            );
          },
        );
      },
    );
  }
}
