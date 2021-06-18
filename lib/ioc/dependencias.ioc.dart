import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/repositories/index.dart';
import 'package:sme_app_aluno/stores/index.dart';

class DependenciasIoC {
  GetIt getIt;

  DependenciasIoC() {
    getIt = GetIt.instance;
  }

  registrarStores() {
    getIt.registerSingleton<UsuarioStore>(UsuarioStore());
  }

  registrarRepositories() {
    getIt.registerSingleton<UsuarioRepository>(UsuarioRepository());
  }

  registrarControllers() {
    getIt.registerSingleton<AutenticacaoController>(AutenticacaoController());
    getIt.registerSingleton<UsuarioController>(UsuarioController());
  }
}
