import 'package:flutter/material.dart';

class SelecCultivosScreen extends StatelessWidget {
  const SelecCultivosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleção do Cultivos'),
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
