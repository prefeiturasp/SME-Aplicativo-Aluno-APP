// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TermsController on _TermsControllerBase, Store {
  final _$termAtom = Atom(name: '_TermsControllerBase.term');

  @override
  Term get term {
    _$termAtom.reportRead();
    return super.term;
  }

  @override
  set term(Term value) {
    _$termAtom.reportWrite(value, super.term, () {
      super.term = value;
    });
  }

  final _$loadingAtom = Atom(name: '_TermsControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$isTermAtom = Atom(name: '_TermsControllerBase.isTerm');

  @override
  bool get isTerm {
    _$isTermAtom.reportRead();
    return super.isTerm;
  }

  @override
  set isTerm(bool value) {
    _$isTermAtom.reportWrite(value, super.isTerm, () {
      super.isTerm = value;
    });
  }

  final _$fetchTermoAsyncAction =
      AsyncAction('_TermsControllerBase.fetchTermo');

  @override
  Future fetchTermo(String cpf) {
    return _$fetchTermoAsyncAction.run(() => super.fetchTermo(cpf));
  }

  final _$fetchTermoCurrentUserAsyncAction =
      AsyncAction('_TermsControllerBase.fetchTermoCurrentUser');

  @override
  Future fetchTermoCurrentUser() {
    return _$fetchTermoCurrentUserAsyncAction
        .run(() => super.fetchTermoCurrentUser());
  }

  final _$registerTermsAsyncAction =
      AsyncAction('_TermsControllerBase.registerTerms');

  @override
  Future registerTerms(
      int termoDeUsoId, String cpf, String device, String ip, double versao) {
    return _$registerTermsAsyncAction
        .run(() => super.registerTerms(termoDeUsoId, cpf, device, ip, versao));
  }

  @override
  String toString() {
    return '''
term: ${term},
loading: ${loading},
isTerm: ${isTerm}
    ''';
  }
}
