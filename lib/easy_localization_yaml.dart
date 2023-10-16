import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

/// Loads a YAML file.
class YamlAssetLoader extends AssetLoader {
  /// The package name, null for non-package assets.
  final String? package;

  /// The directory for YAML files, from the [package] or app root.
  final String directory;

  // ignore: public_member_api_docs
  const YamlAssetLoader({
    required this.directory,
    this.package,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Map<String, dynamic>> load(String basePath, Locale locale) async {
    final localePath = getFilePath(locale, basePath: basePath);
    log('easy localization: YamlAssetLoader loading $localePath');
    final yamlMap = loadYaml(await rootBundle.loadString(localePath));
    return _yamlMapToMap(yamlMap);
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
