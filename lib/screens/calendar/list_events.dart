import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/controllers/event/event.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/calendar/event.dart';
import 'package:sme_app_aluno/screens/widgets/student_info/student_info.dart';

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
  String month = "Setembro";
  EventController _eventController;

  @override
  void initState() {
    super.initState();
    _eventController = EventController();
    _eventController.fetchEvento(
        widget.student.codigoEol, 9, 2020, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

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
                          color: Color(0xffC45C04),
                          size: screenHeight * 3,
                        ),
                        onPressed: () {}),
                    AutoSizeText(
                      month,
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
                          color: Color(0xffC45C04),
                          size: screenHeight * 3,
                        ),
                        onPressed: () {}),
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
                  child: Observer(builder: (_) {
                    if (_eventController.events != null) {
                      return Container(
                          height: screenHeight * 48,
                          margin: EdgeInsets.only(top: screenHeight * 3),
                          child: ListView.builder(
                              itemCount: _eventController.events.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final dados = _eventController.event;
                                return Event(
                                  nome: dados.nome,
                                  desc: dados.descricao != null ? true : false,
                                  eventDesc: dados.descricao,
                                  dia: dados.dataInicio,
                                  tipoEvento: dados.tipoEvento,
                                );
                              }));
                    } else {
                      return Container();
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
