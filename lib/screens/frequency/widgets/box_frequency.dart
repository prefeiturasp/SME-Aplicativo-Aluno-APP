import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sme_app_aluno/models/frequency/ausencias.dart';

class BoxFrequency extends StatelessWidget {
  final String title;
  final String idbox;
  final bool fail;
  final List<Ausencias> ausencias;

  BoxFrequency({
    @required this.title,
    @required this.idbox,
    this.fail = false,
    this.ausencias,
  });

  void displayBottomSheet(BuildContext context, double screenHeight) {
    if (ausencias != null && ausencias.length > 0) {
      final formatDate = DateFormat("d MMMM, y");
      showModalBottomSheet(
          backgroundColor: Color(0x00000000),
          context: context,
          builder: (ctx) {
            return Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: screenHeight * 20,
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
                            color: Color(0xffDADADA),
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 2,
                        ),
                        AutoSizeText(
                          "Datas das ausências",
                          maxFontSize: 18,
                          minFontSize: 16,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 2,
                        ),
                        Divider(),
                      ],
                    )),
                Container(
                    height: screenHeight * 36,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: GridView.builder(
                      primary: false,
                      padding: EdgeInsets.all(screenHeight * 2.5),
                      itemCount: ausencias.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "${formatDate.format(DateTime.parse(ausencias[index].data))}",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 2,
                            ),
                            AutoSizeText(
                              "${ausencias[index].quantidadeDeFaltas} ausências",
                              maxFontSize: 16,
                              minFontSize: 14,
                              style: TextStyle(
                                color: Color(0xff757575),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    )),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return GestureDetector(
      onTap: () => fail ? displayBottomSheet(context, screenHeight) : null,
      child: Container(
        margin: EdgeInsets.only(right: screenHeight * 2),
        child: Column(
          children: [
            AutoSizeText(
              title,
              maxFontSize: 14,
              minFontSize: 12,
              style: TextStyle(
                color: Color(0xff4D4D4D),
              ),
            ),
            SizedBox(
              height: screenHeight * 1,
            ),
            Container(
              width: screenHeight * 8,
              height: screenHeight * 4,
              decoration: BoxDecoration(
                color: fail ? Colors.white : Color(0xffEDEDED),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 0.8),
                ),
                border: fail
                    ? Border.all(
                        color: Color(0xffC65D00), width: screenHeight * 0.2)
                    : null,
              ),
              child: Center(
                child: AutoSizeText(
                  idbox,
                  maxFontSize: 18,
                  minFontSize: 16,
                  style: TextStyle(
                    color: fail ? Color(0xffC65D00) : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
