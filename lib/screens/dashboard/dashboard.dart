import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/components/loader/gf_loader.dart';
import 'package:getflutter/size/gf_size.dart';
import 'package:getflutter/types/gf_loader_type.dart';
import 'package:provider/provider.dart';
import 'package:sme_app_aluno/controllers/messages/messages.controller.dart';
import 'package:sme_app_aluno/models/event/event.dart';
import 'package:sme_app_aluno/models/message/message.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/calendar/event_item.dart';
import 'package:sme_app_aluno/screens/calendar/list_events.dart';
import 'package:sme_app_aluno/screens/calendar/title_event.dart';
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
import 'package:sme_app_aluno/utils/navigator.dart';

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
    _eventController.fetchEvento(
      widget.student.codigoEol,
      _eventController.currentDate.month,
      _eventController.currentDate.year,
      widget.userId,
    );
  }

  Widget _buildItemMEssage(
      Message message, int totalCategories, BuildContext context) {
    return EAQRecentCardMessage(
      totalCateories: totalCategories,
      message: message,
      countMessages: message.categoriaNotificacao == "SME"
          ? _messagesController.countMessageSME
          : message.categoriaNotificacao == "UE"
              ? _messagesController.countMessageUE
              : _messagesController.countMessageTurma,
      codigoGrupo: widget.codigoGrupo,
      deleteBtn: false,
      recent: !message.mensagemVisualizada,
      onPress: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewMessage(
                      userId: widget.userId,
                      message: message,
                      codigoAlunoEol: widget.student.codigoEol,
                    ))).whenComplete(() => _loadingBackRecentMessage());
      },
      outherRoutes: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListMessages(
                      userId: widget.userId,
                      codigoGrupo: widget.codigoGrupo,
                      codigoAlunoEol: widget.student.codigoEol,
                    ))).whenComplete(() => _loadingBackRecentMessage());
      },
    );
  }

  Widget _listEvents(
    List<Event> events,
    BuildContext context,
  ) {
    List<Widget> list = new List<Widget>();
    for (int i = 0; i < events.length; i++) {
      String diaSemana = (events[i].diaSemana).substring(0, 1).toUpperCase() +
          (events[i].diaSemana).substring(1);

      list.add(Column(
        children: [
          EventItem(
              customTitle: TitleEvent(
                dayOfWeek: diaSemana,
                title: events[i].nome,
              ),
              titleEvent: events[i].nome,
              desc: events[i].descricao != null
                  ? (events[i].descricao.length > 3 ? true : false)
                  : false,
              eventDesc: events[i].descricao,
              dia: events[i].dataInicio,
              tipoEvento: events[i].tipoEvento,
              componenteCurricular: events[i].componenteCurricular),
          Divider(
            color: Color(0xffCDCDCD),
          )
        ],
      ));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
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
                  CardResumeStudent(
                    student: widget.student,
                    groupSchool: widget.groupSchool,
                    userId: widget.userId,
                    child: TagCustom(
                        text: widget.groupSchool ?? "Não informado",
                        color: Color(0xffF8E5BA),
                        textColor: Color(0xffD06D12)),
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
                                child: Visibility(
                                  visible: _messagesController
                                          .recentMessages.length >
                                      1,
                                  replacement: _buildItemMEssage(
                                      _messagesController.recentMessages[0],
                                      _messagesController.recentMessages.length,
                                      context),
                                  child: ListView.builder(
                                      itemCount: _messagesController
                                          .recentMessages.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final dados =
                                            _messagesController.recentMessages;
                                        return _buildItemMEssage(dados[index],
                                            dados.length, context);
                                      }),
                                ),
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
                      if (_eventController.priorityEvents != null &&
                          _eventController.priorityEvents.isNotEmpty) {
                        return CardCalendar(
                            heightContainer: screenHeight * 48,
                            title: "AGENDA",
                            month: _eventController.currentMonth,
                            lenght: _eventController.events.length,
                            totalEventos:
                                "+ ${(_eventController.events.length >= 4 ? _eventController.events.length - 4 : _eventController.events.length - _eventController.events.length).toString()} eventos esse mês",
                            widget: Observer(builder: (_) {
                              return _listEvents(
                                _eventController.priorityEvents,
                                context,
                              );
                            }),
                            onPress: () {
                              Nav.push(
                                  context,
                                  ListEvents(
                                      student: widget.student,
                                      userId: widget.userId));
                            });
                      } else {
                        return CardAlert(
                          title: "AGENDA",
                          icon: Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Color(0xffFFD037),
                            size: screenHeight * 6,
                          ),
                          text:
                              "Não foi encontrado nenhum evento para este estudante.",
                        );
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
              userId: widget.userId,
              groupSchool: widget.groupSchool));
    }
  }
}
