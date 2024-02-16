import 'package:flutter/material.dart';

import '../../todo/components/header.dart';
import 'card_config.dart';
import 'package:listy/realm/schemas.dart';
import 'package:provider/provider.dart';
import 'package:listy/realm/realm_services.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyPageState();
}

class _BodyPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    //Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Header(size: size),
            const Header(),
            const SizedBox(
              height: 20,
            ),
            CardConfig(listScreens: pegarListaTelas(context)),
            //TitleWithMoreBtn(title: "Recomended", press: () {}),
            //RecomendsPlants(),
            //TitleWithMoreBtn(title: "Featured Plants", press: () {}),
            //FeaturedPlants(),
            //SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }

  List<Tela> pegarListaTelas(BuildContext context) {
    final List<Tela> listScreens = [];
    final realmServices = Provider.of<RealmServices>(context);
    final perfilUsuario =
        realmServices.realm.query<Perfil>("TRUEPREDICATE SORT(_id ASC)").first;
    final telas =
        realmServices.realm.query<Tela>("TRUEPREDICATE SORT(_id ASC)");
    for (var tela in telas) {
      if (perfilUsuario.iDTelas.contains(tela.id.toString())) {
        listScreens.add(tela);
      }
    }
    return listScreens;
  }
}
