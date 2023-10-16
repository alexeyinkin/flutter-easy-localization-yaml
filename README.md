[![Pub Package](https://img.shields.io/pub/v/easy_localization_yaml.svg)](https://pub.dev/packages/easy_localization_yaml)
[![GitHub](https://img.shields.io/github/license/alexeyinkin/flutter-easy-localization-yaml)](https://github.com/alexeyinkin/flutter-easy-localization-yaml/blob/main/LICENSE)
[![CodeFactor](https://img.shields.io/codefactor/grade/github/alexeyinkin/flutter-easy-localization-yaml?style=flat-square)](https://www.codefactor.io/repository/github/alexeyinkin/flutter-easy-localization-yaml)
[![Support Chat](https://img.shields.io/badge/support%20chat-telegram-brightgreen)](https://ainkin.com/chat)

`YamlAssetLoader` that replaces the one from
[easy_localization_loader](https://pub.dev/packages/easy_localization_loader) package.
It allows you to drop unwanted dependencies from importing many other loaders you do not use.

It also has the `package` argument for assets from packages.

## Example

Follow the easy_localization docs except adding the loader:

```dart
runApp(
  EasyLocalization(
    assetLoader: const YamlAssetLoader(directory: 'assets/translations'), // NEW
    fallbackLocale: const Locale('en'),
    path: 'unused',
    startLocale: const Locale('en'),
    supportedLocales: const [Locale('en')],
    child: MyApp(),
  ),
);
```

## Tech Support, Jobs, and Education

Please join my Telegram channel for announcements, Flutter jobs, articles, talks, and more:
[@ainkin_com](https://t.me/ainkin_com)

Do you have any questions? Feel free to ask in the [Telegram Support Chat](https://ainkin.com/chat).

Or even just join to say 'Hi!'. I like to hear from the users.
