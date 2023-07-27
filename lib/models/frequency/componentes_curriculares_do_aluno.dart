// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:sme_app_aluno/models/frequency/curricular_component.dart';

class ComponentesCurricularesDoAluno {
  int codigoComponenteCurricular;
  String descricaoComponenteCurricular;
  bool isExpanded;
  CurricularComponent curricularComponent;
  ComponentesCurricularesDoAluno({
    required this.codigoComponenteCurricular,
    required this.descricaoComponenteCurricular,
    required this.isExpanded,
    required this.curricularComponent,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codigoComponenteCurricular': codigoComponenteCurricular,
      'descricaoComponenteCurricular': descricaoComponenteCurricular,
      'isExpanded': isExpanded,
      'curricularComponent': curricularComponent.toMap(),
    };
  }

  factory ComponentesCurricularesDoAluno.fromMap(Map<String, dynamic> map) {
    return ComponentesCurricularesDoAluno(
      codigoComponenteCurricular: map['codigoComponenteCurricular'] as int,
      descricaoComponenteCurricular: map['descricaoComponenteCurricular'] as String,
      isExpanded: map['isExpanded'] as bool,
      curricularComponent: CurricularComponent.fromMap(map['curricularComponent'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ComponentesCurricularesDoAluno.fromJson(String source) => ComponentesCurricularesDoAluno.fromMap(json.decode(source) as Map<String, dynamic>);
}
