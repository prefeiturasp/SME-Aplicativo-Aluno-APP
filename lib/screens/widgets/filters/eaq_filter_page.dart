import 'package:flutter/material.dart';

class EAQFilterPage extends StatefulWidget {
  final List<Widget> items;

  const EAQFilterPage({super.key, required this.items});
  @override
  _EAQFilterPageState createState() => _EAQFilterPageState();
}

class _EAQFilterPageState extends State<EAQFilterPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = (size.height - MediaQuery.of(context).padding.top) / 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenHeight * 10),
      ),
      margin: EdgeInsets.only(top: screenHeight * 4),
      padding: EdgeInsets.only(
          left: screenHeight * 1.5, top: screenHeight * 1, right: screenHeight * 1, bottom: screenHeight * 1,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.items,
      ),
    );
  }
}
