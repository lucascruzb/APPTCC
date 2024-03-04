import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

import '../../../../components/realm/realm_services.dart';
import 'lista_produtos.dart';

class OuterListView extends StatelessWidget {
  final List<Producao>? producoesUsuario;

  const OuterListView({super.key, this.producoesUsuario});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: producoesUsuario?.length ?? 0,
      itemBuilder: (context, index) {
        final producao = producoesUsuario![index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
            ),
            title: Text(producao.descricao),
            subtitle:
                Text('Quantidade de produtos: ${producao.iDProdutos.length}'),
            onTap: () async {
              final realmServices =
                  Provider.of<RealmServices?>(context, listen: false);
              if (producao.iDProdutos.isNotEmpty) {
                realmServices!.switchProdutos(producao.iDProdutos.toList());
              }
              if (!context.mounted) return;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (producao.iDProdutos.isNotEmpty)
                      ? StreamBuilder<RealmResultsChanges<Produto>>(
                          stream: realmServices!.getProdutos().changes,
                          builder: (context, snapshot) {
                            final data = snapshot.data;

                            if (data == null) return Container();

                            final results = data.results;
                            return InnerListView(produto: results.toList());
                          })
                      : const InnerListView(produto: [])));
            },
          ),
        );
      },
    );
  }
}
