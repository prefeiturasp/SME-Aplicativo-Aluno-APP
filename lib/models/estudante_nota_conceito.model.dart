import 'dart:convert';

class EstudanteNotaConceitoModel {
  final int id;
  final int conselhoClasseNotaId;
  final int bimestre;
  final int componenteCurricularCodigo;
  final String componenteCurricularNome;
  final int conceitoId;
  final String nota;
  final String corDaNota;
  final String notaConceito;
  EstudanteNotaConceitoModel({
    required this.id,
    required this.conselhoClasseNotaId,
    required this.bimestre,
    required this.componenteCurricularCodigo,
    required this.componenteCurricularNome,
    required this.conceitoId,
    required this.nota,
    required this.corDaNota,
    required this.notaConceito,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'conselhoClasseNotaId': conselhoClasseNotaId,
      'bimestre': bimestre,
      'componenteCurricularCodigo': componenteCurricularCodigo,
      'componenteCurricularNome': componenteCurricularNome,
      'conceitoId': conceitoId,
      'nota': nota,
      'corDaNota': corDaNota,
      'notaConceito': notaConceito,
    };
  }

  factory EstudanteNotaConceitoModel.fromMap(Map<String, dynamic> map) {
    return EstudanteNotaConceitoModel(
      id: map['id'] ?? 0,
      conselhoClasseNotaId: map['conselhoClasseNotaId'] ?? 0,
      bimestre: map['bimestre'] as int,
      componenteCurricularCodigo: map['componenteCurricularCodigo'] ?? 0,
      componenteCurricularNome: map['componenteCurricularNome'] ?? '',
      conceitoId: map['conceitoId'] ?? 0,
      nota: map['nota'] ?? '',
      corDaNota: map['corDaNota'] ?? '',
      notaConceito: map['notaConceito'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EstudanteNotaConceitoModel.fromJson(String source) =>
      EstudanteNotaConceitoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
