import 'brand_theme_config.dart';
import 'brand_theme_model.dart';

enum BrandThemeKey { light, dark }

class BrandThemes {
  static BrandThemeModel getThemeFromKey(BrandThemeKey themeKey) {
    switch (themeKey) {
      case BrandThemeKey.light:
        return lightBrandTheme;
      case BrandThemeKey.dark:
        return darkBrandTheme;
      default:
        return lightBrandTheme;
    }
  }
}
