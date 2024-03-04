import 'package:flutter/material.dart';
import '../../../components/realm/schemas.dart';
import 'card_config.dart';

class Body extends StatefulWidget {
  final List<Tela>? listScreens;

  const Body({super.key, required this.listScreens});

  @override
  State<Body> createState() => _BodyPageState();
}

class _BodyPageState extends State<Body> {
  List<Tela>? get listScreens => widget.listScreens;

  @override
  Widget build(BuildContext context) {
    return CardConfig(listScreens: widget.listScreens ?? []);
  }
}
