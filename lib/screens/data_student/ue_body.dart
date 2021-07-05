import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:sme_app_aluno/models/ue/data_ue.dart';
import 'package:sme_app_aluno/stores/index.dart';
import 'package:url_launcher/url_launcher.dart';

class UEBody extends StatelessWidget {
  final DadosUE dadosUE;

  UEBody({this.dadosUE});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    fazerLigacao(String telefone) async {
      var url = "tel:$telefone";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Não foi possível realizar a ação para o número $url';
      }
    }

    Widget itemClipBoard(BuildContext context, String infoName, String infoData,
        double screenHeight) {
      return InkWell(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                infoName,
                maxFontSize: 16,
                minFontSize: 14,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: AutoSizeText(
                  infoData != null && infoData.isNotEmpty
                      ? infoData
                      : 'Informação não disponível.',
                  maxFontSize: 20,
                  minFontSize: 18,
                  style: infoData != null && infoData.isNotEmpty
                      ? TextStyle(
                          color: Color(0xff2096FA),
                          decoration: TextDecoration.underline,
                        )
                      : TextStyle(color: Colors.black),
                ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ),
        onTap: infoData != null && infoData.isNotEmpty
            ? () async {
                await Clipboard.setData(new ClipboardData(text: infoData))
                    .then((_) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content:
                        Text(infoName + " copiado para área de transferência!"),
                  ));
                });
              }
            : null,
      );
    }

    Widget itemCall(BuildContext context, String infoName, String infoData,
        double screenHeight) {
      return InkWell(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                infoName,
                maxFontSize: 16,
                minFontSize: 14,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: screenHeight * 1,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: infoData != null && infoData.isNotEmpty
                    ? (int.tryParse(infoData) != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                infoData,
                                maxFontSize: 20,
                                minFontSize: 18,
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(
                                FontAwesomeIcons.phone,
                                size: screenHeight * 3,
                                color: Color(0xFFC65D00),
                              )
                            ],
                          )
                        : AutoSizeText(
                            infoData,
                            maxFontSize: 20,
                            minFontSize: 18,
                            style: TextStyle(color: Colors.black),
                          ))
                    : AutoSizeText(
                        'Informação não disponível.',
                        maxFontSize: 20,
                        minFontSize: 18,
                        style: TextStyle(color: Colors.black),
                      ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ),
        onTap: infoData != null && infoData.isNotEmpty
            ? (int.tryParse(infoData) != null
                ? () {
                    fazerLigacao(infoData);
                  }
                : null)
            : null,
      );
    }

    var cepComplete = dadosUE.cep.toString().padLeft(8, '0');

    var cepMask = cepComplete.substring(0, 5) + "-" + cepComplete.substring(5);

    var enderecoConcatenado = dadosUE.tipoLogradouro +
        ' ' +
        dadosUE.logradouro +
        ', ' +
        dadosUE.numero +
        ' - ' +
        dadosUE.bairro +
        ', ' +
        dadosUE.municipio +
        ' - ' +
        dadosUE.uf +
        ', ' +
        cepMask;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: screenHeight * 3, top: screenHeight * 1),
            child: AutoSizeText(
              'Dados da Unidade Escolar',
              maxFontSize: 18,
              minFontSize: 16,
              style: TextStyle(
                  color: Color(0xFFC65D00), fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          itemClipBoard(context, "Endereço", enderecoConcatenado, screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          itemCall(context, "Telefone", dadosUE.telefone, screenHeight),
          SizedBox(
            height: screenHeight * 2.5,
          ),
          itemClipBoard(context, "Email", dadosUE.email, screenHeight),
        ],
      ),
    );
  }
}
