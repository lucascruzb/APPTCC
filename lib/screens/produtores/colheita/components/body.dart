import 'package:flutter/material.dart';
import 'vertical_roll.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    const String caminho = 'assets/images/hortalicias/';
    final List<String> listImagens = [
      'hortalicias1',
      'hortalicias2',
      'hortalicias3',
      'hortalicias4',
      'hortalicias5',
      'hortalicias6',
      'hortalicias7',
      'hortalicias8',
      'hortalicias9',
      'hortalicias10',
      'hortalicias11'
    ];
    return VerticalRoll(listImages: listImagens, caminho: caminho);
  }
}
