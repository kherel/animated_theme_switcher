# Animated_Theme_Switcher v3

This is an updated version that support switching theme mode and switching themes (light and dark). Both examples have been updated too.

This library starts from [Peyman's](https://stackoverflow.com/users/4910935/peyman) stackoverflow question [how-to-add-animation-for-theme-switching-in-flutter](https://stackoverflow.com/questions/60897816/how-to-add-animation-for-theme-switching-in-flutter)

<img src="demo.gif" height="30%" width="30%"/>

## Getting started

Add animated_theme_switcher in your pubspec.yaml dependencies.

```yaml
dependencies:
  animated_theme_switcher:
    git:
      url: https://github.com/mllrr96/animated_theme_switcher.git
```

### Usage Overview

An overview on how to use it

1- Wrap your material app with ThemeProvider.

2- Wrap the screen where you wanna switch theme/theme mode with ThemeSwitchingArea.

3- Wrap every widget that handles theme switching with ThemeSwitcher.

----------------------------------------------------

### Usage 

Import the following package in your dart file

```dart
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
```

1. Wrap MaterialApp with ThemeProvider widget, ThemeProvider requires a ThemeModel to be passed, ThemeModel contains theme mode, light, and dark themes. if you want to persist Theme/mode then here is a good place to provide your saved theme/mode, check the examples for more info

```dart
  ThemeProvider(
      themeModel: ThemeModel(
        themeMode: ThemeMode.system,
        lightTheme: PinkTheme.light,
        darkTheme: PinkTheme.dark,
      ),
      builder: (context, themeModel) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeModel.themeMode,
          theme: themeModel.lightTheme,
          darkTheme: themeModel.darkTheme,
          home: MyHomePage(),
        );
      }),
    ),
```

If you just need to provide a theme to a widget:

```dart
  ThemeProvider(
      themeModel: ThemeModel(
        themeMode: ThemeMode.system,
        lightTheme: PinkTheme.light,
        darkTheme: PinkTheme.dark,
      ),
      child: SomeCoolPage(),
    ),
```

2. Wrap the area where you want to switch themes with ThemeSwitchingArea:


```dart
    ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return ...,
      },
    );
```


3. Wrap widgets that handle theme updates with ThemeSwitcher:

* Update Theme Mode (light, dark, system) 

use ThemeSwitcher.of(context).updateThemeMode() or the shortcut context.updateThemeMode()
Tip: if you want to switch the mode from light to dark or vice versa then use ThemeSwitcher.of(context).toggleThemeMode() or the shortcut context.toggleThemeMode()

Note: To use these methods a ThemeSwitcher widget is required otherwise a null exception will be thrown.

```dart
    ...
    ThemeSwitcher(
      builder: (context) {
        ...
        onTap: () => context.updateThemeMode(
          themeMode: ThemeMode.light,
        );
        ...
      },
    );
```

* Toggle theme mode (Switch from current theme mode to the opposite)

```dart
    ...
    ThemeSwitcher(
      builder: (context) {
        ...
        onTap: () => context.toggleThemeMode();
        ...
      },
    );
```

Alternatively you could use ThemeSwitcher.switcher() or ThemeSwitcher.withThemeModel().  
Builders of this constructors already provide you ThemeSwitcher.  
ThemeSwitcher.withThemeModel() also provides current ThemeModel:

```dart
    ThemeSwitcher.switcher(
      builder: (context, switcher) {
        ...
        onTap: () => switcher.updateThemeMode(
          themeMode: ThemeMode.dark,
        );
        ...
      },
    );
```

```dart
    ThemeSwitcher.withThemeModel(
      builder: (context, switcher, themeModel) {
        ...
        onTap: () {
          final currentLightTheme = themeModel.lightTheme;
          final currentDarkTheme = themeModel.darkTheme;
          final themeMode = themeModel.themeMode;
        }
        ...
      },
    );
```

* Update Theme (light theme, dark theme)

If you want to change the theme of your application then use ThemeSwitcher.of(context).updateTheme() or the shortcut context.updateTheme(), lightTheme and darkTheme are optional, if non provide then the method will not excute.

```dart
    ...
    ThemeSwitcher(
      builder: (context) {
        ...
        onTap: () => context.updateTheme(
          // optional light theme
          lightTheme: newLightTheme,
          // optional dark theme
          darkTheme: newDarkTheme,
          // default is false, Aniamte theme updating, when set to false the default flutter animation will be used
          animateTransition: false   
        );
        ...
      },
    );
```

* Use optional named parameter clipper to pass the custom clippers.

```dart
    ...
    ThemeSwitcher(
      clipper: ThemeSwitcherBoxClipper(),
      builder: (context) {
        ...
      },
    );
```

**Notes:**

1. This package is not intended to persist selected theme on the local device. But we added [special example](https://github.com/mllrr96/animated_theme_switcher/blob/master/example/lib/with_saving_theme.dart) to show how to do it using [shared_preferences](https://pub.dev/packages/shared_preferences) package.

2. Use the CanvasKit rendering engine to use it on **web**, [more about it..](https://github.com/kherel/animated_theme_switcher/issues/23)
