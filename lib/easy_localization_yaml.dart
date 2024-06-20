import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/// Loads a YAML file.
class YamlAssetLoader extends AssetLoader {
  /// The directory for YAML files, from the [package] or app root.
  final String directory;

  /// Whether to ignore errors if a translation is not found.
  /// The default is to throw an exception.
  ///
  /// Set this to true when merging multiple assets from different packages
  /// to allow an app to cover up for a missing translation in a package.
  final bool ignoreErrors;

  /// The package name, null for non-package assets.
  final String? package;

  // ignore: public_member_api_docs
  const YamlAssetLoader({
    required this.directory,
    this.ignoreErrors = false,
    this.package,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Map<String, dynamic>> load(String basePath, Locale locale) async {
    final localePath = getFilePath(locale, basePath: basePath);
    log('easy localization: YamlAssetLoader loading $localePath');

    try {
      final yamlMap = loadYaml(await rootBundle.loadString(localePath));
      return _yamlMapToMap(yamlMap);
      // ignore: avoid_catches_without_on_clauses
    } catch (ex) {
      log(
        'easy localization: YamlAssetLoader ignoring a missing asset $localePath',
      );

      if (ignoreErrors) {
        return const {};
      }

      rethrow;
    }
  }

  /// Returns the file path for the locale.
  String getFilePath(Locale locale, {required String basePath}) {
    if (package == null) {
      return '$directory/$locale.yaml';
    }
    return 'packages/$package/$directory/$locale.yaml';
  }

  Map<String, dynamic> _yamlMapToMap(YamlMap yamlMap) {
    return yamlMap.map(
      (k, v) => MapEntry(
        k.toString(),
        v is YamlMap ? _yamlMapToMap(v) : v.toString(),
      ),
    );
  }
}
