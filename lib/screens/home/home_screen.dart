import 'package:flutter/material.dart';
import 'package:listy/components/realm/app_services.dart';
import 'package:listy/components/realm/realm_services.dart';
import 'package:listy/components/realm/schemas.dart';
import 'package:listy/components/widgets.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import '../../components/app_bar_custom.dart';
import '../../components/s3/s3_storage_util.dart';
import 'components/body.dart';
import 'components/drawer_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // Call the superclass's initState method
    super.initState();

    // Perform one-time setup tasks her
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<RealmServices?>(context) != null) {
      final availableHeight = MediaQuery.of(context).size.height -
          AppBar().preferredSize.height -
          MediaQuery.of(context).padding.top;
      final s3controller = S3StorageUtil();
      final realmServices = Provider.of<RealmServices?>(context);

      return Scaffold(
        backgroundColor: Colors.grey[600],
        appBar: const AppBarCustom(),
        drawer: StreamBuilder<RealmResultsChanges<Usuario>>(
            stream: realmServices!.getUsuario().changes,
            builder: (context, snapshot) {
              final data = snapshot.data;

              if (data == null) return waitingIndicator();

              final results = data.results;
              return DrawerPage(
                  usuarioAtual: results.first,
                  onlineImageWidget: onlineImageWidget(
                      s3controller, results.first.imagemPerfil));
            }),
        body: SizedBox(
          height: availableHeight,
          child: StreamBuilder<RealmResultsChanges<Tela>>(
              stream: realmServices.getTelas().changes,
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null) return waitingIndicator();

                final results = data.results;
                return Body(listScreens: results.toList());
              }),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> logOut(BuildContext context, RealmServices realmServices) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    appServices.logOut();
    await realmServices.close();
    if (!context.mounted) return;
    Navigator.pushNamed(context, '/login');
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
