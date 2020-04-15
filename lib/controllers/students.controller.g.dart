// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StudentsController on _StudentsControllerBase, Store {
  final _$listStudentsAtom = Atom(name: '_StudentsControllerBase.listStudents');

  @override
  ObservableList<DataStudents> get listStudents {
    _$listStudentsAtom.context.enforceReadPolicy(_$listStudentsAtom);
    _$listStudentsAtom.reportObserved();
    return super.listStudents;
  }

  @override
  set listStudents(ObservableList<DataStudents> value) {
    _$listStudentsAtom.context.conditionallyRunInAction(() {
      super.listStudents = value;
      _$listStudentsAtom.reportChanged();
    }, _$listStudentsAtom, name: '${_$listStudentsAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_StudentsControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$loadingStudentsAsyncAction = AsyncAction('loadingStudents');

  @override
  Future loadingStudents(String cpf, String token) {
    return _$loadingStudentsAsyncAction
        .run(() => super.loadingStudents(cpf, token));
  }

  @override
  String toString() {
    final string =
        'listStudents: ${listStudents.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
