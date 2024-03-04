import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';

class DrawerPage extends StatelessWidget {
  final Usuario? usuarioAtual;
  final Widget? onlineImageWidget;

  const DrawerPage(
      {super.key, required this.usuarioAtual, required this.onlineImageWidget});

  void _showModal(BuildContext context, Usuario? usuarioAtual) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Remove the Flexible widget from here
            const Expanded(
              flex: 2,
              child: Text('Selecione uma opção',
                  style: TextStyle(color: Colors.black)),
            ),
            Expanded(
              flex: 8,
              child: onlineImageWidget!,
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () {
                      // Implemente a lógica para a primeira opção
                      Navigator.pop(context); // Fecha o modal
                    },
                    child: const Text('Opção 1',
                        style: TextStyle(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implemente a lógica para a segunda opção
                      Navigator.pop(context); // Fecha o modal
                    },
                    child: const Text('Opção 2',
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(usuarioAtual!.nome),
            accountEmail: Text(usuarioAtual!.perfil),
            currentAccountPicture: GestureDetector(
                onTap: () => _showModal(context, usuarioAtual),
                child: ClipOval(
                  child: onlineImageWidget,
                )),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.home),
            title: const Text('Dashboard'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.insert_chart),
            title: const Text('Analytics'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.contacts),
            title: const Text('Contacts'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.support),
            title: const Text('Support'),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Build: 12345',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
