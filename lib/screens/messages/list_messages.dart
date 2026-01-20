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

  Future<void> confirmDeleteMessage(int id) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você tem certeza que deseja excluir esta mensagem?'),
          actions: <Widget>[
            ElevatedButton(child: const Text('SIM'), onPressed: () => Navigator.of(context).pop(true)),
            ElevatedButton(child: const Text('NÃO'), onPressed: () => Navigator.of(context).pop(false)),
          ],
        );
      },
    );

    if (result == true) {
      await removeMesageToStorage(widget.codigoAlunoEol, id, widget.userId);
    }
  }

  Future<void> removeMesageToStorage(int codigoEol, int idNotificacao, int userId) async {
    await _messagesController.deleteMessage(codigoEol, idNotificacao, userId);
  }

  void navigateToMessage(BuildContext context, Message message) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewMessage(userId: widget.userId, message: message, codigoAlunoEol: widget.codigoAlunoEol),
      ),
    ).whenComplete(() => loadingMessages());
  }



  void _toggleFilter(String filterType) {
    setState(() {
      switch (filterType) {
        case 'sme':
          smeCheck = !smeCheck;
          break;
        case 'dre':
          dreCheck = !dreCheck;
          break;
        case 'ue':
          ueCheck = !ueCheck;
          break;
      }
    });
    _messagesController.filterItems(dreCheck, smeCheck, ueCheck);
  }

 Widget _buildMessageCard(Message item, double screenHeight, BuildContext context) {
  return GestureDetector(
    onTap: () => navigateToMessage(context, item),
    child: CardMessage( // Remove o Container com margin daqui
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
        SizedBox(height: screenHeight * 1.8),
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
        SizedBox(height: screenHeight * 3),
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
            onTap: () => confirmDeleteMessage(item.id),
            child: Container(
              width: screenHeight * 6,
              height: screenHeight * 6,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffC65D00), width: 1),
                borderRadius: BorderRadius.circular(screenHeight * 3),
              ),
              child: Icon(FontAwesomeIcons.trashCan, color: const Color(0xffC65D00), size: screenHeight * 2.5),
            ),
          ),
        ),
        Container(
          height: screenHeight * 6,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffC65D00), width: 1),
            borderRadius: BorderRadius.circular(screenHeight * 3),
          ),
          child: ElevatedButton(
            onPressed: () => navigateToMessage(context, item),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffF2F1EE),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenHeight * 3)),
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
                SizedBox(width: screenHeight * 2),
                const Icon(FontAwesomeIcons.envelopeOpen, color: Color(0xffffd037), size: 16),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget listCardsMessages(List<Message> messages, BuildContext context, double screenHeight) {
  final filteredMessages = messages.skip(1).toList();

  if (filteredMessages.isEmpty) {
    return const SizedBox.shrink();
  }

  return Column(
    children: filteredMessages.asMap().entries.map((entry) {
      return Container(
        margin: EdgeInsets.only(
          top: entry.key == 0 ? screenHeight * 2 : screenHeight * 3,
        ),
        child: _buildMessageCard(entry.value, screenHeight, context),
      );
    }).toList(),
  );
}

 Widget buildListMessages(BuildContext context, double screenHeight) {
  return Observer(
    builder: (context) {
      if (_messagesController.isLoading) {
        return const Center(
          child: GFLoader(
            type: GFLoaderType.square,
            loaderColorOne: Color(0xffDE9524),
            loaderColorTwo: Color(0xffC65D00),
            loaderColorThree: Color(0xffC65D00),
            size: GFSize.LARGE,
          ),
        );
      }

      if (_messagesController.messages == null || _messagesController.messages!.isEmpty) {
        return Container(
          margin: EdgeInsets.only(top: screenHeight * 2.5),
          child: const Column(
            children: <Widget>[
              Text(
                'Nenhuma mensagem está disponível para este aluno',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Divider(color: Color(0xffcecece)),
            ],
          ),
        );
      }


      final firstMessage = _messagesController.messages!.first;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 3),
          const Text(
            'MENSAGEM MAIS RECENTE',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xffDE9524),
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 2),
            child: _buildMessageCard(firstMessage, screenHeight, context),
          ),
          SizedBox(height: screenHeight * 5),
          if (_messagesController.messages!.length > 1) ...[
            Text(
              (_messagesController.messages!.length - 1) == 1
                  ? '${_messagesController.messages!.length - 1} MENSAGEM ANTIGA'
                  : '${_messagesController.messages!.length - 1} MENSAGENS ANTIGAS',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xffDE9524),
                fontWeight: FontWeight.w500,
              ),
            ),
            EAQFilterPage(
              items: <Widget>[
                const Text(
                  'Filtro:',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff666666),
                  ),
                ),
                _buildFilterChip('SME', smeCheck, const Color(0xffEFA2FC), screenHeight, 'sme'),
                _buildFilterChip('DRE', dreCheck, const Color(0xffC5DBA0), screenHeight, 'dre'),
                _buildFilterChip('UE', ueCheck, const Color(0xffC7C7FF), screenHeight, 'ue'),
              ],
            ),
            _buildFilteredMessagesList(screenHeight, context),
          ],
        ],
      );
    },
  );
}



Widget _buildFilterChip(String label, bool isSelected, Color activeColor, double screenHeight, String filterType) {
  return InkWell(
    onTap: () => _toggleFilter(filterType),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenHeight * 2,
        vertical: screenHeight * 1,
      ),
      decoration: BoxDecoration(
        color: isSelected ? activeColor : const Color(0xffDADADA),
        borderRadius: BorderRadius.circular(screenHeight * 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            Icon(
              FontAwesomeIcons.check,
              size: screenHeight * 1.5,
              color: const Color(0xff42474A),
            ),
            SizedBox(width: screenHeight * 0.5),
          ],
          Text(
            label,
            style: const TextStyle(
              color: Color(0xff42474A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}


 Widget _buildFilteredMessagesList(double screenHeight, BuildContext context) {
  if (_messagesController.filteredList != null && _messagesController.filteredList!.isNotEmpty) {
    return Column(
      children: _messagesController.filteredList!.asMap().entries.map((entry) {
        return Container(
          margin: EdgeInsets.only(top: screenHeight * 3),
          child: _buildMessageCard(entry.value, screenHeight, context),
        );
      }).toList(),
    );
  } else if (!dreCheck && !smeCheck && !ueCheck) {
    return Container(
      padding: EdgeInsets.all(screenHeight * 2.5),
      margin: EdgeInsets.only(top: screenHeight * 2.5),
      child: const Text(
        'Selecione uma categoria para visualizar as mensagens.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff727374),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.all(screenHeight * 4),
      margin: EdgeInsets.only(top: screenHeight * 2.5),
      child: const Text(
        'Não foi encontrada nenhuma mensagem para este filtro',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff727374),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.offline) {
      return const NotInteernet();
    }

    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: const AppBarEscolaAqui(titulo: 'Mensagens'),
      body: RefreshIndicator(
        onRefresh: () async {
          await _messagesController.loadMessages(widget.codigoAlunoEol, widget.userId);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 2.5, vertical: screenHeight * 2.5),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[buildListMessages(context, screenHeight)]),
          ),
        ),
      ),
    );
  }
}
