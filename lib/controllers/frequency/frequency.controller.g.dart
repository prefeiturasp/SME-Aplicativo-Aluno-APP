// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frequency.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FrequencyController on _FrequencyControllerBase, Store {
  final _$frequencyAtom = Atom(name: '_FrequencyControllerBase.frequency');

  @override
  Frequency get frequency {
    _$frequencyAtom.reportRead();
    return super.frequency;
  }

  @override
  set frequency(Frequency value) {
    _$frequencyAtom.reportWrite(value, super.frequency, () {
      super.frequency = value;
    });
  }

  final _$curricularComponentAtom =
      Atom(name: '_FrequencyControllerBase.curricularComponent');

  @override
  CurricularComponent get curricularComponent {
    _$curricularComponentAtom.reportRead();
    return super.curricularComponent;
  }

  @override
  set curricularComponent(CurricularComponent value) {
    _$curricularComponentAtom.reportWrite(value, super.curricularComponent, () {
      super.curricularComponent = value;
    });
  }

  final _$loadingFrequencyAtom =
      Atom(name: '_FrequencyControllerBase.loadingFrequency');

  @override
  bool get loadingFrequency {
    _$loadingFrequencyAtom.reportRead();
    return super.loadingFrequency;
  }

  @override
  set loadingFrequency(bool value) {
    _$loadingFrequencyAtom.reportWrite(value, super.loadingFrequency, () {
      super.loadingFrequency = value;
    });
  }

  final _$loadingCurricularComponentAtom =
      Atom(name: '_FrequencyControllerBase.loadingCurricularComponent');

  @override
  bool get loadingCurricularComponent {
    _$loadingCurricularComponentAtom.reportRead();
    return super.loadingCurricularComponent;
  }

  @override
  set loadingCurricularComponent(bool value) {
    _$loadingCurricularComponentAtom
        .reportWrite(value, super.loadingCurricularComponent, () {
      super.loadingCurricularComponent = value;
    });
  }

  final _$showCardAsyncAction =
      AsyncAction('_FrequencyControllerBase.showCard');

  @override
  Future<void> showCard(int index) {
    return _$showCardAsyncAction.run(() => super.showCard(index));
  }

  final _$fetchFrequencyAsyncAction =
      AsyncAction('_FrequencyControllerBase.fetchFrequency');

  @override
  Future fetchFrequency(int anoLetivo, String codigoUe, String codigoTurma,
      String codigoAluno, int userId) {
    return _$fetchFrequencyAsyncAction.run(() => super
        .fetchFrequency(anoLetivo, codigoUe, codigoTurma, codigoAluno, userId));
  }

  final _$fetchCurricularComponentAsyncAction =
      AsyncAction('_FrequencyControllerBase.fetchCurricularComponent');

  @override
  Future fetchCurricularComponent(
      int anoLetivo,
      String codigoUE,
      String codigoTurma,
      String codigoAluno,
      String codigoComponenteCurricular
  ) {
    return _$fetchCurricularComponentAsyncAction.run(() {
      return super.fetchCurricularComponent(
        anoLetivo, codigoUE, codigoTurma, codigoAluno, 
        codigoComponenteCurricular
      );
    });
  }

  @override
  String toString() {
    return '''
frequency: ${frequency},
curricularComponent: ${curricularComponent},
loadingFrequency: ${loadingFrequency},
loadingCurricularComponent: ${loadingCurricularComponent}
    ''';
  }
}
