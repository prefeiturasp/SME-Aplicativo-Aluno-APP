const String databaseNAME = 'escola_aqui.db';

const String tbUSER = 'users';
const String tbMESSAGE = 'messages';
const String tbGroupMessage = 'group_messages';

const String createTableUsersScript =
    'CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, nome TEXT, cpf TEXT, email TEXT, token TEXT, primeiroAcesso INTEGER, atualizarDadosCadastrais INTEGER, celular TEXT)';

const String createTableMessagesScript =
    'CREATE TABLE IF NOT EXISTS messages(id INTEGER PRIMARY KEY, mensagem TEXT, titulo TEXT, dataEnvio TEXT, criadoEm TEXT, alteradoEm TEXT, mensagemVisualizada INTEGER, categoriaNotificacao TEXT,codigoEOL INTEGER)';

const String createTableGroupMessagesScript =
    'CREATE TABLE IF NOT EXISTS group_messages(id INTEGER PRIMARY KEY, codigo TEXT)';
