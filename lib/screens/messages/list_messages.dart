import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import '../../controllers/messages/messages.controller.dart';
import '../../models/message/message.dart';
import '../../ui/widgets/appbar/app_bar_escola_aqui.dart';
import '../../utils/conection.dart';
import '../../utils/date_format.dart';
import '../../utils/string_support.dart';
import '../not_internet/not_internet.dart';
import '../widgets/cards/index.dart';
import '../widgets/filters/eaq_filter_page.dart';
import 'view_message.dart';

class ListMessages extends StatefulWidget {
  final int codigoGrupo;
  final int codigoAlunoEol;
  final int userId;

  const ListMessages({super.key, required this.codigoGrupo, required this.codigoAlunoEol, required this.userId});
  @override
  ListMessageState createState() => ListMessageState();
}

class ListMessageState extends State<ListMessages> {
  final MessagesController _messagesController = MessagesController();
  final List<Message> listOfmessages = [];
  bool dreCheck = true;
  bool smeCheck = true;
  bool ueCheck = true;

  @override
  void initState() {
    super.initState();
    loadingMessages();
  }

  void loadingMessages() {
    _messagesController.loadMessages(widget.codigoAlunoEol, widget.userId);
  }

  Future<bool> confirmDeleteMessage(int id) async {
    bool retorno = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você tem certeza que deseja excluir esta mensagem?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                removeMesageToStorage(
                  widget.codigoAlunoEol,
                  id,
                  widget.userId,
                );

                Navigator.of(context).pop(true);
                retorno = true;
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                Navigator.of(context).pop(false);
                retorno = false;
              },
            ),
          ],
        );
      },
    );
    return retorno;
  }

  Future<void> removeMesageToStorage(int codigoEol, int idNotificacao, int userId) async {
    await _messagesController.deleteMessage(codigoEol, idNotificacao, userId);
  }

  void navigateToMessage(BuildContext context, Message message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ViewMessage(userId: widget.userId, message: message, codigoAlunoEol: widget.codigoAlunoEol),
      ),
    ).whenComplete(() => loadingMessages());
  }

  Widget listCardsMessages(
    List<Message> messages,
    BuildContext context,
    double screenHeight,
  ) {
    return Column(
      children: messages
          .where((e) => e.id != _messagesController.messages![0].id)
          .toList()
          .map(
            (item) => GestureDetector(
              onTap: () {
                navigateToMessage(context, item);
              },
              child: CardMessage(
                headerTitle: item.categoriaNotificacao,
                headerIcon: true,
                recentMessage: !item.mensagemVisualizada,
                categoriaNotificacao: item.categoriaNotificacao,
                content: <Widget>[
                  SizedBox(
                    width: screenHeight * 39,
                    child: AutoSizeText(
                      item.titulo,
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 2,
                      style: const TextStyle(color: Color(0xff42474A), fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 1.8,
                  ),
                  SizedBox(
                    width: screenHeight * 39,
                    child: AutoSizeText(
                      StringSupport.parseHtmlString(StringSupport.truncateEndString(item.mensagem, 250)),
                      maxFontSize: 16,
                      minFontSize: 14,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: const Color(0xff929292), height: screenHeight * 0.240),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 3,
                  ),
                  AutoSizeText(
                    DateFormatSuport.formatStringDate(item.criadoEm, 'dd/MM/yyyy'),
                    maxFontSize: 16,
                    minFontSize: 14,
                    maxLines: 2,
                    style: const TextStyle(color: Color(0xff929292), fontWeight: FontWeight.w700),
                  ),
                ],
                footer: true,
                footerContent: <Widget>[
                  Visibility(
                    visible: item.mensagemVisualizada,
                    child: GestureDetector(
                      onTap: () async {
                        await confirmDeleteMessage(item.id);
                      },
                      child: Container(
                        width: screenHeight * 6,
                        height: screenHeight * 6,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffC65D00), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 3),
                          ),
                        ),
                        child: Icon(
                          FontAwesomeIcons.trashCan,
                          color: const Color(0xffC65D00),
                          size: screenHeight * 2.5,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffC65D00), width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenHeight * 3),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => ViewMessage(
                                  message: item,
                                  codigoAlunoEol: widget.codigoAlunoEol,
                                  userId: widget.userId,
                                ),
                              ),
                            )
                            .whenComplete(() => loadingMessages());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF2F1EE),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenHeight * 3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const AutoSizeText(
                            'LER MENSAGEM',
                            maxFontSize: 16,
                            minFontSize: 14,
                            style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: screenHeight * 2,
                          ),
                          const Icon(
                            FontAwesomeIcons.envelopeOpen,
                            color: Color(0xffffd037),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildListMessages(BuildContext context, double screenHeight) {
    return Observer(
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
          _messagesController.loadMessageToFilters(dreCheck, smeCheck, ueCheck);
          if (_messagesController.messages!.isEmpty) {
            return Container(
              margin: EdgeInsets.only(top: screenHeight * 2.5),
              child: Visibility(
                visible: _messagesController.messages!.isEmpty,
                child: const Column(
                  children: <Widget>[
                    AutoSizeText(
                      'Nenhuma mensagem está disponível para este aluno',
                      maxFontSize: 18,
                      minFontSize: 16,
                    ),
                    Divider(
                      color: Color(0xffcecece),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 3,
                ),
                const AutoSizeText(
                  'MENSAGEM MAIS RECENTE',
                  maxFontSize: 18,
                  minFontSize: 16,
                  style: TextStyle(color: Color(0xffDE9524), fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    navigateToMessage(context, _messagesController.messages!.first);
                  },
                  child: CardMessage(
                    headerTitle: _messagesController.messages!.first.categoriaNotificacao,
                    headerIcon: true,
                    recentMessage: !_messagesController.messages!.first.mensagemVisualizada,
                    categoriaNotificacao: _messagesController.messages!.first.categoriaNotificacao,
                    content: <Widget>[
                      SizedBox(
                        width: screenHeight * 39,
                        child: AutoSizeText(
                          _messagesController.messages!.first.titulo,
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 2,
                          style: const TextStyle(color: Color(0xff42474A), fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 1.8,
                      ),
                      SizedBox(
                        width: screenHeight * 39,
                        child: AutoSizeText(
                          StringSupport.parseHtmlString(_messagesController.messages!.first.mensagem),
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: const Color(0xff929292),
                            height: screenHeight * 0.240,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 3,
                      ),
                      AutoSizeText(
                        DateFormatSuport.formatStringDate(_messagesController.messages!.first.criadoEm, 'dd/MM/yyyy'),
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 2,
                        style: const TextStyle(color: Color(0xff929292), fontWeight: FontWeight.w700),
                      ),
                    ],
                    footer: true,
                    footerContent: <Widget>[
                      Visibility(
                        visible: _messagesController.messages!.first.mensagemVisualizada,
                        child: GestureDetector(
                          onTap: () async {
                            await confirmDeleteMessage(_messagesController.messages!.first.id)
                                .whenComplete(() => loadingMessages());
                          },
                          child: Container(
                            width: screenHeight * 6,
                            height: screenHeight * 6,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffC65D00), width: 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight * 3),
                              ),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.trashCan,
                              color: Color(0xffC65D00),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 6,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffC65D00), width: 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 3),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            navigateToMessage(context, _messagesController.messages!.first);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF2F1EE),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenHeight * 3),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              const AutoSizeText(
                                'LER MENSAGEM',
                                maxFontSize: 16,
                                minFontSize: 14,
                                style: TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: screenHeight * 2,
                              ),
                              const Icon(
                                FontAwesomeIcons.envelope,
                                color: Color(0xffffd037),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 5,
                ),
                _messagesController.messages!.length == 1
                    ? Container()
                    : AutoSizeText(
                        (_messagesController.messages!.length - 1) == 1
                            ? '${_messagesController.messages!.length - 1} MENSAGEM ANTIGA'
                            : '${_messagesController.messages!.length - 1} MENSAGENS ANTIGAS',
                        maxFontSize: 18,
                        minFontSize: 16,
                        style: const TextStyle(color: Color(0xffDE9524), fontWeight: FontWeight.w500),
                      ),
                EAQFilterPage(
                  items: <Widget>[
                    const AutoSizeText(
                      'Filtro:',
                      maxFontSize: 14,
                      minFontSize: 12,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff666666)),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          smeCheck = !smeCheck;
                        });
                        _messagesController.filterItems(dreCheck, smeCheck, ueCheck);
                      },
                      child: Chip(
                        backgroundColor: smeCheck ? const Color(0xffEFA2FC) : const Color(0xffDADADA),
                        avatar: smeCheck
                            ? Icon(
                                FontAwesomeIcons.check,
                                size: screenHeight * 2,
                              )
                            : null,
                        label: const AutoSizeText('SME', style: TextStyle(color: Color(0xff42474A))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dreCheck = !dreCheck;
                        });
                        _messagesController.filterItems(dreCheck, smeCheck, ueCheck);
                      },
                      child: Chip(
                        backgroundColor: dreCheck ? const Color(0xffC5DBA0) : const Color(0xffDADADA),
                        avatar: dreCheck
                            ? Icon(
                                FontAwesomeIcons.check,
                                size: screenHeight * 2,
                              )
                            : null,
                        label: const AutoSizeText(
                          'DRE',
                          style: TextStyle(color: Color(0xff42474A)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          ueCheck = !ueCheck;
                        });
                        _messagesController.filterItems(dreCheck, smeCheck, ueCheck);
                      },
                      child: Chip(
                        backgroundColor: ueCheck ? const Color(0xffC7C7FF) : const Color(0xffDADADA),
                        avatar: ueCheck
                            ? Icon(
                                FontAwesomeIcons.check,
                                size: screenHeight * 2,
                              )
                            : null,
                        label: const AutoSizeText('UE', style: TextStyle(color: Color(0xff42474A))),
                      ),
                    ),
                  ],
                ),
                Observer(
                  builder: (context) {
                    if (_messagesController.filteredList != null) {
                      return listCardsMessages(_messagesController.filteredList!, context, screenHeight);
                    } else if (!dreCheck && !smeCheck && !ueCheck) {
                      return Container(
                        padding: EdgeInsets.all(screenHeight * 2.5),
                        margin: EdgeInsets.only(top: screenHeight * 2.5),
                        child: const AutoSizeText(
                          'Selecione uma categoria para visualizar as mensagens.',
                          textAlign: TextAlign.center,
                          minFontSize: 14,
                          maxFontSize: 16,
                          style: TextStyle(
                            color: Color(0xff727374),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.all(screenHeight * 4),
                        margin: EdgeInsets.only(top: screenHeight * 2.5),
                        child: const AutoSizeText(
                          'Não foi encontrada nenhuma mensagem para este filtro',
                          textAlign: TextAlign.center,
                          minFontSize: 14,
                          maxFontSize: 16,
                          style: TextStyle(
                            color: Color(0xff727374),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }
        }
      },
    );
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
        appBar: const AppBarEscolaAqui(
          titulo: 'Mensagens',
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await _messagesController.loadMessages(widget.codigoAlunoEol, widget.userId);
          },
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 2.5, vertical: screenHeight * 2.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildListMessages(context, screenHeight),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
