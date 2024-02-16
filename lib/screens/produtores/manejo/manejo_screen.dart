import 'package:flutter/material.dart';

import 'components/body.dart';

class ManejoScreen extends StatelessWidget {
  const ManejoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Manejo'),
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
