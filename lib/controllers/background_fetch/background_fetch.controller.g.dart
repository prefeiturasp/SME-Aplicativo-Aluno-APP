// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_fetch.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BackgroundFetchController on BackgroundFetchControllerBase, Store {
  late final _$responsibleHasStudentAtom = Atom(
      name: 'BackgroundFetchControllerBase.responsibleHasStudent',
      context: context);

  @override
  bool get responsibleHasStudent {
    _$responsibleHasStudentAtom.reportRead();
    return super.responsibleHasStudent;
  }

  @override
  set responsibleHasStudent(bool value) {
    _$responsibleHasStudentAtom.reportWrite(value, super.responsibleHasStudent,
        () {
      super.responsibleHasStudent = value;
    });
  }

  late final _$initPlatformStateAsyncAction = AsyncAction(
      'BackgroundFetchControllerBase.initPlatformState',
      context: context);

  @override
  Future<void> initPlatformState(
      Function onBackgroundFetch, String taskId, int delay) {
    return _$initPlatformStateAsyncAction
        .run(() => super.initPlatformState(onBackgroundFetch, taskId, delay));
  }

  late final _$checkIfResponsibleHasStudentAsyncAction = AsyncAction(
      'BackgroundFetchControllerBase.checkIfResponsibleHasStudent',
      context: context);

  @override
  Future<bool> checkIfResponsibleHasStudent(int userId) {
    return _$checkIfResponsibleHasStudentAsyncAction
        .run(() => super.checkIfResponsibleHasStudent(userId));
  }

  @override
  String toString() {
    return '''
responsibleHasStudent: ${responsibleHasStudent}
    ''';
  }
}
