// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_notes.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListNotesController on _ListNotesControllerBase, Store {
  final _$bUmAtom = Atom(name: '_ListNotesControllerBase.bUm');

  @override
  ListNotes get bUm {
    _$bUmAtom.reportRead();
    return super.bUm;
  }

  @override
  set bUm(ListNotes value) {
    _$bUmAtom.reportWrite(value, super.bUm, () {
      super.bUm = value;
    });
  }

  final _$bDoisAtom = Atom(name: '_ListNotesControllerBase.bDois');

  @override
  ListNotes get bDois {
    _$bDoisAtom.reportRead();
    return super.bDois;
  }

  @override
  set bDois(ListNotes value) {
    _$bDoisAtom.reportWrite(value, super.bDois, () {
      super.bDois = value;
    });
  }

  final _$bTresAtom = Atom(name: '_ListNotesControllerBase.bTres');

  @override
  ListNotes get bTres {
    _$bTresAtom.reportRead();
    return super.bTres;
  }

  @override
  set bTres(ListNotes value) {
    _$bTresAtom.reportWrite(value, super.bTres, () {
      super.bTres = value;
    });
  }

  final _$bQuatroAtom = Atom(name: '_ListNotesControllerBase.bQuatro');

  @override
  ListNotes get bQuatro {
    _$bQuatroAtom.reportRead();
    return super.bQuatro;
  }

  @override
  set bQuatro(ListNotes value) {
    _$bQuatroAtom.reportWrite(value, super.bQuatro, () {
      super.bQuatro = value;
    });
  }

  final _$bFinalAtom = Atom(name: '_ListNotesControllerBase.bFinal');

  @override
  ListNotes get bFinal {
    _$bFinalAtom.reportRead();
    return super.bFinal;
  }

  @override
  set bFinal(ListNotes value) {
    _$bFinalAtom.reportWrite(value, super.bFinal, () {
      super.bFinal = value;
    });
  }

  final _$listNotesUmAtom = Atom(name: '_ListNotesControllerBase.listNotesUm');

  @override
  ObservableList<Note> get listNotesUm {
    _$listNotesUmAtom.reportRead();
    return super.listNotesUm;
  }

  @override
  set listNotesUm(ObservableList<Note> value) {
    _$listNotesUmAtom.reportWrite(value, super.listNotesUm, () {
      super.listNotesUm = value;
    });
  }

  final _$listNotesDoisAtom =
      Atom(name: '_ListNotesControllerBase.listNotesDois');

  @override
  ObservableList<Note> get listNotesDois {
    _$listNotesDoisAtom.reportRead();
    return super.listNotesDois;
  }

  @override
  set listNotesDois(ObservableList<Note> value) {
    _$listNotesDoisAtom.reportWrite(value, super.listNotesDois, () {
      super.listNotesDois = value;
    });
  }

  final _$listNotesTresAtom =
      Atom(name: '_ListNotesControllerBase.listNotesTres');

  @override
  ObservableList<Note> get listNotesTres {
    _$listNotesTresAtom.reportRead();
    return super.listNotesTres;
  }

  @override
  set listNotesTres(ObservableList<Note> value) {
    _$listNotesTresAtom.reportWrite(value, super.listNotesTres, () {
      super.listNotesTres = value;
    });
  }

  final _$listNotesQuatroAtom =
      Atom(name: '_ListNotesControllerBase.listNotesQuatro');

  @override
  ObservableList<Note> get listNotesQuatro {
    _$listNotesQuatroAtom.reportRead();
    return super.listNotesQuatro;
  }

  @override
  set listNotesQuatro(ObservableList<Note> value) {
    _$listNotesQuatroAtom.reportWrite(value, super.listNotesQuatro, () {
      super.listNotesQuatro = value;
    });
  }

  final _$listNotesFinalAtom =
      Atom(name: '_ListNotesControllerBase.listNotesFinal');

  @override
  ObservableList<Note> get listNotesFinal {
    _$listNotesFinalAtom.reportRead();
    return super.listNotesFinal;
  }

  @override
  set listNotesFinal(ObservableList<Note> value) {
    _$listNotesFinalAtom.reportWrite(value, super.listNotesFinal, () {
      super.listNotesFinal = value;
    });
  }

  final _$listComposeAtom = Atom(name: '_ListNotesControllerBase.listCompose');

  @override
  ObservableList<Note> get listCompose {
    _$listComposeAtom.reportRead();
    return super.listCompose;
  }

  @override
  set listCompose(ObservableList<Note> value) {
    _$listComposeAtom.reportWrite(value, super.listCompose, () {
      super.listCompose = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ListNotesControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$fetchNotesAsyncAction =
      AsyncAction('_ListNotesControllerBase.fetchNotes');

  @override
  Future fetchNotes(int anoLetivo, int bimestre, String codigoUe,
      String codigoTurma, String alunoCodigo) {
    return _$fetchNotesAsyncAction.run(() => super
        .fetchNotes(anoLetivo, bimestre, codigoUe, codigoTurma, alunoCodigo));
  }

  @override
  String toString() {
    return '''
bUm: ${bUm},
bDois: ${bDois},
bTres: ${bTres},
bQuatro: ${bQuatro},
bFinal: ${bFinal},
listNotesUm: ${listNotesUm},
listNotesDois: ${listNotesDois},
listNotesTres: ${listNotesTres},
listNotesQuatro: ${listNotesQuatro},
listNotesFinal: ${listNotesFinal},
listCompose: ${listCompose},
loading: ${loading}
    ''';
  }
}
