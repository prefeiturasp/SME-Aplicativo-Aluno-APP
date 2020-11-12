import 'package:flutter/material.dart';
import 'package:sme_app_aluno/screens/widgets/cards/simple_card.dart';

class Frequency extends StatefulWidget {
  @override
  _FrequencyState createState() => _FrequencyState();
}

class _FrequencyState extends State<Frequency> {
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
            SimpleCard(),
            SizedBox(
              height: screenHeight * 2.5,
            ),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('Item 1'),
                    );
                  },
                  body: ListTile(
                    title: Text('Item 1 child'),
                    subtitle: Text('Details goes here'),
                  ),
                  isExpanded: isOpen,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
