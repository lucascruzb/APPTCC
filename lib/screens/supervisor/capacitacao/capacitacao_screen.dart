import 'package:flutter/material.dart';

class CapacitacaoScreen extends StatelessWidget {
  const CapacitacaoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capacitação'),
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
