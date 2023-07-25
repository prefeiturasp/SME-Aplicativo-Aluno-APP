// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recover_password.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecoverPasswordController on RecoverPasswordControllerBase, Store {
  late final _$dataAtom =
      Atom(name: 'RecoverPasswordControllerBase.data', context: context);

  @override
  Data? get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(Data? value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$dataUserAtom =
      Atom(name: 'RecoverPasswordControllerBase.dataUser', context: context);

  @override
  DataUser? get dataUser {
    _$dataUserAtom.reportRead();
    return super.dataUser;
  }

  @override
  set dataUser(DataUser? value) {
    _$dataUserAtom.reportWrite(value, super.dataUser, () {
      super.dataUser = value;
    });
  }

  late final _$emailAtom =
      Atom(name: 'RecoverPasswordControllerBase.email', context: context);

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

  late final _$loadingAtom =
      Atom(name: 'RecoverPasswordControllerBase.loading', context: context);

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

  late final _$sendTokenAsyncAction =
      AsyncAction('RecoverPasswordControllerBase.sendToken', context: context);

  @override
  Future<void> sendToken(String cpf) {
    return _$sendTokenAsyncAction.run(() => super.sendToken(cpf));
  }

  late final _$validateTokenAsyncAction = AsyncAction(
      'RecoverPasswordControllerBase.validateToken',
      context: context);

  @override
  Future<void> validateToken(String token) {
    return _$validateTokenAsyncAction.run(() => super.validateToken(token));
  }

  late final _$redefinePasswordAsyncAction = AsyncAction(
      'RecoverPasswordControllerBase.redefinePassword',
      context: context);

  @override
  Future<void> redefinePassword(String password, String token) {
    return _$redefinePasswordAsyncAction
        .run(() => super.redefinePassword(password, token));
  }

  @override
  String toString() {
    return '''
data: ${data},
dataUser: ${dataUser},
email: ${email},
loading: ${loading}
    ''';
  }
}
