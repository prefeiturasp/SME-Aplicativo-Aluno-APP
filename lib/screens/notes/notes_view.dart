import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class NotesView extends StatefulWidget {
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  void initState() {
    super.initState();
    materias.add(
      Materia(nome: "Matemática", notaInfo: [
        Info(
          nota: "S",
          categoria: "bimestre",
        ),
        Info(
          nota: "7",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "bimestre",
        ),
        Info(
          nota: "9",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "final",
        ),
      ]),
    );
    materias.add(
      Materia(nome: "Inglês", notaInfo: [
        Info(
          nota: "NS",
          categoria: "bimestre",
        ),
        Info(
          nota: "4",
          categoria: "bimestre",
        ),
        Info(
          nota: "6",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "bimestre",
        ),
        Info(
          nota: "7",
          categoria: "final",
        ),
      ]),
    );
    materias.add(
      Materia(nome: "Ling. Portuguesa", notaInfo: [
        Info(
          nota: "P",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "bimestre",
        ),
        Info(
          nota: "9",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "final",
        ),
      ]),
    );
    materias.add(
      Materia(nome: "Geografia", notaInfo: [
        Info(
          nota: "5",
          categoria: "bimestre",
        ),
        Info(
          nota: "4",
          categoria: "bimestre",
        ),
        Info(
          nota: "5",
          categoria: "bimestre",
        ),
        Info(
          nota: "5",
          categoria: "bimestre",
        ),
        Info(
          nota: "5",
          categoria: "final",
        ),
      ]),
    );
    materias.add(
      Materia(nome: "Educação Física", notaInfo: [
        Info(
          nota: "8",
          categoria: "bimestre",
        ),
        Info(
          nota: "9",
          categoria: "bimestre",
        ),
        Info(
          nota: "9",
          categoria: "bimestre",
        ),
        Info(
          nota: "10",
          categoria: "bimestre",
        ),
        Info(
          nota: "7",
          categoria: "final",
        ),
      ]),
    );
    materias.add(
      Materia(nome: "História", notaInfo: [
        Info(
          nota: "3",
          categoria: "bimestre",
        ),
        Info(
          nota: "5",
          categoria: "bimestre",
        ),
        Info(
          nota: "4",
          categoria: "bimestre",
        ),
        Info(
          nota: "8",
          categoria: "bimestre",
        ),
        Info(
          nota: "5",
          categoria: "final",
        ),
      ]),
    );
    materias.add(
      Materia(nome: "Sala de Leitura", notaInfo: [
        Info(
          nota: "F",
          categoria: "bimestre",
        ),
        Info(
          nota: "F",
          categoria: "bimestre",
        ),
        Info(
          nota: "NF",
          categoria: "bimestre",
        ),
        Info(
          nota: "F",
          categoria: "bimestre",
        ),
        Info(
          nota: "F",
          categoria: "final",
        ),
      ]),
    );
  }

  List<dynamic> materias = List();

  @override
  Widget build(BuildContext context) {
    return _getBodyWidget();
  }

  Widget _getBodyWidget() {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: screenHeight * 12,
        rightHandSideColumnWidth: screenHeight * 45,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: materias.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
      ),
      height: screenHeight * 50,
    );
  }

  List<Widget> _getTitleWidget() {
    var screenHeight = MediaQuery.of(context).size.height / 100;
    return [
      _getTitleItemWidget('Componente Curricular', screenHeight * 15, false),
      _getTitleItemWidget('1º Bim. Nota', screenHeight * 9, true),
      _getTitleItemWidget('2º Bim. Nota', screenHeight * 9, true),
      _getTitleItemWidget('3º Bim. Nota', screenHeight * 9, true),
      _getTitleItemWidget('4º Bim. Nota', screenHeight * 9, true),
      _getTitleItemWidget('Nota Final', screenHeight * 9, true),
    ];
  }

  Widget _getTitleItemWidget(String label, double width, bool center) {
    var screenHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      child: Text(
        label,
        textAlign: center ? TextAlign.center : TextAlign.left,
      ),
      width: width,
      height: screenHeight * 8,
      padding: EdgeInsets.fromLTRB(screenHeight * 1, 0, 0, 0),
      alignment: Alignment.center,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    var screenHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      child: Text(
        materias[index].nome,
        textAlign: TextAlign.left,
      ),
      width: screenHeight * 10,
      height: screenHeight * 8,
      padding: EdgeInsets.fromLTRB(screenHeight * 1, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        materias[index].notaInfo[0],
        materias[index].notaInfo[1],
        materias[index].notaInfo[2],
        materias[index].notaInfo[3],
        materias[index].notaInfo[4]
      ],
    );
  }
}

class Materia {
  String nome;
  List<Widget> notaInfo;

  Materia({this.nome, this.notaInfo});
}

class Info extends StatelessWidget {
  String nota;
  String categoria;

  Info({@required this.nota, @required this.categoria});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height / 100;
    return Container(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(45)),
            color: categoria == "final" && nota.isNotEmpty
                ? Color(0xFFF6871F)
                : categoria == "final" && nota.isEmpty
                    ? Color(0xFFFFEFDF)
                    : Color(0xFFEDEDED)),
        width: screenHeight * 7,
        height: screenHeight * 7,
        child: Text(nota,
            style: TextStyle(
                color: categoria == "final" ? Colors.white : Colors.black)),
        alignment: Alignment.center,
      ),
      width: screenHeight * 9,
      height: screenHeight * 8,
      padding: EdgeInsets.fromLTRB(screenHeight * 1, 0, 0, 0),
      alignment: Alignment.center,
    );
  }
}
