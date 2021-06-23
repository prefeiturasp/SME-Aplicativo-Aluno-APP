import 'package:email_validator/email_validator.dart';
import 'package:intl/intl.dart';

class ValidatorsUtil {
  static String telefone(String value) {
    if (value.isEmpty) {
      return "O telefone deve ser informado";
    }
    var checarInicial = value.split(" ");
    if (checarInicial.length > 1) {
      if (checarInicial[1].substring(0, 1) != "9") {
        return "O telefone deve iniciar com o dígito 9";
      }
    }

    value = value.replaceAll("(", "");
    value = value.replaceAll(")", "");
    value = value.replaceAll(" ", "");
    value = value.replaceAll("-", "");
    RegExp regExp = new RegExp(
      r"([0-9])\1{8}",
      caseSensitive: false,
      multiLine: false,
    );

    if (regExp.hasMatch(value) || value.length < 11) {
      return "O telefone está incorreto";
    }
    return null;
  }

  static String nomeMae(String value) {
    RegExp regExp = new RegExp(
      r"(\w)\1\1",
      caseSensitive: false,
      multiLine: false,
    );

    if (regExp.hasMatch(value)) {
      return "Nome da mãe não pode conter caracteres repetidos";
    }

    if (value.isEmpty) {
      return "Nome da mãe deve ser informado";
    }

    value = value.replaceAll(".", "");
    var nomeMaeValidador = value.split(" ");
    if (nomeMaeValidador.length > 0) {
      for (var i = 0; i < nomeMaeValidador.length; i++) {
        if (nomeMaeValidador[i].length == 1 &&
            nomeMaeValidador[i].toLowerCase() != "e") {
          return "Nome da mãe não pode ser abreviado";
        }
        print(nomeMaeValidador[i].length);
      }
    }
    return null;
  }

  static String dataNascimento(String value) {
    if (value.isEmpty) {
      return "Data de nascimento deve ser informada";
    }

    var dataSeparada = value.split("/");

    if (DateTime.tryParse(
            "${dataSeparada[2]}${dataSeparada[1]}${dataSeparada[0]}") ==
        null) {
      return "Data de nascimento com formato inválido";
    }

    var data = DateFormat('dd/MM/yyyy').parse(value);

    if (data.isBefore(DateTime.parse('19300101'))) {
      return "Data inválida";
    }

    if (data.isAfter(DateTime.now())) {
      return "Data não pode ser superior a data atual";
    }

    return null;
  }

  static String email(String value) {
    if (value.isEmpty) {
      return "O e-mail deve ser informado";
    }

    if (!EmailValidator.validate(value)) {
      return 'E-mail inválido';
    }

    return null;
  }
}
