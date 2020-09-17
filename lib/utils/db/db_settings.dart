const String DATABASE_NAME = "escola_aqui.db";

const String TB_USER = "users";
const String TB_MESSAGE = "messages";
const String CREATE_TABLE_USERS_SCRIPT =
    "CREATE TABLE users(id INTEGER PRIMARY KEY, nome TEXT, cpf TEXT, email TEXT, token TEXT, primeiroAcesso INTEGER, informarCelularEmail INTEGER, celular TEXT)";

const String CREATE_TABLE_MESSAGES_SCRIPT =
    "CREATE TABLE messages(id INTEGER PRIMARY KEY, mensagem TEXT, titulo TEXT, dataEnvio TEXT, criadoEm TEXT, mensagemVisualizada INTEGER, categoriaNotificacao TEXT)";
