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

  ///
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

// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/services.dart';
// import 'package:yaml/yaml.dart';
//
// //Loader for multiple yaml files
// class YamlAssetLoader extends AssetLoader {
//   const YamlAssetLoader();
//
//   String getLocalePath(String basePath, Locale locale) {
//     return '$basePath/${locale.toStringWithSeparator(separator: "-")}.yaml';
//   }
//
//   @override
//   Future<Map<String, dynamic>> load(String path, Locale locale) async {
//     var localePath = getLocalePath(path, locale);
//     log('easy localization loader: load yaml file $localePath');
//     YamlMap yaml = loadYaml(await rootBundle.loadString(localePath));
//     return convertYamlMapToMap(yaml);
//   }
// }
//
// //Loader for single yaml file
// class YamlSingleAssetLoader extends AssetLoader {
//   Map? yamlData;
//
//   @override
//   Future<Map<String, dynamic>> load(String path, Locale locale) async {
//     if (yamlData == null) {
//       log('easy localization loader: load yaml file $path');
//       yamlData =
//           convertYamlMapToMap(loadYaml(await rootBundle.loadString(path)));
//     } else {
//       log('easy localization loader: Yaml already loaded, read cache');
//     }
//     return yamlData![locale.toString()];
//   }
// }
//
// /// Convert YamlMap to Map
// Map<String, dynamic> convertYamlMapToMap(YamlMap yamlMap) {
//   final map = <String, dynamic>{};
//
//   for (final entry in yamlMap.entries) {
//     if (entry.value is YamlMap || entry.value is Map) {
//       map[entry.key.toString()] = convertYamlMapToMap(entry.value);
//     } else {
//       map[entry.key.toString()] = entry.value.toString();
//     }
//   }
//   return map;
// }
