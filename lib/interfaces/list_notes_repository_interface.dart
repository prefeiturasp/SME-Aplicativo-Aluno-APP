import '../models/note/list_notes.dart';

abstract class IListNotesRepository {
  Future<ListNotes> fetchListNotes(
    int anoLetivo,
    int bimestre,
    String codigoUe,
    String codigoTurma,
    String alunoCodigo,
  );
}
