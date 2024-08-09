import 'dart:io';
import 'package:yaml/yaml.dart';

void main() {
  final file = File('pubspec.yaml');
  final content = file.readAsStringSync();
  final yaml = loadYaml(content);

  final dependencies = Map<String, dynamic>.from(yaml['dependencies']);
  print('Dependências encontradas: ${dependencies.keys}');
}
