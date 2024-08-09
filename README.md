# Check Dependency

Este projeto verifica e remove dependências não utilizadas em um arquivo `pubspec.yaml` de um projeto Dart/Flutter.

## Instalação

1. Clone o repositório:
   ```sh
   git clone <URL_DO_REPOSITORIO>
   ```
2. Navegue até o diretório do projeto:
   ```sh
   cd <DIRETORIO_DO_PROJETO>
   ```
3. Instale as dependências necessárias:
   ```sh
   dart pub get
   ```

## Uso

Para utilizar o script, execute o comando abaixo no terminal:

```sh
dart run check_dependency.dart --path <CAMINHO_DO_ARQUIVO_PUBSPEC>
```

Caso queira que além de indicar as dependências remova adicione

```sh
dart run check_dependency.dart --path <CAMINHO_DO_ARQUIVO_PUBSPEC> --remove-unused <true>

```
