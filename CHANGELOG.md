## 0.1.0

Initial release.

Changes over [easy_localization_loader](https://pub.dev/packages/easy_localization_loader):
* **BREAKING:** Locale-specific files use the standard underscore separator (`en_US`) instead of
  easy_localization_loader's non-standard dash (`en-US`).
* **BREAKING:** Added the required `directory` parameter, ignoring
  [EasyLocalization.path](https://pub.dev/documentation/easy_localization/latest/easy_localization/EasyLocalization/path.html).
  This is to support loading multiple asset files with [easy_localization_multi](https://pub.dev/packages/easy_localization_multi) package.
  Use this to merge localizations for multiple Flutter packages.
* Added `package` argument to support loading assets from packages and not only the app's root.
* `YamlAssetLoader` extends the `AssetLoader` from [easy_localization](https://pub.dev/packages/easy_localization).
