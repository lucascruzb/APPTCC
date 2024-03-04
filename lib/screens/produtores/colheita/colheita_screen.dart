import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/app_bar_custom.dart';
import '../../../components/realm/realm_services.dart';
import 'components/body.dart';

class ColheitaScreen extends StatefulWidget {
  const ColheitaScreen({super.key});

  @override
  State<ColheitaScreen> createState() => _ColheitaScreenState();
}

class _ColheitaScreenState extends State<ColheitaScreen> {
  @override
  Widget build(BuildContext context) {
    //final realmServices = Provider.of<RealmServices?>(context, listen: true);
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
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
