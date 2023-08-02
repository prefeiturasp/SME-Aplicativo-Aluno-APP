import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../dtos/estudante_frequencia_global.dto.dart';
import '../../../utils/mensagem_sistema.dart';

class FrequencyGlobalCard extends StatelessWidget {
  final EstudanteFrequenciaGlobalDTO? frequencia;

  const FrequencyGlobalCard({
    super.key,
    this.frequencia,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return frequencia != null
        ? SingleChildScrollView(
            child: Container(
              height: screenHeight * 17,
              padding: EdgeInsets.all(screenHeight * 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 0.8),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: frequencia != null,
                    child: Expanded(
                      flex: 3,
                      child: CircularPercentIndicator(
                        radius: 30.0,
                        lineWidth: 2.0,
                        animation: true,
                        animationDuration: 3000,
                        percent: frequencia!.frequencia! / 100,
                        animateFromLastPercent: true,
                        center: AutoSizeText(
                          '${frequencia!.frequencia}%',
                          maxFontSize: 16,
                          minFontSize: 14,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: HexColor(frequencia!.corDaFrequencia ?? ''),
                        backgroundColor: const Color(0xffF1F0F5),
                        reverse: true,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: frequencia != null,
                    child: const Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: AutoSizeText(
                          MensagemSistema.labelFrequencia,
                          textAlign: TextAlign.center,
                          maxFontSize: 16,
                          minFontSize: 14,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : buildLoader(screenHeight);
  }

  Container buildLoader(screenHeight) => Container(
        margin: EdgeInsets.all(screenHeight * 1.5),
        child: const GFLoader(
          type: GFLoaderType.square,
          loaderColorOne: Color(0xffDE9524),
          loaderColorTwo: Color(0xffC65D00),
          loaderColorThree: Color(0xffC65D00),
          size: GFSize.LARGE,
        ),
      );
}
