import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

import '../../constantes/colors.dart';
import '../../controllers/event/event.controller.dart';
import '../../models/estudante.model.dart';
import '../../models/event/event.dart';
import '../../ui/index.dart';
import 'event_item.dart';
import 'label_event.dart';
import 'title_event.dart';

class ListEvents extends StatefulWidget {
  final EstudanteModel student;
  final int userId;

  const ListEvents({
    super.key,
    required this.student,
    required this.userId,
  });
  @override
  ListEventsState createState() => ListEventsState();
}

class ListEventsState extends State<ListEvents> {
  EventController _eventController = EventController();

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
    final String diaSemana = (event.diaSemana).substring(0, 1).toUpperCase() + (event.diaSemana).substring(1);

    return Column(
      children: [
        EventItem(
          customTitle: TitleEvent(
            dayOfWeek: diaSemana,
            title: event.nome,
          ),
          titleEvent: event.nome,
          desc: event.descricao.isNotEmpty ? (event.descricao.length > 3 ? true : false) : false,
          eventDesc: event.descricao,
          dia: event.dataInicio,
          tipoEvento: event.tipoEvento,
          componenteCurricular: event.componenteCurricular,
        ),
        const Divider(
          color: dividerColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        title: const Text('Agenda'),
        backgroundColor: const Color(0xffEEC25E),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xffE5E5E5),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
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
                      nome: widget.student.nome.isNotEmpty ? widget.student.nome : widget.student.nome,
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
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  color: Color(0xFFF3F3F3),
                ),
                // width: screenHeight * 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.angleLeft,
                        color: _currentMonth > 1 ? const Color(0xffC45C04) : Colors.transparent,
                        size: screenHeight * 3,
                      ),
                      onPressed: _currentMonth > 1
                          ? () async {
                              setState(() => _currentMonth--);
                              if (_currentMonth >= 1) {
                                await _eventController.changeCurrentMonth(
                                  _currentMonth,
                                  widget.student.codigoEol,
                                  widget.userId,
                                );
                              }
                            }
                          : null,
                    ),
                    Observer(
                      builder: (_) {
                        return AutoSizeText(
                          _eventController.currentMonth!.toUpperCase(),
                          maxFontSize: 18,
                          minFontSize: 16,
                          style: const TextStyle(color: Color(0xffC45C04), fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.angleRight,
                        color: _currentMonth < 12 ? const Color(0xffC45C04) : Colors.transparent,
                        size: screenHeight * 3,
                      ),
                      onPressed: _currentMonth < 12
                          ? () async {
                              setState(() => _currentMonth++);
                              if (_currentMonth <= 12) {
                                await _eventController.changeCurrentMonth(
                                  _currentMonth,
                                  widget.student.codigoEol,
                                  widget.userId,
                                );
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(screenHeight * 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenHeight * 2),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 2),
                      blurRadius: 2,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(screenHeight * 1.5),
                child: Observer(
                  builder: (context) {
                    if (_eventController.loading) {
                      return Container(
                        margin: EdgeInsets.all(screenHeight * 1.5),
                        child: const GFLoader(
                          type: GFLoaderType.square,
                          loaderColorOne: Color(0xffDE9524),
                          loaderColorTwo: Color(0xffC65D00),
                          loaderColorThree: Color(0xffC65D00),
                          size: GFSize.LARGE,
                        ),
                      );
                    } else {
                      if (_eventController.eventsSortDate != null) {
                        return Observer(
                          builder: (_) {
                            if (_eventController.events != null) {
                              return SizedBox(
                                height: screenHeight * 50,
                                child: Scrollbar(
                                  child: ListView.builder(
                                    itemCount: _eventController.eventsSortDate!.length,
                                    itemBuilder: (context, index) {
                                      return _eventItemBuild(_eventController.eventsSortDate![index], context);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        return SizedBox(
                          height: screenHeight * 60,
                          child: const Center(
                            child: AutoSizeText(
                              'Não foi encontrado nenhum evento para este estudante.',
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 10,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: screenHeight * 7,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelEvent(labelName: 'Avaliação', labelColor: colorAvaliacao),
                    LabelEvent(labelName: 'Dias sem aula', labelColor: colorDiasSemAula),
                    LabelEvent(labelName: 'Demais eventos', labelColor: colorDemaisEventos),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget legenda(String nomeLegenda, Color corLegenda) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Row(
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
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
