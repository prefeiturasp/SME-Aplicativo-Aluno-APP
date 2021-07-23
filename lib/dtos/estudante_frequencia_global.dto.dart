class EstudanteFrequenciaGlobalDTO {
  double frequencia;
  String corDaFrequencia;

  EstudanteFrequenciaGlobalDTO({this.frequencia, this.corDaFrequencia});

  EstudanteFrequenciaGlobalDTO.fromJson(Map<String, dynamic> json) {
    frequencia = json['frequencia'];
    corDaFrequencia = json['corDaFrequencia'];
  }
}
