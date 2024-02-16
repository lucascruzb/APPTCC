import 'package:flutter/material.dart';

class MacProdutivoScreen extends StatelessWidget {
  const MacProdutivoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marco Produtivo'),
      ),
      //body: Body()
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
