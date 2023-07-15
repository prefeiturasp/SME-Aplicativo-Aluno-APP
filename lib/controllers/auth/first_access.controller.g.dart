// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_access.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FirstAccessController on _FirstAccessControllerBase, Store {
  late final _$dataAtom =
      Atom(name: '_FirstAccessControllerBase.data', context: context);

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

  late final _$dataEmailOrPhoneAtom = Atom(
      name: '_FirstAccessControllerBase.dataEmailOrPhone', context: context);

  @override
  DataChangeEmailAndPhone get dataEmailOrPhone {
    _$dataEmailOrPhoneAtom.reportRead();
    return super.dataEmailOrPhone;
  }

  @override
  set dataEmailOrPhone(DataChangeEmailAndPhone value) {
    _$dataEmailOrPhoneAtom.reportWrite(value, super.dataEmailOrPhone, () {
      super.dataEmailOrPhone = value;
    });
  }

  late final _$currentEmailAtom =
      Atom(name: '_FirstAccessControllerBase.currentEmail', context: context);

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

  late final _$currentPhoneAtom =
      Atom(name: '_FirstAccessControllerBase.currentPhone', context: context);

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

  late final _$changeNewPasswordAsyncAction = AsyncAction(
      '_FirstAccessControllerBase.changeNewPassword',
      context: context);

  @override
  Future changeNewPassword(int id, String password) {
    return _$changeNewPasswordAsyncAction
        .run(() => super.changeNewPassword(id, password));
  }

  late final _$changeEmailAndPhoneAsyncAction = AsyncAction(
      '_FirstAccessControllerBase.changeEmailAndPhone',
      context: context);

  @override
  Future changeEmailAndPhone(
      String email, String phone, int userId, bool changePassword) {
    return _$changeEmailAndPhoneAsyncAction.run(
        () => super.changeEmailAndPhone(email, phone, userId, changePassword));
  }

  late final _$loadUserForStorageAsyncAction = AsyncAction(
      '_FirstAccessControllerBase.loadUserForStorage',
      context: context);

  @override
  Future loadUserForStorage(int userId) {
    return _$loadUserForStorageAsyncAction
        .run(() => super.loadUserForStorage(userId));
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
