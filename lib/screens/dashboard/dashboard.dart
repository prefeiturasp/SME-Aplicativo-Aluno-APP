import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:provider/provider.dart';

import '../../controllers/event/event.controller.dart';
import '../../controllers/messages/messages.controller.dart';
import '../../models/estudante.model.dart';
import '../../models/event/event.dart';
import '../../models/message/message.dart';
import '../../ui/widgets/appbar/app_bar_escola_aqui.dart';
import '../../ui/widgets/cards/ea_resumo_outros_servico_card.dart';
import '../../utils/conection.dart';
import '../../utils/navigator.dart';
import '../calendar/event_item.dart';
import '../calendar/list_events.dart';
import '../calendar/title_event.dart';
import '../drawer_menu/drawer_menu.dart';
import '../messages/list_messages.dart';
import '../messages/view_message.dart';
import '../not_internet/not_internet.dart';
import '../widgets/cards/card_calendar.dart';
import '../widgets/cards/eaq_recent_card.dart';
import '../widgets/cards/index.dart';

class Dashboard extends StatefulWidget {
  final EstudanteModel estudante;
  final String groupSchool;
  final int codigoGrupo;
  final int userId;

  const Dashboard({
    super.key,
    required this.estudante,
    required this.groupSchool,
    required this.codigoGrupo,
    required this.userId,
  });

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  final MessagesController _messagesController = MessagesController();
  final EventController _eventController = EventController();

  @override
  void initState() {
    super.initState();
    loadingBackRecentMessage();
    _loadingCalendar();
  }

  void loadingBackRecentMessage() async {
    _messagesController.loadMessages(widget.estudante.codigoEol, widget.userId);
  }

  void _loadingCalendar() async {
    _eventController.fetchEvento(
      widget.estudante.codigoEol,
      _eventController.currentDate.month,
      _eventController.currentDate.year,
      widget.userId,
    );
  }

  Widget _buildItemMEssage(Message message, int totalCategories, BuildContext context) {
    return EAQRecentCardMessage(
      totalCateories: totalCategories,
      message: message,
      countMessages: message.categoriaNotificacao == 'SME'
          ? _messagesController.countMessageSME
          : message.categoriaNotificacao == 'UE'
              ? _messagesController.countMessageUE
              : _messagesController.countMessageDRE,
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
              codigoAlunoEol: widget.estudante.codigoEol,
            ),
          ),
        ).whenComplete(() => loadingBackRecentMessage());
      },
      outherRoutes: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListMessages(
              userId: widget.userId,
              codigoGrupo: widget.codigoGrupo,
              codigoAlunoEol: widget.estudante.codigoEol,
            ),
          ),
        ).whenComplete(() => loadingBackRecentMessage());
      },
    );
  }

  Widget listEvents(
    List<Event> events,
    BuildContext context,
  ) {
    final List<Widget> list = [];
    for (int i = 0; i < events.length; i++) {
      final String diaSemana = (events[i].diaSemana).substring(0, 1).toUpperCase() + (events[i].diaSemana).substring(1);

      list.add(
        Column(
          children: [
            EventItem(
              customTitle: TitleEvent(
                dayOfWeek: diaSemana,
                title: events[i].nome,
              ),
              titleEvent: events[i].nome,
              desc: events[i].descricao.isNotEmpty ? (events[i].descricao.length > 3 ? true : false) : false,
              eventDesc: events[i].descricao,
              dia: events[i].dataInicio,
              tipoEvento: events[i].tipoEvento,
              componenteCurricular: events[i].componenteCurricular,
            ),
            const Divider(
              color: Color(0xffCDCDCD),
            ),
          ],
        ),
      );
    }
    return Column(children: list);
  }

  Widget _listEvents(
    List<Event> events,
    BuildContext context,
  ) {
    final List<Widget> list = [];

    for (int i = 0; i < events.length; i++) {
      final String diaSemana = (events[i].diaSemana).substring(0, 1).toUpperCase() + (events[i].diaSemana).substring(1);

      list.add(
        Column(
          children: [
            EventItem(
              customTitle: TitleEvent(
                dayOfWeek: diaSemana,
                title: events[i].nome,
              ),
              titleEvent: events[i].nome,
              desc: events[i].descricao.isNotEmpty ? (events[i].descricao.length > 3 ? true : false) : false,
              eventDesc: events[i].descricao,
              dia: events[i].dataInicio,
              tipoEvento: events[i].tipoEvento,
              componenteCurricular: events[i].componenteCurricular,
            ),
            const Divider(
              color: Color(0xffCDCDCD),
            ),
          ],
        ),
      );
    }

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);
    if (connectionStatus == ConnectivityStatus.Offline) {
      return const NotInteernet();
    } else {
      final size = MediaQuery.of(context).size;
      final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
      return Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        appBar: const AppBarEscolaAqui(titulo: 'Resumo do Estudante'),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(screenHeight * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                EAResumoEstudanteCard(
                  estudante: widget.estudante,
                  modalidade: widget.groupSchool,
                  codigoGrupo: widget.codigoGrupo.toString(),
                ),
                Observer(
                  builder: (context) {
                    if (_messagesController.isLoading) {
                      return const GFLoader(
                        type: GFLoaderType.square,
                        loaderColorOne: Color(0xffDE9524),
                        loaderColorTwo: Color(0xffC65D00),
                        loaderColorThree: Color(0xffC65D00),
                        size: GFSize.LARGE,
                      );
                    } else {
                      if (_messagesController.messages != null) {
                        _messagesController.loadRecentMessagesPorCategory();

                        if (_messagesController.recentMessages!.isEmpty) {
                          return Visibility(
                            visible: true,
                            child: CardRecentMessage(
                              message: _messagesController.message,
                              countMessages: _messagesController.countMessage,
                              outherRoutes: () {},
                              onPress: () {},
                              recent: true,
                            ),
                          );
                        } else {
                          return Observer(
                            builder: (_) {
                              if (_messagesController.recentMessages != null) {
                                return Container(
                                  height: screenHeight * 48,
                                  margin: EdgeInsets.only(top: screenHeight * 3),
                                  child: Visibility(
                                    visible: _messagesController.recentMessages!.length > 1,
                                    replacement: _buildItemMEssage(
                                      _messagesController.recentMessages![0],
                                      _messagesController.recentMessages!.length,
                                      context,
                                    ),
                                    child: ListView.builder(
                                      itemCount: _messagesController.recentMessages!.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final dados = _messagesController.recentMessages;
                                        return _buildItemMEssage(dados![index], dados.length, context);
                                      },
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        }
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                ),
                Observer(
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
                      if (_eventController.priorityEvents != null) {
                        return CardCalendar(
                          heightContainer: screenHeight * 35,
                          title: 'AGENDA',
                          month: _eventController.currentMonth,
                          totalEventos: '${_eventController.events!.length} evento(s) esse mês',
                          widget: Observer(
                            builder: (_) {
                              return _listEvents(
                                _eventController.priorityEvents as List<Event>,
                                context,
                              );
                            },
                          ),
                          onPress: () {
                            Nav.push(context, ListEvents(student: widget.estudante, userId: widget.userId));
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                ),
                const EAResumoOutrosServicosCard(),
              ],
            ),
          ),
        ),
        drawer: DrawerMenu(
          estudante: widget.estudante,
          codigoGrupo: widget.codigoGrupo,
          userId: widget.userId,
          groupSchool: widget.groupSchool,
        ),
      );
    }
  }
}
