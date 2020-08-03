// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  final _$dataAtom = Atom(name: '_SettingsControllerBase.data');

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

  final _$isLoadingAtom = Atom(name: '_SettingsControllerBase.isLoading');

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

  final _$changePasswordAsyncAction =
      AsyncAction('_SettingsControllerBase.changePassword');

  @override
  Future changePassword(String password, String oldPassword) {
    return _$changePasswordAsyncAction
        .run(() => super.changePassword(password, oldPassword));
  }

  @override
  String toString() {
    return '''
data: ${data},
isLoading: ${isLoading}
    ''';
  }
}
