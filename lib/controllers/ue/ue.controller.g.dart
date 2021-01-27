// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ue.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UEController on _UEControllerBase, Store {
  final _$dadosUEAtom = Atom(name: '_UEControllerBase.dadosUE');

  @override
  DadosUE get dadosUE {
    _$dadosUEAtom.reportRead();
    return super.dadosUE;
  }

  @override
  set dadosUE(DadosUE value) {
    _$dadosUEAtom.reportWrite(value, super.dadosUE, () {
      super.dadosUE = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_UEControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$loadingUEAsyncAction = AsyncAction('_UEControllerBase.loadingUE');

  @override
  Future loadingUE(String codigoUe, int id) {
    return _$loadingUEAsyncAction.run(() => super.loadingUE(codigoUe, id));
  }

  @override
  String toString() {
    return '''
dadosUE: ${dadosUE},
isLoading: ${isLoading}
    ''';
  }
}
