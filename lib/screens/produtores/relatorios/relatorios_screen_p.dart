import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

import '../../../components/app_bar_custom.dart';
import '../../../components/realm/realm_services.dart';
import '../../../components/widgets.dart';
import 'components/body.dart';

class RelatoriosScreenProd extends StatefulWidget {
  const RelatoriosScreenProd({super.key});

  @override
  State<RelatoriosScreenProd> createState() => _RelatoriosScreenProdState();
}

class _RelatoriosScreenProdState extends State<RelatoriosScreenProd> {
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final realmServices = Provider.of<RealmServices?>(context);
    return Scaffold(
        appBar: const AppBarCustom(),
        body: Provider.of<RealmServices?>(context, listen: false) == null
            ? Container()
            : SizedBox(
                height: availableHeight,
                child: StreamBuilder<RealmResultsChanges<Producao>>(
                    stream: realmServices!.getProducao().changes,
                    builder: (context, snapshot) {
                      final data = snapshot.data;

                      if (data == null) return waitingIndicator();

                      final results = data.results;
                      return OuterListView(producoesUsuario: results.toList());
                    })));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      title: const Text('Login'),
    );
  }
}
