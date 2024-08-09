import 'dart:io';
import 'package:ansicolor/ansicolor.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

void checkDependency(String path, {bool removeUnused = false}) async {
  var redPen = AnsiPen()..red();
  var greenPen = AnsiPen()..green();
  var yellowPen = AnsiPen()..yellow();

  final file = File('$path/pubspec.yaml');
  if (!file.existsSync()) {
    print(redPen('Arquivo pubspec.yaml não encontrado'));
    return;
  }
  print(greenPen('Iniciando a verificação de dependências'));
  await Future.delayed(Duration(seconds: 1));
  final content = await file.readAsString();
  final yaml = loadYaml(content);

  final dependencies = Map<String, dynamic>.from(yaml['dependencies']);
  print(greenPen('Dependências encontradas: ${dependencies.keys}\nIniciando a verificação de pacotes não utilizados'));
  final libDir = Directory('$path/lib');
  if (!libDir.existsSync()) {
    print(redPen('Diretório lib não encontrado'));
    return;
  }
  await Future.delayed(Duration(seconds: 1));

  final dartFiles = libDir.listSync(recursive: true).where((file) => file.path.endsWith('.dart'));

  final unusedPackages = dependencies.keys.where((pkg) {
    return !dartFiles.any((file) {
      final content = File(file.path).readAsStringSync();
      return content.contains("package:$pkg/");
    });
  }).toList();

  print(yellowPen('Pacotes não utilizados: ${unusedPackages.join('\n')}'));

  if (removeUnused && unusedPackages.isNotEmpty) {
    unusedPackages.forEach(dependencies.remove);
    final updatedYaml = Map<String, dynamic>.from(yaml);
    updatedYaml['dependencies'] = dependencies;

    final yamlWriter = YamlWriter();
    final newYamlContent = yamlWriter.write(updatedYaml);
    await file.writeAsString(newYamlContent);

    print(greenPen('Dependências não utilizadas removidas e pubspec.yaml atualizado.'));
  }
}
