import 'package:flutter/material.dart';
import 'package:listy/realm/app_services.dart';
import 'package:listy/realm/realm_services.dart';
import 'package:provider/provider.dart';
import '../todo/components/app_bar.dart';
import 'components/body.dart';
import 'components/drawer_page.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<RealmServices?>(context, listen: false) == null
        ? Container()
        : Scaffold(
            backgroundColor: Colors.grey[600],
            appBar: const TodoAppBar(),
            drawer: const DrawerPage(),
            body: const Body(),
          );
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
