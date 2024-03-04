import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import '../../../components/app_bar_custom.dart';
import '../../../components/realm/realm_services.dart';
import '../../../components/realm/schemas.dart';
import '../../../components/widgets.dart';
import 'components/body.dart';

class MacProdutivoScreen extends StatefulWidget {
  const MacProdutivoScreen({super.key});

  @override
  State<MacProdutivoScreen> createState() => _MacProdutivoScreenState();
}

class _MacProdutivoScreenState extends State<MacProdutivoScreen> {
  Map<String, dynamic>? selectedCoordinates;
  Capacidade? capacidade;

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices?>(context, listen: true);
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: const AppBarCustom(),
      body: Provider.of<RealmServices?>(context) == null
          ? Container()
          : SizedBox(
              height: availableHeight,
              child: StreamBuilder<RealmResultsChanges<Producao>>(
                  stream: realmServices!.getProducao().changes,
                  builder: (context, snapshot) {
                    final data = snapshot.data;

                    if (data == null) return waitingIndicator();

                    final results = data.results;

                    return Body(producoesUsuario: results.toList());
                  }),
            ),
    );
  }
}
