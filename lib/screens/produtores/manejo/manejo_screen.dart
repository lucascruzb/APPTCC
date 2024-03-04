import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/app_bar_custom.dart';
import '../../../components/realm/realm_services.dart';
import 'components/body.dart';

class ManejoScreen extends StatefulWidget {
  const ManejoScreen({super.key});

  @override
  State<ManejoScreen> createState() => _ManejoScreenState();
}

class _ManejoScreenState extends State<ManejoScreen> {
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    //final realmServices = Provider.of<RealmServices?>(context, listen: true);
    return Scaffold(
        appBar: const AppBarCustom(),
        body: Provider.of<RealmServices?>(context) == null
            ? Container()
            : SizedBox(height: availableHeight, child: const Body()));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      title: const Text('Login'),
    );
  }
}
