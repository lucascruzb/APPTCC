import 'package:flutter/material.dart';

class RelatoriosScreenProd extends StatelessWidget {
  const RelatoriosScreenProd({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatorios'),
      ),
      // body: Body()
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      title: const Text('Login'),
    );
  }
}
