import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/controllers/event/event.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/calendar/event.dart';
import 'package:sme_app_aluno/screens/widgets/student_info/student_info.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';

class ListEvents extends StatefulWidget {
  final Student student;
  final int userId;

  ListEvents({
    @required this.student,
    @required this.userId,
  });
  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  EventController _eventController;
  DateTime _dateTime = DateTime.now();
  String _mesAtual;
  int _month;

  @override
  void initState() {
    super.initState();
    _month = _dateTime.month;
    _eventController = EventController();
    _eventController.fetchEvento(
        widget.student.codigoEol, _month, _dateTime.year, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    switch (_month) {
      case 1:
        _mesAtual = "Janeiro";
        break;
      case 2:
        _mesAtual = "Fevereiro";
        break;
      case 3:
        _mesAtual = "Março";
        break;
      case 4:
        _mesAtual = "Abril";
        break;
      case 5:
        _mesAtual = "Maio";
        break;
      case 6:
        _mesAtual = "Junho";
        break;
      case 7:
        _mesAtual = "Julho";
        break;
      case 8:
        _mesAtual = "Agosto";
        break;
      case 9:
        _mesAtual = "Setembro";
        break;
      case 10:
        _mesAtual = "Outubro";
        break;
      case 11:
        _mesAtual = "Novembro";
        break;
      case 12:
        _mesAtual = "Dezembro";
        break;
    }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(screenHeight * 2.5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xffC5C5C5), width: 0.5))),
                    child: StudentInfo(
                      studentName: widget.student.nomeSocial != null
                          ? widget.student.nomeSocial
                          : widget.student.nome,
                      schoolName: widget.student.escola,
                      schoolType: widget.student.descricaoTipoEscola,
                      studentGrade: widget.student.turma,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight * 2),
                width: screenHeight * 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.angleLeft,
                          color: _month > 1
                              ? Color(0xffC45C04)
                              : Colors.transparent,
                          size: screenHeight * 3,
                        ),
                        onPressed: () async {
                          if (_month > 1) {
                            setState(() {
                              _month--;
                            });
                            await _eventController.fetchEvento(
                                widget.student.codigoEol,
                                _month,
                                _dateTime.year,
                                widget.userId);
                          }
                        }),
                    AutoSizeText(
                      _mesAtual,
                      maxFontSize: 18,
                      minFontSize: 16,
                      style: TextStyle(
                          color: Color(0xffC45C04),
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                        icon: Icon(
                          FontAwesomeIcons.angleRight,
                          color: _month < 12
                              ? Color(0xffC45C04)
                              : Colors.transparent,
                          size: screenHeight * 3,
                        ),
                        onPressed: () async {
                          if (_month < 12) {
                            setState(() {
                              _month++;
                            });
                            await _eventController.fetchEvento(
                                widget.student.codigoEol,
                                _month,
                                _dateTime.year,
                                widget.userId);
                          }
                        }),
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
                    if (_eventController.events.isNotEmpty) {
                      return Observer(builder: (_) {
                        if (_eventController.events != null) {
                          return Container(
                              height: screenHeight * 60,
                              child: ListView.builder(
                                  itemCount: _eventController.events.length,
                                  itemBuilder: (context, index) {
                                    final dados = _eventController.events;
                                    dados.sort((a, b) =>
                                        a.dataInicio.compareTo(b.dataInicio));
                                    return Event(
                                      nome: dados[index].nome,
                                      desc: dados[index].descricao.length > 3
                                          ? true
                                          : false,
                                      eventDesc: dados[index].descricao,
                                      dia: dados[index].dataInicio,
                                      tipoEvento: dados[index].tipoEvento,
                                    );
                                  }));
                        } else {
                          return Container();
                        }
                      });
                    } else {
                      return Container(
                          height: screenHeight * 60,
                          child: Center(
                            child: AutoSizeText(
                              "Este estudante não possui eventos vinculados para este mês!",
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
            ],
          ),
        ),
      ),
    );
  }
}
