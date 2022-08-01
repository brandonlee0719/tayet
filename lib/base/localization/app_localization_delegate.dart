import '../app_lib.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  final Locale overriderLocale;

  const AppLocalizationDelegate(this.overriderLocale);

  @override
  bool isSupported(Locale locale) => overriderLocale != null
      ? true
      : ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) async {
    if (overriderLocale != null) {
      locale = overriderLocale;
    } else {
      locale = Constants.english;
    }
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => overriderLocale != null;
}
