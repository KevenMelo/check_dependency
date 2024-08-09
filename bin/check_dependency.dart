import 'package:ansicolor/ansicolor.dart';
import 'package:args/args.dart';
import 'package:check_dependency/check_dependency.dart';

void main(List<String> arguments) async {
  var redPen = AnsiPen()..red();

  final parser = ArgParser();
  parser.addOption('path', abbr: 'p', help: 'Caminho do arquivo pubspec.yaml');
  parser.addOption('remove-unused', abbr: 'r', help: 'Remover dependências não utilizadas', defaultsTo: 'false');
  final argResults = parser.parse(arguments);
  final path = argResults['path'] as String?;
  bool contains = argResults.arguments.contains('--remove-unused');

  final removeUnused = contains ? bool.tryParse(argResults['remove-unused']) : false;
  if (path == null) {
    print(redPen('Caminho do arquivo pubspec.yaml não informado'));
    return;
  }

  checkDependency(path, removeUnused: removeUnused ?? false);
}
