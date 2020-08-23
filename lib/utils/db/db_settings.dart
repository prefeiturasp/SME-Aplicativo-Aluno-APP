const String DATABASE_NAME = "escola_aqui.db";
const String TB_USER = "users";
const String CREATE_TABLE_SCRIPT =
    "CREATE TABLE users(id INTEGER PRIMARY KEY, nome TEXT, cpf TEXT, email TEXT, token TEXT, primeiroAcesso INTEGER, informarCelularEmail INTEGER, celular TEXT)";
