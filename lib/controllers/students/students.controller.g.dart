// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StudentsController on _StudentsControllerBase, Store {
  final _$dataEstudentAtom = Atom(name: '_StudentsControllerBase.dataEstudent');

  @override
  DataStudent get dataEstudent {
    _$dataEstudentAtom.reportRead();
    return super.dataEstudent;
  }

  @override
  set dataEstudent(DataStudent value) {
    _$dataEstudentAtom.reportWrite(value, super.dataEstudent, () {
      super.dataEstudent = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_StudentsControllerBase.isLoading');

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

  final _$loadingStudentsAsyncAction =
      AsyncAction('_StudentsControllerBase.loadingStudents');

  @override
  Future loadingStudents(String cpf, int id) {
    return _$loadingStudentsAsyncAction
        .run(() => super.loadingStudents(cpf, id));
  }

  final _$_StudentsControllerBaseActionController =
      ActionController(name: '_StudentsControllerBase');

  @override
  dynamic subscribeGroupIdToFirebase() {
    final _$actionInfo = _$_StudentsControllerBaseActionController.startAction(
        name: '_StudentsControllerBase.subscribeGroupIdToFirebase');
    try {
      return super.subscribeGroupIdToFirebase();
    } finally {
      _$_StudentsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataEstudent: ${dataEstudent},
isLoading: ${isLoading}
    ''';
  }
}
