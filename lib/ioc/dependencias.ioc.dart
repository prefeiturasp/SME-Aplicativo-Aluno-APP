import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/controllers/index.dart';
import 'package:sme_app_aluno/repositories/index.dart';
import 'package:sme_app_aluno/services/index.dart';
import 'package:sme_app_aluno/stores/index.dart';

class DependenciasIoC {
  late GetIt getIt;

  DependenciasIoC() {
    getIt = GetIt.instance;
  }

  registrarServicos() {
    getIt.registerSingleton<ApiService>(ApiService());
  }

  registrarStores() {
    getIt.registerSingleton<UsuarioStore>(UsuarioStore());
    getIt.registerSingleton<EstudanteStore>(EstudanteStore());
  }

  registrarRepositories() {
    getIt.registerSingleton<UsuarioRepository>(UsuarioRepository());
    getIt.registerSingleton<EstudanteRepository>(EstudanteRepository());
  }

  registrarControllers() {
    getIt.registerSingleton<AutenticacaoController>(AutenticacaoController());
    getIt.registerSingleton<UsuarioController>(UsuarioController());
    getIt.registerSingleton<EstudanteController>(EstudanteController());
    getIt.registerSingleton<EstudanteNotasController>(EstudanteNotasController());
    getIt.registerSingleton<EstudanteFrequenciaController>(EstudanteFrequenciaController());
  }
}
