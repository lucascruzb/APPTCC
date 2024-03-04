import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';
import 'package:listy/screens/produtores/relatorios/components/modal_relatorio.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

import '../../../../components/realm/realm_services.dart';
import '../../../../components/widgets.dart';

class MixedObjectsListView extends StatelessWidget {
  final List<RelatoriosDeteccao> relatorios;

  const MixedObjectsListView({super.key, required this.relatorios});

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mixed Objects ListView'),
      ),
      body: SizedBox(
        height: availableHeight,
        child: ListView.builder(
          itemCount: relatorios.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                title: Text('ObjetosDetectados: ${relatorios[index].data}'),
                onTap: () async {
                  final realmServices =
                      Provider.of<RealmServices?>(context, listen: false);
                  realmServices!.switchObjetosDetectado(
                      relatorios[index].objetosDetectados.toList());
                  // Show the modal with the image and bounding boxes
                  await _showDialog(context, realmServices, index);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(
      BuildContext context, RealmServices realmServices, int index) {
    return showDialog(
        context: context,
        builder: (context) =>
            StreamBuilder<RealmResultsChanges<ObjetosDetectado>>(
                stream: realmServices.getObjetosDetectado().changes,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) return waitingIndicator();

                  final results = data.results;
                  return DrawingModal(
                    boundingBoxes: results.toList(),
                    imagePath: relatorios[index].imagemPath,
                  );
                }));
  }
}
