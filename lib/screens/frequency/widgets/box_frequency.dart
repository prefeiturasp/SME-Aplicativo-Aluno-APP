// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/frequency/ausencias.dart';

class BoxFrequency extends StatelessWidget {
  final String title;
  final String idbox;
  final bool fail;
  final List<Ausencias> ausencias;

  BoxFrequency({
    Key? key,
    required this.title,
    required this.idbox,
    this.fail = false,
    this.ausencias = const [],
  }) : super(key: key);

  final dataPorExtenso = DateFormat("d 'de' MMMM 'de' y", 'pt_BR');

  Widget _listDateAusencias(List<Ausencias> data, double screenHeight) {
    final List<Widget> list = [];
    for (var i = 0; i < ausencias.length; i++) {
      list.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              dataPorExtenso.format(DateTime.parse(data[i].data)),
              maxFontSize: 16,
              minFontSize: 14,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.5,
            ),
            AutoSizeText(
              data[i].quantidadeDeFaltas == 1
                  ? '${data[i].quantidadeDeFaltas} ausência'
                  : '${data[i].quantidadeDeFaltas} ausências',
              maxFontSize: 16,
              minFontSize: 14,
              style: const TextStyle(
                color: Color(0xff757575),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: screenHeight * 2,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  void displayBottomSheet(BuildContext context, double screenHeight) {
    if (ausencias.isEmpty) {
      return;
    }

    showModalBottomSheet(
      backgroundColor: const Color(0x00000000),
      context: context,
      builder: (ctx) {
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: screenHeight * 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(screenHeight * 3.5),
                  topLeft: Radius.circular(screenHeight * 3.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenHeight * 8,
                    height: screenHeight * 1,
                    margin: EdgeInsets.only(top: screenHeight * 2),
                    decoration: BoxDecoration(
                      color: const Color(0xffDADADA),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenHeight * 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 3,
                  ),
                  const AutoSizeText(
                    'Datas das ausências',
                    maxFontSize: 18,
                    minFontSize: 16,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight * 44,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(screenHeight * 2.5),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: _listDateAusencias(ausencias, screenHeight),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return GestureDetector(
      onTap: () => fail ? displayBottomSheet(context, screenHeight) : null,
      child: Column(
        children: [
          AutoSizeText(
            title,
            maxFontSize: 14,
            minFontSize: 12,
            style: const TextStyle(
              color: Color(0xff4D4D4D),
            ),
          ),
          SizedBox(
            height: screenHeight * 1,
          ),
          Container(
            width: screenHeight * 8,
            height: screenHeight * 5,
            decoration: BoxDecoration(
              color: fail ? Colors.white : const Color(0xffEDEDED),
              borderRadius: BorderRadius.all(
                Radius.circular(screenHeight * 0.8),
              ),
              border: fail ? Border.all(color: const Color(0xffC65D00), width: screenHeight * 0.2) : null,
            ),
            child: Center(
              child: AutoSizeText(
                idbox,
                maxFontSize: 18,
                minFontSize: 16,
                style: TextStyle(
                  color: fail ? const Color(0xffC65D00) : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
