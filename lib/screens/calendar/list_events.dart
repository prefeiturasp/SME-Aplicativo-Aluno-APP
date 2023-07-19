import 'dart:js_interop';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:sme_app_aluno/controllers/event/event.controller.dart';
import 'package:sme_app_aluno/models/estudante.model.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/screens/calendar/event_item.dart';
import 'package:sme_app_aluno/screens/calendar/label_event.dart';
import 'package:sme_app_aluno/screens/calendar/title_event.dart';
import 'package:sme_app_aluno/ui/index.dart';

class ListEvents extends StatefulWidget {
  final EstudanteModel student;
  final int userId;

  ListEvents({
    required this.student,
    required this.userId,
  });
  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  late EventController _eventController;

  int _currentMonth = 0;

  @override
  void initState() {
    super.initState();
    _eventController = EventController();
    _eventController.fetchEvento(
      widget.student.codigoEol,
      _eventController.currentDate.month,
      _eventController.currentDate.year,
      widget.userId,
    );
    _currentMonth = _eventController.currentDate.month;
  }

  Widget _eventItemBuild(
    Event event,
    BuildContext context,
  ) {
    String diaSemana = (event.diaSemana).substring(0, 1).toUpperCase() + (event.diaSemana).substring(1);

    return Column(
      children: [
        EventItem(
            customTitle: TitleEvent(
              dayOfWeek: diaSemana,
              title: event.nome,
            ),
            titleEvent: event.nome,
            desc: !event.descricao.isNull ? (event.descricao.length > 3 ? true : false) : false,
            eventDesc: event.descricao,
            dia: event.dataInicio,
            tipoEvento: event.tipoEvento,
            componenteCurricular: event.componenteCurricular),
        Divider(
          color: Color(0xffCDCDCD),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorAvaliacao = Color(0xFF9C33AD);
    const colorDemaisEventos = Color(0xFFE1771D);
    const colorDiasSemAula = Color(0xFFC4C4C4);
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text("Agenda"),
        backgroundColor: Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffE5E5E5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(screenHeight * 2.5),
                    decoration: BoxDecoration(
                        color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xffC5C5C5), width: 0.5))),
                    child: EAEstudanteInfo(
                      nome: widget.student.nomeSocial != null ? widget.student.nomeSocial : widget.student.nome,
                      ue: widget.student.escola,
                      tipoEscola: widget.student.descricaoTipoEscola,
                      dre: widget.student.siglaDre,
                      grade: widget.student.turma,
                      codigoEOL: widget.student.codigoEol,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 2, left: screenHeight * 2, right: screenHeight * 2),
                // width: screenHeight * 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.angleLeft,
                          color: _currentMonth > 1 ? Color(0xffC45C04) : Colors.transparent,
                          size: screenHeight * 3,
                        ),
                        onPressed: _currentMonth > 1
                            ? () async {
                                setState(() => _currentMonth--);
                                if (_currentMonth >= 1) {
                                  await _eventController.changeCurrentMonth(
                                      _currentMonth, widget.student.codigoEol, widget.userId);
                                }
                              }
                            : null),
                    Observer(builder: (_) {
                      return AutoSizeText(
                        _eventController.currentMonth.toUpperCase(),
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      );
                    }),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.angleRight,
                          color: _currentMonth < 12 ? Color(0xffC45C04) : Colors.transparent,
                          size: screenHeight * 3,
                        ),
                        onPressed: _currentMonth < 12
                            ? () async {
                                setState(() => _currentMonth++);
                                if (_currentMonth <= 12) {
                                  await _eventController.changeCurrentMonth(
                                      _currentMonth, widget.student.codigoEol, widget.userId);
                                }
                              }
                            : null),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  color: Color(0xFFF3F3F3),
                ),
              ),
              Container(
                margin: EdgeInsets.all(screenHeight * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenHeight * 2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 2),
                      blurRadius: 2,
                      spreadRadius: 0,
                    )
                  ],
                ),
                padding: EdgeInsets.all(screenHeight * 1.5),
                child: Observer(builder: (context) {
                  if (_eventController.loading) {
                    return Container(
                      child: GFLoader(
                        type: GFLoaderType.square,
                        loaderColorOne: Color(0xffDE9524),
                        loaderColorTwo: Color(0xffC65D00),
                        loaderColorThree: Color(0xffC65D00),
                        size: GFSize.LARGE,
                      ),
                      margin: EdgeInsets.all(screenHeight * 1.5),
                    );
                  } else {
                    if (_eventController.eventsSortDate.isNotEmpty) {
                      return Observer(builder: (_) {
                        if (_eventController.events != null) {
                          return Container(
                              height: screenHeight * 50,
                              child: Scrollbar(
                                child: ListView.builder(
                                    itemCount: _eventController.eventsSortDate.length,
                                    itemBuilder: (context, index) {
                                      return _eventItemBuild(_eventController.eventsSortDate[index], context);
                                    }),
                              ));
                        } else {
                          return Container();
                        }
                      });
                    } else {
                      return Container(
                          height: screenHeight * 60,
                          child: Center(
                            child: AutoSizeText(
                              "Não foi encontrado nenhum evento para este estudante.",
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 10,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ));
                    }
                  }
                }),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: screenHeight * 7,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelEvent(labelName: "Avaliação", labelColor: colorAvaliacao),
                    LabelEvent(labelName: "Dias sem aula", labelColor: colorDiasSemAula),
                    LabelEvent(labelName: "Demais eventos", labelColor: colorDemaisEventos),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget legenda(String nomeLegenda, Color corLegenda) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: corLegenda,
              borderRadius: BorderRadius.all(
                Radius.circular(screenHeight * 2),
              ),
            ),
            width: screenHeight * 2.5,
            height: screenHeight * 2.5,
            margin: EdgeInsets.only(bottom: screenHeight * 0.5, top: screenHeight * 0.5),
          ),
          SizedBox(
            width: screenHeight * 1,
          ),
          AutoSizeText(
            nomeLegenda,
            maxFontSize: 18,
            minFontSize: 16,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
