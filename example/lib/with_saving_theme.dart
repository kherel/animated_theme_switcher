import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'theme_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  runApp(MyApp(theme: initTheme));
}

class ThemeService {
  ThemeService._();
  static late SharedPreferences prefs;
  static ThemeService? _instance;

  static Future<ThemeService> get instance async {
    if (_instance == null) {
      prefs = await SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance!;
  }

  final allThemes = <String, ThemeData>{
    'dark': darkTheme,
    'light': lightTheme,
    'pink': pinkTheme,
    'darkBlue': darkBlueTheme,
    'halloween': halloweenTheme,
  };

  String get previousThemeName {
    String? themeName = prefs.getString('previousThemeName');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'light' : 'dark';
    }
    return themeName;
  }

  get initial {
    String? themeName = prefs.getString('theme');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'dark' : 'light';
    }
    return allThemes[themeName];
  }

  save(String newThemeName) {
    var currentThemeName = prefs.getString('theme');
    if (currentThemeName != null) {
      prefs.setString('previousThemeName', currentThemeName);
    }
    prefs.setString('theme', newThemeName);
  }

  ThemeData getByName(String name) {
    return allThemes[name]!;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.theme,
  }) : super(key: key);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      builder: (_, theme) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        drawer: Drawer(
          child: SafeArea(
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: ThemeSwitcher(
                    builder: (context) {
                      return IconButton(
                        onPressed: () async {
                          var themeName =
                              ThemeModelInheritedNotifier.of(context)
                                          .theme
                                          .brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                        icon: const Icon(Icons.brightness_3, size: 25),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Flutter Demo Home Page',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: const TextStyle(fontSize: 200),
              ),
              CheckboxListTile(
                title: const Text('Slow Animation'),
                value: timeDilation == 5.0,
                onChanged: (value) {
                  setState(() {
                    timeDilation = value! ? 5.0 : 1.0;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherBoxClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: const Text('Box Animation'),
                        onPressed: () async {
                          var themeName =
                              ThemeModelInheritedNotifier.of(context)
                                          .theme
                                          .brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    clipper: const ThemeSwitcherCircleClipper(),
                    builder: (context) {
                      return OutlinedButton(
                        child: const Text('Circle Animation'),
                        onPressed: () async {
                          var themeName =
                              ThemeModelInheritedNotifier.of(context)
                                          .theme
                                          .brightness ==
                                      Brightness.light
                                  ? 'dark'
                                  : 'light';
                          var service = await ThemeService.instance
                            ..save(themeName);
                          var theme = service.getByName(themeName);
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            pinkTheme,
                        onChanged: (needPink) async {
                          var service = await ThemeService.instance;
                          ThemeData theme;

                          if (needPink!) {
                            service.save('pink');
                            theme = service.getByName('pink');
                          } else {
                            var previousThemeName = service.previousThemeName;
                            service.save(previousThemeName);
                            theme = service.getByName(previousThemeName);
                          }
                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            darkBlueTheme,
                        onChanged: (needDarkBlue) async {
                          var service = await ThemeService.instance;
                          ThemeData theme;

                          if (needDarkBlue!) {
                            service.save('darkBlue');
                            theme = service.getByName('darkBlue');
                          } else {
                            var previousThemeName = service.previousThemeName;
                            service.save(previousThemeName);
                            theme = service.getByName(previousThemeName);
                          }

                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                  ThemeSwitcher(
                    builder: (context) {
                      return Checkbox(
                        value: ThemeModelInheritedNotifier.of(context).theme ==
                            halloweenTheme,
                        onChanged: (needHalloween) async {
                          var service = await ThemeService.instance;
                          ThemeData theme;

                          if (needHalloween!) {
                            service.save('halloween');
                            theme = service.getByName('halloween');
                          } else {
                            var previousThemeName = service.previousThemeName;
                            service.save(previousThemeName);
                            theme = service.getByName(previousThemeName);
                          }

                          ThemeSwitcher.of(context).changeTheme(theme: theme);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
