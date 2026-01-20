import 'package:flutter/material.dart';

class EAQFilterPage extends StatefulWidget {
  final List<Widget> items;
  const EAQFilterPage({super.key, required this.items});

  @override
  EAQFilterPageState createState() => EAQFilterPageState();
}

class EAQFilterPageState extends State<EAQFilterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * 2),
      ),
      margin: EdgeInsets.only(top: screenHeight * 2),
      padding: EdgeInsets.all(screenHeight * 1.5),
      child: Wrap(
        spacing: screenHeight * 1.5,
        runSpacing: screenHeight * 1,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.items,
      ),
    );
  }
}
