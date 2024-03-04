import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

import '../../../../components/realm/realm_services.dart';
import '../../../../components/widgets.dart';
import 'lista_relatorios.dart';

class InnerListView extends StatelessWidget {
  final List<Produto> produto;

  const InnerListView({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      body: SizedBox(
        height: availableHeight,
        child: ListView.builder(
          itemCount: produto.length,
          itemBuilder: (context, index) {
            //final produtoId = produto[index].iDEspecime;
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                title: Text(produto[index].nomePlanta),
                // subtitle: Text(
                //    'Produto ${realmServices?.capacidades!.where((element) => element.id.toString() == produtoId).first.capacidade}'),
                onTap: () async {
                  final realmServices =
                      Provider.of<RealmServices?>(context, listen: false);
                  realmServices!
                      .switchRelatoriosDeteccao(produto[index].id.toString());
                  if (!context.mounted) return;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StreamBuilder<
                              RealmResultsChanges<RelatoriosDeteccao>>(
                          stream: realmServices.getRelatoriosDeteccao().changes,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) return waitingIndicator();
                            final results = data.results;
                            return MixedObjectsListView(
                                relatorios: results.toList());
                          })));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
