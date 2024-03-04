import 'package:flutter/material.dart';
import 'package:listy/components/realm/app_services.dart';
import 'package:listy/components/realm/schemas.dart';
import 'package:listy/components/widgets.dart';
import 'package:provider/provider.dart';
import 'package:listy/components/realm/realm_services.dart';
import 'package:realm/realm.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
    final currentRoute = ModalRoute.of(context)!.settings.name;

    return AppBar(
      title: StreamBuilder<RealmResultsChanges<Tela>>(
        stream: realmServices.getTelas().changes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final telas = snapshot.data;
            if (telas == null) return waitingIndicator();
            final results = telas.results;
            return Text(getTitulo(currentRoute!, results.toList()),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      automaticallyImplyLeading: false,
      leading: currentRoute != '/'
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
      actions: <Widget>[
        IconButton(
          icon: Icon(realmServices.offlineModeOn
              ? Icons.wifi_off_rounded
              : Icons.wifi_rounded),
          tooltip: 'Offline mode',
          onPressed: () async => await realmServices.sessionSwitch(),
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Log out',
          onPressed: () async => await logOut(context, realmServices),
        ),
      ],
    );
  }

  Future<void> logOut(BuildContext context, RealmServices realmServices) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    appServices.logOut();
    await realmServices.close();
    if (!context.mounted) return;
    Navigator.pushNamed(context, '/login');
  }

  String getTitulo(String currentRoute, List<Tela>? listaTelas) {
    if (currentRoute != '/') {
      final tela =
          listaTelas!.where((tela) => '/${tela.caminho}' == currentRoute).first;
      return tela.nome;
    } else {
      return 'Home';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
