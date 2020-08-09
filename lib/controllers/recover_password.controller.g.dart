// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recover_password.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecoverPasswordController on _RecoverPasswordControllerBase, Store {
  final _$dataAtom = Atom(name: '_RecoverPasswordControllerBase.data');

  @override
  Data get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(Data value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$emailAtom = Atom(name: '_RecoverPasswordControllerBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$loadingAtom = Atom(name: '_RecoverPasswordControllerBase.loading');

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

  final _$sendTokenAsyncAction =
      AsyncAction('_RecoverPasswordControllerBase.sendToken');

  @override
  Future sendToken(String cpf) {
    return _$sendTokenAsyncAction.run(() => super.sendToken(cpf));
  }

  final _$validateTokenAsyncAction =
      AsyncAction('_RecoverPasswordControllerBase.validateToken');

  @override
  Future validateToken(String token) {
    return _$validateTokenAsyncAction.run(() => super.validateToken(token));
  }

  @override
  String toString() {
    return '''
data: ${data},
email: ${email},
loading: ${loading}
    ''';
  }
}
