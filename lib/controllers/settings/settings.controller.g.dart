// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsController on SettingsControllerBase, Store {
  late final _$dataAtom =
      Atom(name: 'SettingsControllerBase.data', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: 'SettingsControllerBase.isLoading', context: context);

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

  late final _$changePasswordAsyncAction =
      AsyncAction('SettingsControllerBase.changePassword', context: context);

  @override
  Future<void> changePassword(String password, String oldPassword, int userId) {
    return _$changePasswordAsyncAction
        .run(() => super.changePassword(password, oldPassword, userId));
  }

  @override
  String toString() {
    return '''
data: ${data},
isLoading: ${isLoading}
    ''';
  }
}
