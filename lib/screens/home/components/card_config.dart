import 'package:flutter/material.dart';
import 'package:listy/realm/schemas.dart';

class CardConfig extends StatelessWidget {
  const CardConfig({
    super.key,
    required List<Tela> listScreens,
  }) : _listScreens = listScreens;

  final List<Tela> _listScreens;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: _listScreens
            .map((screen) => Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  color: Colors.transparent,
                  elevation: 0,
                  child: Material(
                    color: Colors.transparent,
                    //borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).primaryColorDark,
                                blurRadius: 40,
                                offset: const Offset(2, 10))
                          ]),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(60),
                        splashColor: Theme.of(context).primaryColorDark,
                        onTap: () {
                          Navigator.pushNamed(context, "/${screen.caminho}");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: size.height * 0.12,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(0, 239, 236, 236),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                image: DecorationImage(
                                  image:
                                      AssetImage("${screen.caminhoImagem}.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              height: size.height * 0.07,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                              ),
                              child: Center(child: Text(screen.nome)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
