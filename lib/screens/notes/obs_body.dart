import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ObsBody extends StatelessWidget {
  final String title;
  final String? recomendacoesFamilia;
  final String? recomendacoesAluno;
  bool current = false;

  ObsBody({required this.title, this.recomendacoesFamilia, this.recomendacoesAluno, this.current = false});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenHeight * 2),
                child: AutoSizeText(
                  title,
                  minFontSize: 12,
                  maxFontSize: 14,
                  style: TextStyle(
                    color: current ? Color(0xFFC65D00) : Colors.black54,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              ListTile(
                  title: AutoSizeText(
                    'Recomendações a familía',
                    minFontSize: 12,
                    maxFontSize: 14,
                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  subtitle: HtmlWidget(recomendacoesFamilia ?? '')),
              ListTile(
                title: AutoSizeText(
                  'Recomendações ao aluno',
                  minFontSize: 12,
                  maxFontSize: 14,
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                ),
                subtitle: HtmlWidget(recomendacoesAluno ?? ''),
              ),
            ],
          ),
        ));
  }
}
