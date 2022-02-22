import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sme_app_aluno/models/outros_servicos/outro_servico.model.dart';
import 'package:sme_app_aluno/repositories/outros_servicos_repository.dart';
import 'package:sme_app_aluno/ui/views/outros_servicos_lista.view.dart';
import 'package:url_launcher/url_launcher.dart';

class EAResumoOutrosServicosCard extends StatefulWidget {
  EAResumoOutrosServicosCard();

  @override
  _EAResumoOutrosServicosCardState createState() =>
      _EAResumoOutrosServicosCardState();
}

class _EAResumoOutrosServicosCardState
    extends State<EAResumoOutrosServicosCard> {
  @override
  Widget build(BuildContext context) {
    var outroServicosRepository = OutrosServicosRepository();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Container(
      margin: EdgeInsets.only(top: screenHeight * 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(screenHeight * 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, 2),
            blurRadius: 2,
            spreadRadius: 0,
          )
        ],
      ),
      child: FutureBuilder(
          future: outroServicosRepository.obterLinksPioritario(),
          initialData: [],
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: screenHeight * 2,
                      bottom: screenHeight * 2,
                      left: screenHeight * 2.5,
                      right: screenHeight * 2.5),
                  decoration: BoxDecoration(
                    color: Color(0xffEFB330),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(screenHeight * 2),
                      topRight: Radius.circular(screenHeight * 2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          Container(
                            height: screenHeight * 3,
                            width: screenHeight * 3,
                            margin: EdgeInsets.only(right: screenHeight * 1),
                            child: Center(
                              child: Icon(
                                FontAwesomeIcons.alignJustify,
                                size: screenHeight * 3,
                              ),
                            ),
                          ),
                          AutoSizeText(
                            "OUTROS SERVIÇOS",
                            maxFontSize: 18,
                            minFontSize: 16,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //Inicio Novo Widget
                Wrap(
                  alignment: WrapAlignment.center,
                  children: List.generate(
                    snapshot.data.length,
                    (index) {
                      return OutrosLinksInfoWidget(
                        screenHeight: screenHeight,
                        outroServicoModel: snapshot.data[index],
                      );
                    },
                  ),
                ),
                //Fim Novo Widget
                Container(
                  padding: EdgeInsets.only(
                      left: screenHeight * 2.5,
                      top: screenHeight * 2.5,
                      right: screenHeight * 2.5,
                      bottom: screenHeight * 1.5),
                  child: Container(
                    height: screenHeight * 6,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffC65D00), width: 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenHeight * 3),
                      ),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OutrosServicosLista(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            "MAIS INFORMAÇÕES",
                            maxFontSize: 16,
                            minFontSize: 14,
                            style: TextStyle(
                                color: Color(0xffC65D00),
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: screenHeight * 3,
                          ),
                          Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Color(0xffffd037),
                            size: screenHeight * 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class OutrosLinksInfoWidget extends StatelessWidget {
  final double screenHeight;
  final OutroServicoModel outroServicoModel;
  const OutrosLinksInfoWidget(
      {Key key, @required this.screenHeight, @required this.outroServicoModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Container(
              margin: EdgeInsets.only(
                right: screenHeight * 3.0,
                left: screenHeight * 3.0,
                top: screenHeight * 0.5,
              ),
              child: ClipRect(
                child: Image.network(
                  outroServicoModel.icone,
                  width: screenHeight * 9,
                  height: screenHeight * 9,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () => launch(outroServicoModel.urlSite),
          ),
          AutoSizeText(
            outroServicoModel.titulo,
            maxFontSize: 10,
            minFontSize: 9,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
