import 'package:flutter/material.dart';
//import 'components/body.dart';

class CadastrosScreen extends StatelessWidget {
  const CadastrosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastros'),
        ),
        body:
            // Body()
            null);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      title: const Text('Login'),
    );
  }
}
