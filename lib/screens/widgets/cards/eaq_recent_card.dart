import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/message/message.dart';
import '../../../services/message.service.dart';
import '../../../ui/widgets/buttons/ea_deafult_button.widget.dart';
import '../../../utils/date_format.dart';
import '../../../utils/string_support.dart';

class EAQRecentCardMessage extends StatefulWidget {
  final Message message;
  final int countMessages;
  final int codigoGrupo;
  final bool deleteBtn;
  final bool recent;
  final VoidCallback onPress;
  final VoidCallback outherRoutes;
  final int totalCateories;

  const EAQRecentCardMessage({
    super.key,
    required this.message,
    required this.countMessages,
    required this.codigoGrupo,
    required this.outherRoutes,
    this.deleteBtn = true,
    this.recent = false,
    required this.onPress,
    required this.totalCateories,
  });

  @override
  EAQRecentCardMessageState createState() => EAQRecentCardMessageState();
}

class EAQRecentCardMessageState extends State<EAQRecentCardMessage> {
  final serviceMessage = MessageService();
  Future<void> _confirmDeleteMessage(int id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const Text('Você tem certeza que deseja excluir esta mensagem?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                removeMesageToStorage(id);
              },
            ),
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      },
    );
  }

  Future<dynamic> removeMesageToStorage(int id) async {
    await serviceMessage.delete(id);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    const colorSME = Color(0xff9C33AD);
    const colorUE = Color(0xff5151CF);
    const colorDRE = Color(0xff599E00);
    return Container(
      width: widget.totalCateories == 1 ? MediaQuery.of(context).size.width : screenHeight * 40,
      margin: EdgeInsets.only(
        top: screenHeight * 1,
        right: widget.totalCateories == 1 ? 0.0 : screenHeight * 1.5,
      ),
      decoration: BoxDecoration(
        color: widget.message == null ? const Color(0xffC45C04) : Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(screenHeight * 1.9),
            decoration: BoxDecoration(
              color: widget.message.categoriaNotificacao == 'SME'
                  ? widget.recent
                      ? colorSME
                      : colorSME.withOpacity(0.4)
                  : widget.message.categoriaNotificacao == 'UE'
                      ? widget.recent
                          ? colorUE
                          : colorUE.withOpacity(0.4)
                      : widget.recent
                          ? colorDRE
                          : colorDRE.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenHeight * 2),
                topRight: Radius.circular(screenHeight * 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      widget.recent ? FontAwesomeIcons.envelope : FontAwesomeIcons.envelopeOpen,
                      color: widget.recent
                          ? const Color(0xffFFD037)
                          : widget.message.categoriaNotificacao == 'SME'
                              ? colorSME
                              : widget.message.categoriaNotificacao == 'UE'
                                  ? colorUE
                                  : colorDRE,
                      size: screenHeight * 2.3,
                    ),
                    SizedBox(
                      width: screenHeight * 1.5,
                    ),
                    AutoSizeText(
                      widget.message.categoriaNotificacao,
                      maxFontSize: 18,
                      minFontSize: 16,
                      style: TextStyle(
                        color: widget.recent
                            ? Colors.white
                            : widget.message.categoriaNotificacao == 'SME'
                                ? colorSME
                                : widget.message.categoriaNotificacao == 'UE'
                                    ? colorUE
                                    : colorDRE,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: widget.countMessages > 0,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Container(
                        width: screenHeight * 3.2,
                        height: screenHeight * 3.2,
                        decoration: BoxDecoration(
                          color: widget.recent
                              ? const Color(0xffFFCF00)
                              : widget.message.categoriaNotificacao == 'SME'
                                  ? colorSME
                                  : widget.message.categoriaNotificacao == 'UE'
                                      ? colorUE
                                      : colorDRE,
                          borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 1.750),
                          ),
                        ),
                        child: Icon(
                          widget.recent ? FontAwesomeIcons.envelope : FontAwesomeIcons.envelopeOpen,
                          color: !widget.recent ? const Color(0xffffffff) : const Color(0xffC65D00),
                          size: 10,
                        ),
                      ),
                      Positioned(
                        top: -8.0,
                        right: 0.0,
                        child: Container(
                          width: screenHeight * 2.5,
                          height: screenHeight * 2.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 1.5),
                            ),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              '${widget.countMessages}',
                              maxFontSize: 12,
                              minFontSize: 10,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.message.categoriaNotificacao == 'SME'
                                    ? colorSME
                                    : widget.message.categoriaNotificacao == 'UE'
                                        ? colorUE
                                        : colorDRE,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.onPress();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: screenHeight * 28.3,
              padding: EdgeInsets.all(screenHeight * 2),
              color: Colors.white,
              child: Container(
                child: widget.message != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: screenHeight * 3),
                            child: AutoSizeText(
                              widget.message.titulo,
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 2,
                              style: const TextStyle(color: Color(0xff666666), fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 1.2,
                            child: AutoSizeText(
                              StringSupport.truncateEndString(
                                StringSupport.parseHtmlString(widget.message.mensagem),
                                80,
                              ),
                              maxFontSize: 16,
                              minFontSize: 14,
                              maxLines: 10,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color(0xff666666),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 3,
                          ),
                          AutoSizeText(
                            DateFormatSuport.formatStringDate(widget.message.criadoEm, 'dd/MM/yyyy'),
                            maxFontSize: 16,
                            minFontSize: 14,
                            maxLines: 2,
                            style: TextStyle(
                              color: const Color(0xff666666),
                              fontWeight: FontWeight.w700,
                              height: screenHeight * 0.5,
                            ),
                          ),
                        ],
                      )
                    : const AutoSizeText(
                        'Nenhuma mensagem está disponível para este aluno',
                        maxFontSize: 16,
                        minFontSize: 14,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                      ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.countMessages > 0 ? const Color(0xffF3F3F3) : const Color(0xffC45C04),
              borderRadius: widget.countMessages > 0
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(screenHeight * 2),
                      bottomRight: Radius.circular(screenHeight * 2),
                    )
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(screenHeight * 2),
                      bottomRight: Radius.circular(screenHeight * 2),
                    ),
            ),
            padding: EdgeInsets.only(
              left: screenHeight * 2.5,
              right: screenHeight * 2.5,
              top: screenHeight * 1.5,
              bottom: screenHeight * 1.5,
            ),
            child: widget.countMessages > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Visibility(
                        visible: widget.deleteBtn,
                        child: GestureDetector(
                          onTap: () {
                            _confirmDeleteMessage(widget.message.id);
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
                              FontAwesomeIcons.xmark,
                              color: Color(0xffC65D00),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          height: screenHeight * 6,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffC65D00), width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 3),
                            ),
                          ),
                          child: EADefaultButton(
                            btnColor: Colors.white,
                            iconColor: const Color(0xffffd037),
                            icon: FontAwesomeIcons.envelopeOpen,
                            text: 'VER TODAS',
                            styleAutoSize: const TextStyle(color: Color(0xffC65D00), fontWeight: FontWeight.w700),
                            onPress: widget.outherRoutes,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
