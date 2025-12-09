// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terms.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TermsController on TermsControllerBase, Store {
  late final _$termAtom = Atom(
    name: 'TermsControllerBase.term',
    context: context,
  );

  @override
  Term? get term {
    _$termAtom.reportRead();
    return super.term;
  }

  @override
  set term(Term? value) {
    _$termAtom.reportWrite(value, super.term, () {
      super.term = value;
    });
  }

  late final _$loadingAtom = Atom(
    name: 'TermsControllerBase.loading',
    context: context,
  );

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

  late final _$isTermAtom = Atom(
    name: 'TermsControllerBase.isTerm',
    context: context,
  );

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

  late final _$fetchTermoAsyncAction = AsyncAction(
    'TermsControllerBase.fetchTermo',
    context: context,
  );

  @override
  Future<void> fetchTermo(String cpf) {
    return _$fetchTermoAsyncAction.run(() => super.fetchTermo(cpf));
  }

  late final _$fetchTermoCurrentUserAsyncAction = AsyncAction(
    'TermsControllerBase.fetchTermoCurrentUser',
    context: context,
  );

  @override
  Future<void> fetchTermoCurrentUser() {
    return _$fetchTermoCurrentUserAsyncAction.run(
      () => super.fetchTermoCurrentUser(),
    );
  }

  late final _$registerTermsAsyncAction = AsyncAction(
    'TermsControllerBase.registerTerms',
    context: context,
  );

  @override
  Future<void> registerTerms(
    int termoDeUsoId,
    String cpf,
    String device,
    String ip,
    double versao,
  ) {
    return _$registerTermsAsyncAction.run(
      () => super.registerTerms(termoDeUsoId, cpf, device, ip, versao),
    );
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
