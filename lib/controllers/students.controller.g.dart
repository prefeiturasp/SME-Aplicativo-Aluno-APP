// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StudentsController on _StudentsControllerBase, Store {
  final _$dataEstudentAtom = Atom(name: '_StudentsControllerBase.dataEstudent');

  @override
  DataStudent get dataEstudent {
    _$dataEstudentAtom.context.enforceReadPolicy(_$dataEstudentAtom);
    _$dataEstudentAtom.reportObserved();
    return super.dataEstudent;
  }

  @override
  set dataEstudent(DataStudent value) {
    _$dataEstudentAtom.context.conditionallyRunInAction(() {
      super.dataEstudent = value;
      _$dataEstudentAtom.reportChanged();
    }, _$dataEstudentAtom, name: '${_$dataEstudentAtom.name}_set');
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

  final _$_StudentsControllerBaseActionController =
      ActionController(name: '_StudentsControllerBase');

  @override
  dynamic subscribeGroupIdToFirebase() {
    final _$actionInfo =
        _$_StudentsControllerBaseActionController.startAction();
    try {
      return super.subscribeGroupIdToFirebase();
    } finally {
      _$_StudentsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'dataEstudent: ${dataEstudent.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
