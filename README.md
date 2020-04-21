# SME-Aplicativo-Aluno-APP


### Desenvolvimento

Para iniciar o desenvolvimento da aplicação primeiro você precisa ter o Flutter instalado. A versão utilizada atualmente é a `v1.12.13+hotfix.8`.
Depois é preciso obter os pacotes (dependências) do dart:

> flutter pub get

A aplicação utiliza o recurso de generators do Flutter, logo precisamos rodar o `build_runner` para gerar os códigos necessários para o desenvolvimento.

> flutter pub run build_runner build

Para compilar a versão com mock:

> flutter build apk -t lib/main.mock.dart
Para compilar a versão release:

> flutter build apk -t lib/main.dart
