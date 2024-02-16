import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        width: size.width * 0.75,
        padding: const EdgeInsets.only(top: 20),
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: const Text('Produtor 1'),
                  accountEmail: const Text('email produtor 1'),
                  currentAccountPicture: CircleAvatar(
                      foregroundImage: Image.asset(
                    'assets/images/produtores/produtor1.jpeg',
                    fit: BoxFit.contain,
                  ).image)),
              ListTile(
                onTap: () {},
                leading: const Icon(Iconsax.home),
                title: const Text('Dashboard'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Iconsax.chart_2),
                title: const Text('Analytics'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Iconsax.profile_2user),
                title: const Text('Contacts'),
              ),
              const SizedBox(
                height: 50,
              ),
              Divider(color: Colors.grey.shade800),
              ListTile(
                onTap: () {},
                leading: const Icon(Iconsax.setting_2),
                title: const Text('Settings'),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Iconsax.support),
                title: const Text('Support'),
              ),
              const Spacer(),
              //  Padding(
              //    padding: const EdgeInsets.all(20.0),
              //    child: Text(
              //      'Version 1.0.0',
              //      style: TextStyle(color: Colors.grey.shade500),
              //    ),
              //  )
            ],
          ),
        ),
      ),
    );
  }
}
