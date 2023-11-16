// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppBarEscolaAqui extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final Color? foreground;
  final Color? colorText;
  const AppBarEscolaAqui({
    super.key,
    this.colorText,
    this.foreground,
    required this.titulo,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titulo,
        style: TextStyle(color: colorText ?? Colors.black),
      ),
      backgroundColor: const Color(0xffEEC25E),
      foregroundColor: foreground ?? Colors.black,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
