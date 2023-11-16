import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../enumeradores/modalidade_tipo.dart';
import '../../enumeradores/modelo_boletim.dart';
import '../../models/estudante.model.dart';
import '../../screens/data_student/data.dart';
import '../../screens/frequency/frequency.dart';
import '../../screens/not_internet/not_internet.dart';
import '../../screens/notes/expansion.dart';
import '../../utils/conection.dart';
import '../../utils/date_format.dart';
import '../../utils/mensagem_sistema.dart';
import '../index.dart';

class EstudanteResumoView extends StatefulWidget {
  final EstudanteModel estudante;
  final String modalidade;
  final String grupoCodigo;
  const EstudanteResumoView({
    super.key,
    required this.estudante,
    required this.modalidade,
    required this.grupoCodigo,
  });

  @override
  EstudanteResumoViewState createState() => EstudanteResumoViewState();
}

class EstudanteResumoViewState extends State<EstudanteResumoView> {
  bool abaDados = true;
  bool abaBoletim = false;
  bool abaFrequencia = false;

  Widget content(BuildContext context, double screenHeight, EstudanteModel data, GlobalKey<ScaffoldState> scaffoldkey) {
    final String dateFormatted = DateFormatSuport.formatStringDate(data.dataNascimento, 'dd/MM/yyyy');
    final String dateSituacaoMatricula = DateFormatSuport.formatStringDate(data.dataSituacaoMatricula, 'dd/MM/yyyy');

    if (abaDados) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(screenHeight * 2.5),
        child: DataStudent(
          dataNasc: dateFormatted,
          codigoEOL: '${data.codigoEol}',
          situacao: dateSituacaoMatricula,
          codigoUe: widget.estudante.codigoEscola,
        ),
      );
    }

    if (abaBoletim) {
      return Container(
        padding: EdgeInsets.all(screenHeight),
        height: MediaQuery.of(context).size.height - screenHeight * 26,
        child: Expansion(
          codigoUe: widget.estudante.codigoEscola,
          codigoDre: widget.estudante.codigoDre,
          semestre: 0,
          modelo: ModeloBoletim.Detalhado,
          anoLetivo: DateTime.now().year,
          codigoTurma: widget.estudante.codigoTurma.toString(),
          codigoAluno: widget.estudante.codigoEol.toString(),
          groupSchool: widget.modalidade,
          codigoModalidade: widget.grupoCodigo,
          scaffoldState: scaffoldkey,
        ),
      );
    }

    if (abaFrequencia) {
      return Frequency(
        student: widget.estudante,
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);
    final keyScaffod = GlobalKey<ScaffoldState>();
    if (connectionStatus == ConnectivityStatus.Offline) {
      return const NotInteernet();
    } else {
      final size = MediaQuery.of(context).size;
      final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
      return Scaffold(
        key: keyScaffod,
        backgroundColor: const Color(0xffE5E5E5),
        appBar: AppBar(
          title: const Text(
            'Informações do estudante',
            style: TextStyle(color: Color(0xff333333), fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xffEEC25E),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xffE5E5E5),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(screenHeight * 2.5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Color(0xffC5C5C5), width: 0.5)),
                      ),
                      child: EAEstudanteInfo(
                        nome: widget.estudante.nomeSocial.isNotEmpty
                            ? widget.estudante.nomeSocial
                            : widget.estudante.nome,
                        ue: widget.estudante.escola,
                        tipoEscola: widget.estudante.descricaoTipoEscola,
                        dre: widget.estudante.siglaDre,
                        grade: widget.estudante.turma,
                        codigoEOL: widget.estudante.codigoEol,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              abaDados = true;
                              abaBoletim = false;
                              abaFrequencia = false;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 100) * 33.33,
                            padding: EdgeInsets.only(top: screenHeight * 2.2, bottom: screenHeight * 2.2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: abaDados ? const Color(0xffC65D00) : const Color(0xffCECECE),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                'DADOS',
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                  color: abaDados ? const Color(0xffC65D00) : const Color(0xff9f9f9f),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              abaDados = false;
                              abaBoletim = true;
                              abaFrequencia = false;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 100) * 33.33,
                            padding: EdgeInsets.only(top: screenHeight * 2.2, bottom: screenHeight * 2.2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: abaBoletim ? const Color(0xffC65D00) : const Color(0xffCECECE),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                widget.grupoCodigo == ModalidadeTipo.EducacaoInfantil
                                    ? MensagemSistema.abaLabelRelatorio
                                    : MensagemSistema.abaLabelBoletim,
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                  color: abaBoletim ? const Color(0xffC65D00) : const Color(0xff9f9f9f),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              abaDados = false;
                              abaBoletim = false;
                              abaFrequencia = true;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 100) * 33.33,
                            padding: EdgeInsets.only(
                              top: screenHeight * 2.2,
                              bottom: screenHeight * 2.2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: abaFrequencia ? const Color(0xffC65D00) : const Color(0xffCECECE),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                'FREQUÊNCIA',
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(
                                  color: abaFrequencia ? const Color(0xffC65D00) : const Color(0xff9f9f9f),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    content(
                      context,
                      screenHeight,
                      widget.estudante,
                      keyScaffod,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
