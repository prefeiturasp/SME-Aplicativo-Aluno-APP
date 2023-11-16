import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../models/terms/term.dart';
import '../../ui/widgets/buttons/ea_deafult_button.widget.dart';

class TermsView extends StatefulWidget {
  final Term term;
  final VoidCallback changeStatusTerm;
  final String cpf;
  final bool showBtn;
  const TermsView({
    super.key,
    required this.term,
    required this.changeStatusTerm,
    required this.cpf,
    this.showBtn = true,
  });

  @override
  _TermsViewState createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  final ScrollController _controller = ScrollController();
  var reachEnd = false;

  _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;
    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    }

    if (_controller.offset <= minScroll) {
      setState(() {
        reachEnd = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(screenHeight * 4),
          height: widget.showBtn ? screenHeight * 70 : screenHeight * 86,
          child: Scrollbar(
            child: ListView(
              controller: _controller,
              children: <Widget>[
                Column(
                  children: [
                    const AutoSizeText(
                      'Termos e condições de uso',
                      minFontSize: 16,
                      maxFontSize: 18,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: screenHeight * 4,
                    ),
                    HtmlWidget(widget.term.termosDeUso),
                    const AutoSizeText(
                      'Política de privacidade',
                      minFontSize: 14,
                      maxFontSize: 16,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    HtmlWidget(widget.term.politicaDePrivacidade),
                  ],
                ),
              ],
            ),
          ),
        ),
        widget.showBtn
            ? Container(
                padding: EdgeInsets.all(screenHeight * 1.8),
                alignment: Alignment.center,
                child: EADefaultButton(
                  text: 'ACEITAR TODOS OS TERMOS',
                  iconColor: const Color(0xffffd037),
                  btnColor: const Color(0xffd06d12),
                  enabled: reachEnd,
                  onPress: widget.changeStatusTerm,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
