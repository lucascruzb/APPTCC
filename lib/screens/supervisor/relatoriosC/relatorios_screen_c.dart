import 'package:flutter/material.dart';
import 'components/body.dart';

class RelatoriosScreenCras extends StatelessWidget {
  const RelatoriosScreenCras({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Relatorios'),
        ),
        body: const Body());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      title: const Text('Login'),
    );
  }
}
