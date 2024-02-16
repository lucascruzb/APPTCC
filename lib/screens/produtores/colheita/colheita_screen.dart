import 'package:flutter/material.dart';
import 'components/body.dart';

class ColheitaScreen extends StatelessWidget {
  const ColheitaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colheita'),
      ),
      body: const Body(),
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
