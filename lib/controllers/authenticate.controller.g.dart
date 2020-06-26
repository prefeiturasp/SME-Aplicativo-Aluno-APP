// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticateController on _AuthenticateControllerBase, Store {
  final _$currentUserAtom =
      Atom(name: '_AuthenticateControllerBase.currentUser');

  @override
  Data get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(Data value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AuthenticateControllerBase.isLoading');

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

  final _$currentNameAtom =
      Atom(name: '_AuthenticateControllerBase.currentName');

  @override
  String get currentName {
    _$currentNameAtom.reportRead();
    return super.currentName;
  }

  @override
  set currentName(String value) {
    _$currentNameAtom.reportWrite(value, super.currentName, () {
      super.currentName = value;
    });
  }

  final _$currentCPFAtom = Atom(name: '_AuthenticateControllerBase.currentCPF');

  @override
  String get currentCPF {
    _$currentCPFAtom.reportRead();
    return super.currentCPF;
  }

  @override
  set currentCPF(String value) {
    _$currentCPFAtom.reportWrite(value, super.currentCPF, () {
      super.currentCPF = value;
    });
  }

  final _$currentEmailAtom =
      Atom(name: '_AuthenticateControllerBase.currentEmail');

  @override
  String get currentEmail {
    _$currentEmailAtom.reportRead();
    return super.currentEmail;
  }

  @override
  set currentEmail(String value) {
    _$currentEmailAtom.reportWrite(value, super.currentEmail, () {
      super.currentEmail = value;
    });
  }

  final _$currentPasswordAtom =
      Atom(name: '_AuthenticateControllerBase.currentPassword');

  @override
  String get currentPassword {
    _$currentPasswordAtom.reportRead();
    return super.currentPassword;
  }

  @override
  set currentPassword(String value) {
    _$currentPasswordAtom.reportWrite(value, super.currentPassword, () {
      super.currentPassword = value;
    });
  }

  final _$tokenAtom = Atom(name: '_AuthenticateControllerBase.token');

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  final _$authenticateUserAsyncAction =
      AsyncAction('_AuthenticateControllerBase.authenticateUser');

  @override
  Future authenticateUser(String cpf, String password, bool onBackgroundFetch) {
    return _$authenticateUserAsyncAction
        .run(() => super.authenticateUser(cpf, password, onBackgroundFetch));
  }

  final _$fetchFirstAccessAsyncAction =
      AsyncAction('_AuthenticateControllerBase.fetchFirstAccess');

  @override
  Future fetchFirstAccess(int id, String password) {
    return _$fetchFirstAccessAsyncAction
        .run(() => super.fetchFirstAccess(id, password));
  }

  final _$loadCurrentUserAsyncAction =
      AsyncAction('_AuthenticateControllerBase.loadCurrentUser');

  @override
  Future<void> loadCurrentUser() {
    return _$loadCurrentUserAsyncAction.run(() => super.loadCurrentUser());
  }

  final _$_AuthenticateControllerBaseActionController =
      ActionController(name: '_AuthenticateControllerBase');

  @override
  dynamic clearCurrentUser() {
    final _$actionInfo = _$_AuthenticateControllerBaseActionController
        .startAction(name: '_AuthenticateControllerBase.clearCurrentUser');
    try {
      return super.clearCurrentUser();
    } finally {
      _$_AuthenticateControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading},
currentName: ${currentName},
currentCPF: ${currentCPF},
currentEmail: ${currentEmail},
currentPassword: ${currentPassword},
token: ${token}
    ''';
  }
}
