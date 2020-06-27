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

  final _$isLoadingAtom = Atom(name: '_FirstAccessControllerBase.isLoading');

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

  final _$changeNewPasswordAsyncAction =
      AsyncAction('_FirstAccessControllerBase.changeNewPassword');

  @override
  Future changeNewPassword(int id, String password) {
    return _$changeNewPasswordAsyncAction
        .run(() => super.changeNewPassword(id, password));
  }

  final _$changeEmailAsyncAction =
      AsyncAction('_FirstAccessControllerBase.changeEmail');

  @override
  Future changeEmail(int id, String email) {
    return _$changeEmailAsyncAction.run(() => super.changeEmail(id, email));
  }

  final _$changePhoneAsyncAction =
      AsyncAction('_FirstAccessControllerBase.changePhone');

  @override
  Future changePhone(int id, String phone) {
    return _$changePhoneAsyncAction.run(() => super.changePhone(id, phone));
  }

  @override
  String toString() {
    return '''
data: ${data},
dataEmailOrPhone: ${dataEmailOrPhone},
isLoading: ${isLoading}
    ''';
  }
}
