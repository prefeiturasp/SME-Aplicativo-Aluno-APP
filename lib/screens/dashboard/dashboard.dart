import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/calendar/list_events.dart';
import 'package:sme_app_aluno/screens/messages/list_messages.dart';
import 'package:sme_app_aluno/screens/messages/view_message.dart';
import 'package:sme_app_aluno/screens/not_internet/not_internet.dart';
import 'package:sme_app_aluno/screens/widgets/cards/card_calendar.dart';
import 'package:sme_app_aluno/screens/widgets/cards/eaq_recent_card.dart';
import 'package:sme_app_aluno/screens/widgets/cards/index.dart';
import 'package:sme_app_aluno/screens/drawer_menu/drawer_menu.dart';
import 'package:sme_app_aluno/screens/widgets/tag/tag_custom.dart';
import 'package:sme_app_aluno/utils/conection.dart';
import 'package:sme_app_aluno/controllers/event/event.controller.dart';
import 'package:sme_app_aluno/screens/calendar/event.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Dashboard extends StatefulWidget {
  final Student student;
  final String groupSchool;
  final int codigoGrupo;
  final int userId;

  Dashboard(
      {@required this.student,
      @required this.groupSchool,
      @required this.codigoGrupo,
      @required this.userId});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MessagesController _messagesController;
  EventController _eventController;
  DateTime _dateTime = DateTime.now();
  String _mesAtual;

  @override
  void initState() {
    super.initState();
    _loadingBackRecentMessage();
    _loadingCalendar();
  }

  _loadingBackRecentMessage() async {
    setState(() {});
    _messagesController = MessagesController();
    _messagesController.loadMessages(widget.student.codigoEol, widget.userId);
  }

  _loadingCalendar() async {
    _eventController = EventController();
    _eventController.fetchEvento(widget.student.codigoEol, _dateTime.month,
        _dateTime.year, widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    switch (_dateTime.month) {
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

    if (connectionStatus == ConnectivityStatus.Offline) {
      // BackgroundFetch.stop().then((int status) {
      //   print('[BackgroundFetch] stop success: $status');
      // });
      return NotInteernet();
    } else {
      var size = MediaQuery.of(context).size;
      var screenHeight =
          (size.height - MediaQuery.of(context).padding.top) / 100;
      return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          title: Text("Resumo do Estudante"),
          backgroundColor: Color(0xffEEC25E),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 2.5,
                ),
                TagCustom(
                    text: widget.groupSchool ?? "Não informado",
                    color: Color(0xffEEC25E),
                    textColor: Color(0xffD06D12)),
                CardResumeStudent(
                  student: widget.student,
                ),
                Observer(builder: (context) {
                  if (_messagesController.isLoading) {
                    return GFLoader(
                      type: GFLoaderType.square,
                      loaderColorOne: Color(0xffDE9524),
                      loaderColorTwo: Color(0xffC65D00),
                      loaderColorThree: Color(0xffC65D00),
                      size: GFSize.LARGE,
                    );
                  } else {
                    if (_messagesController.messages != null) {
                      _messagesController.loadRecentMessagesPorCategory();

                      if (_messagesController.messages == null ||
                          _messagesController.messages.isEmpty) {
                        return Container(
                          child: Visibility(
                              visible: _messagesController.messages != null &&
                                  _messagesController.messages.isEmpty,
                              child: CardRecentMessage(
                                recent: true,
                              )),
                        );
                      } else {
                        return Observer(builder: (_) {
                          if (_messagesController.recentMessages != null) {
                            return Container(
                              height: screenHeight * 48,
                              margin: EdgeInsets.only(top: screenHeight * 3),
                              child: ListView.builder(
                                  itemCount:
                                      _messagesController.recentMessages.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final dados =
                                        _messagesController.recentMessages;
                                    return EAQRecentCardMessage(
                                      totalCateories: dados.length,
                                      message: dados[index],
                                      countMessages: dados[index]
                                                  .categoriaNotificacao ==
                                              "SME"
                                          ? _messagesController.countMessageSME
                                          : dados[index].categoriaNotificacao ==
                                                  "UE"
                                              ? _messagesController
                                                  .countMessageUE
                                              : _messagesController
                                                  .countMessageTurma,
                                      codigoGrupo: widget.codigoGrupo,
                                      deleteBtn: false,
                                      recent: !dados[index].mensagemVisualizada,
                                      onPress: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewMessage(
                                                      userId: widget.userId,
                                                      message: dados[index],
                                                      codigoAlunoEol: widget
                                                          .student.codigoEol,
                                                    ))).whenComplete(
                                            () => _loadingBackRecentMessage());
                                      },
                                      outherRoutes: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListMessages(
                                                      userId: widget.userId,
                                                      codigoGrupo:
                                                          widget.codigoGrupo,
                                                      codigoAlunoEol: widget
                                                          .student.codigoEol,
                                                    ))).whenComplete(
                                            () => _loadingBackRecentMessage());
                                      },
                                    );
                                  }),
                            );
                          } else {
                            return Container();
                          }
                        });
                      }
                    } else {
                      return GFLoader(
                        type: GFLoaderType.square,
                        loaderColorOne: Color(0xffDE9524),
                        loaderColorTwo: Color(0xffC65D00),
                        loaderColorThree: Color(0xffC65D00),
                        size: GFSize.LARGE,
                      );
                    }
                  }
                }),
                Observer(builder: (context) {
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
                      return CardCalendar(
                          title: "AGENDA",
                          month: _mesAtual,
                          lenght: _eventController.events.length,
                          totalEventos:
                              "+ ${_eventController.events.length.toString()} eventos esse mês",
                          widget: Observer(builder: (_) {
                            if (_eventController.events != null) {
                              return Container(
                                  height: screenHeight * 38,
                                  child: ListView.builder(
                                      itemCount:
                                          _eventController.events.length <= 4
                                              ? _eventController.events.length
                                              : 4,
                                      itemBuilder: (context, index) {
                                        final dados = _eventController.events;
                                        dados.sort((a, b) => a.dataInicio
                                            .compareTo(b.dataInicio));
                                        return Event(
                                          nome: dados[index].nome,
                                          desc:
                                              dados[index].descricao.length > 3
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
                          }),
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListEvents(
                                        student: widget.student,
                                        userId: widget.userId)));
                          });
                    } else {
                      return CardCalendar(
                          title: "AGENDA",
                          month: _mesAtual,
                          lenght: 1,
                          totalEventos:
                              "+ ${_eventController.events.length.toString()} eventos esse mês",
                          widget: Observer(builder: (_) {
                            if (_eventController.events != null) {
                              return Container(
                                  height: screenHeight * 15,
                                  width: screenHeight * 41,
                                  child: Center(
                                    child: AutoSizeText(
                                      'Este estudante não possui eventos vinculados para este mês!',
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
                            } else {
                              return Container();
                            }
                          }),
                          onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListEvents(
                                        student: widget.student,
                                        userId: widget.userId)));
                          });
                    }
                  }
                }),
                CardAlert(
                  title: "ALERTA DE NOTAS",
                  icon: Icon(
                    FontAwesomeIcons.envelopeOpen,
                    color: Color(0xffFFD037),
                    size: screenHeight * 6,
                  ),
                  text:
                      "Em breve você visualizará alertas de notas neste espaço. Aguarde as próximas atualizações do aplicativo.",
                ),
                CardAlert(
                  title: "ALERTA DE FREQUÊNCIA",
                  icon: Icon(
                    FontAwesomeIcons.envelopeOpen,
                    color: Color(0xffFFD037),
                    size: screenHeight * 6,
                  ),
                  text:
                      "Em breve você visualizará alertas de frequência neste espaço. Aguarde as próximas atualizações do aplicativo.",
                )
              ],
            ),
          ),
        ),
        drawer: DrawerMenu(
            student: widget.student,
            codigoGrupo: widget.codigoGrupo,
            userId: widget.userId),
      );
    }
  }
}
