// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:listy/realm/realm_services.dart';
import 'package:listy/screens/cras/cadastros/cadastros_screen.dart';
import 'package:listy/screens/cras/capacitacao/capacitacao_screen.dart';
import 'package:listy/screens/cras/relatorios/relatorios_screen_c.dart';
import 'package:listy/screens/cras/selecCultivos/selec_cultivos_screen.dart';
import 'package:listy/screens/produtores/colheita/colheita_screen.dart';
import 'package:listy/screens/produtores/macProdutivo/mac_produtivo_screen.dart';
import 'package:listy/screens/produtores/manejo/manejo_screen.dart';
import 'package:listy/screens/produtores/regFotos/reg_fotos_screen.dart';
import 'package:listy/screens/produtores/relatorios/relatorios_screen_p.dart';
import 'package:listy/theme.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:listy/realm/app_services.dart';
import 'package:listy/screens/todo/homepage.dart';
import 'package:listy/screens/log_in.dart';

import 'screens/home/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config realmConfig = await Config.getConfig('assets/config/atlasConfig.json');

  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Config>(create: (_) => realmConfig),
    ChangeNotifierProvider<AppServices>(
        create: (_) => AppServices(realmConfig.appId, realmConfig.baseUrl)),
    ChangeNotifierProxyProvider<AppServices, RealmServices?>(
        // RealmServices can only be initialized only if the user is logged in.
        create: (context) => null,
        update: (BuildContext context, AppServices appServices,
            RealmServices? realmServices) {
          return appServices.app.currentUser != null
              ? RealmServices(appServices.app)
              : null;
        }),
  ], child: const _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final String atlasUrl =
        Provider.of<Config>(context, listen: false).atlasUrl;
    print("To see your data in Atlas, follow this link:$atlasUrl");

    final currentUser =
        Provider.of<RealmServices?>(context, listen: false)?.currentUser;

    return PopScope(
      canPop: true,
      //onPopInvoked: (didPop) {},
      child: MaterialApp(
        title: 'Realm Flutter Todo',
        theme: appThemeData(),
        initialRoute: currentUser != null ? '/' : '/login',
        routes: {
          '/': (context) => const TodoScreen(),
          '/login': (context) => const LogIn(),
          '/todo': (context) => const HomePage(),
          '/colheita': (context) => const ColheitaScreen(),
          '/macProdutivo': (context) => const MacProdutivoScreen(),
          '/manejo': (context) => const ManejoScreen(),
          '/regFotos': (context) => const RegFotosScreen(),
          '/relatoriosP': (context) => const RelatoriosScreenProd(),
          '/cadastros': (context) => const CadastrosScreen(),
          '/capacitacao': (context) => const CapacitacaoScreen(),
          '/relatoriosC': (context) => const RelatoriosScreenCras(),
          '/selecCultivos': (context) => const SelecCultivosScreen(),
        },
      ),
    );
  }
}

// This class gets app info from `atlasConfig.json`, which is
// populated with field by the server when you download the
// template app through the Atlas App Services UI or CLI.
class Config extends ChangeNotifier {
  late String appId;
  late String atlasUrl;
  late Uri baseUrl;

  Config._create(dynamic realmConfig) {
    appId = realmConfig['appId'];
    atlasUrl = realmConfig['dataExplorerLink'];
    baseUrl = Uri.parse(realmConfig['baseUrl']);
  }

  static Future<Config> getConfig(String jsonConfigPath) async {
    dynamic realmConfig =
        json.decode(await rootBundle.loadString(jsonConfigPath));

    var config = Config._create(realmConfig);

    return config;
  }
}
