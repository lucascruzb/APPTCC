import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';
import '../../../components/s3/s3_storage_util.dart';
import '../../../components/widgets.dart';

class CardConfig extends StatelessWidget {
  const CardConfig({
    super.key,
    required List<Tela> listScreens,
  }) : _listScreens = listScreens;

  final List<Tela> _listScreens;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final s3controller = S3StorageUtil();

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _listScreens.map((screen) {
        return Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          elevation: 0,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColorDark,
                    blurRadius: 40,
                    offset: const Offset(2, 10),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(60),
                splashColor: Theme.of(context).primaryColorDark,
                onTap: () {
                  Navigator.pushNamed(context, "/${screen.caminho}");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: onlineImageWidget(
                            s3controller, screen.caminhoImagem),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
