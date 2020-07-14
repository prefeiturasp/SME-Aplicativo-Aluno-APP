// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_access.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FirstAccessController on _FirstAccessControllerBase, Store {
  final _$dataAtom = Atom(name: '_FirstAccessControllerBase.data');

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

  final _$dataEmailOrPhoneAtom =
      Atom(name: '_FirstAccessControllerBase.dataEmailOrPhone');

  @override
  Data get dataEmailOrPhone {
    _$dataEmailOrPhoneAtom.reportRead();
    return super.dataEmailOrPhone;
  }

  @override
  set dataEmailOrPhone(Data value) {
    _$dataEmailOrPhoneAtom.reportWrite(value, super.dataEmailOrPhone, () {
      super.dataEmailOrPhone = value;
    });
  }

  final _$currentEmailAtom =
      Atom(name: '_FirstAccessControllerBase.currentEmail');

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

  final _$currentPhoneAtom =
      Atom(name: '_FirstAccessControllerBase.currentPhone');

  @override
  String get currentPhone {
    _$currentPhoneAtom.reportRead();
    return super.currentPhone;
  }

  @override
  set currentPhone(String value) {
    _$currentPhoneAtom.reportWrite(value, super.currentPhone, () {
      super.currentPhone = value;
    });
  }

  final _$changeNewPasswordAsyncAction =
      AsyncAction('_FirstAccessControllerBase.changeNewPassword');

  @override
  Future changeNewPassword(int id, String password) {
    return _$changeNewPasswordAsyncAction
        .run(() => super.changeNewPassword(id, password));
  }

  final _$changeEmailAndPhoneAsyncAction =
      AsyncAction('_FirstAccessControllerBase.changeEmailAndPhone');

  @override
  Future changeEmailAndPhone(String email, String phone, bool changePassword) {
    return _$changeEmailAndPhoneAsyncAction
        .run(() => super.changeEmailAndPhone(email, phone, changePassword));
  }

  final _$loadUserForStorageAsyncAction =
      AsyncAction('_FirstAccessControllerBase.loadUserForStorage');

  @override
  Future loadUserForStorage() {
    return _$loadUserForStorageAsyncAction
        .run(() => super.loadUserForStorage());
  }

  @override
  String toString() {
    return '''
data: ${data},
dataEmailOrPhone: ${dataEmailOrPhone},
currentEmail: ${currentEmail},
currentPhone: ${currentPhone}
    ''';
  }
}
