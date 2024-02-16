import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class VerticalRoll extends StatelessWidget {
  const VerticalRoll({
    super.key,
    required List<String> listImages,
    required this.caminho,
  }) : _listImages = listImages;

  final List<String> _listImages;
  final String caminho;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(size.height * 0.03),
            child: VerticalCardPager(
              images: _listImages
                  .map((image) => Card(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage('$caminho$image.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              Navigator.pushNamed(context, '/$image');
                            },
                          ),
                        ),
                      ))
                  .toList(),
              titles: _listImages,
              onSelectedItem: (page) =>
                  Navigator.pushNamed(context, page.toString()),
            )),
      ),
    );
  }
}
