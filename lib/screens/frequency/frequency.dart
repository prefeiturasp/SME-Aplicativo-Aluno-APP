import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sme_app_aluno/controllers/frequency/frequency.controller.dart';
import 'package:sme_app_aluno/models/student/student.dart';
import 'package:sme_app_aluno/screens/widgets/cards/frequency_global_card.dart';
import 'package:sme_app_aluno/screens/widgets/cards/shimmer_card.dart';

class Frequency extends StatefulWidget {
  final Student student;
  final int userId;

  Frequency({
    @required this.student,
    @required this.userId,
  });

  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
  FrequencyController _frequencyController;

  @override
  void initState() {
    super.initState();
    _frequencyController = FrequencyController();
    _frequencyController.fetchFrequency(
      2020,
      widget.student.codigoEscola,
      widget.student.codigoTurma.toString(),
      widget.student.codigoEol.toString(),
      widget.userId,
    );
  }

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(screenHeight * 2.5),
        child: Column(
          children: [
            Observer(builder: (context) {
              if (_frequencyController.loadingFrequency) {
                return ShimmerCard();
              } else {
                return FrequencyGlobalCard(
                    frequency: _frequencyController.frequency);
              }
            }),
            SizedBox(
              height: screenHeight * 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
