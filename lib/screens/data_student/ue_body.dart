import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/ue/data_ue.dart';
import 'package:url_launcher/url_launcher.dart';

class UEBody extends StatelessWidget {
  final DadosUE dadosUE;

  const UEBody({super.key, required this.dadosUE});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    void showAlerta(Color color, String mensagem) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(mensagem),
        ),
      );
    }

    Future<void> fazerLigacao(String telefone) async {
      final url = Uri.parse('tel:$telefone');
      if (!await launchUrl(url)) {
        if (context.mounted) {
          showAlerta(Colors.red, 'Não foi possível realizar a ação para o número $url');
        }
      }
    }

    Widget itemClipBoard(BuildContext context, String infoName, String infoData, double screenHeight) {
      return InkWell(
        onTap: infoData.isNotEmpty
            ? () async {
                await Clipboard.setData(ClipboardData(text: infoData));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$infoName copiado para área de transferência!'),
                    ),
                  );
                }
              }
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              infoName,
              maxFontSize: 16,
              minFontSize: 14,
              style: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: screenHeight * 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: AutoSizeText(
                infoData.isNotEmpty ? infoData : 'Informação não disponível.',
                maxFontSize: 20,
                minFontSize: 18,
                style: infoData.isNotEmpty
                    ? const TextStyle(
                        color: Color(0xff2096FA),
                        decoration: TextDecoration.underline,
                      )
                    : const TextStyle(color: Colors.black),
              ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      );
    }

    Widget itemCall(BuildContext context, String infoName, String infoData, double screenHeight) {
      return InkWell(
        onTap: infoData.isNotEmpty
            ? (int.tryParse(infoData) != null
                ? () {
                    fazerLigacao(infoData);
                  }
                : null)
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              infoName,
              maxFontSize: 16,
              minFontSize: 14,
              style: const TextStyle(color: Colors.black),
            ),
            SizedBox(
              height: screenHeight * 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: infoData.isNotEmpty
                  ? (int.tryParse(infoData) != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              infoData,
                              maxFontSize: 20,
                              minFontSize: 18,
                              style: const TextStyle(color: Colors.black),
                            ),
                            Icon(
                              FontAwesomeIcons.phone,
                              size: screenHeight * 3,
                              color: const Color(0xFFC65D00),
                            ),
                          ],
                        )
                      : AutoSizeText(
                          infoData,
                          maxFontSize: 20,
                          minFontSize: 18,
                          style: const TextStyle(color: Colors.black),
                        ))
                  : const AutoSizeText(
                      'Informação não disponível.',
                      maxFontSize: 20,
                      minFontSize: 18,
                      style: TextStyle(color: Colors.black),
                    ),
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      );
    }

    final cepComplete = dadosUE.cep.toString().padLeft(8, '0');

    final cepMask = '${cepComplete.substring(0, 5)}-${cepComplete.substring(5)}';

    final enderecoConcatenado =
        '${dadosUE.tipoLogradouro} ${dadosUE.logradouro}, ${dadosUE.numero} - ${dadosUE.bairro}, ${dadosUE.municipio} - ${dadosUE.uf}, $cepMask';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 3, top: screenHeight * 1),
          child: const AutoSizeText(
            'Dados da Unidade Escolar',
            maxFontSize: 18,
            minFontSize: 16,
            style: TextStyle(color: Color(0xFFC65D00), fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        itemClipBoard(context, 'Endereço', enderecoConcatenado, screenHeight),
        SizedBox(
          height: screenHeight * 2.5,
        ),
        itemCall(context, 'Telefone', dadosUE.telefone, screenHeight),
        SizedBox(
          height: screenHeight * 2.5,
        ),
        itemClipBoard(context, 'Email', dadosUE.email, screenHeight),
      ],
    );
  }
}
