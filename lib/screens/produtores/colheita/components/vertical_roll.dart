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
      backgroundColor: Theme.of(context).primaryColor,
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
                            onTap: () {},
                          ),
                        ),
                      ))
                  .toList(),
              titles: _listImages,
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
              onSelectedItem: (page) =>
                  openDialog(context, image: _listImages[page].toString()),
            )),
      ),
    );
  }

  Future openDialog(BuildContext context, {image}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var size = MediaQuery.of(context).size;
                return Positioned(
                    //top: 20,
                    child: Container(
                  alignment: Alignment.topCenter,
                  //padding: EdgeInsets.only(top: 40),
                  height: size.height * 0.8,
                  width: size.width * 0.8,
                  child: ScreensConfig(image: image.toString()),
                ));
              },
            ),
          ));
}

class ScreensConfig extends StatefulWidget {
  final String image;

  const ScreensConfig({
    super.key,
    required this.image,
  });

  @override
  State<ScreensConfig> createState() => _ScreensConfigState();
}

class _ScreensConfigState extends State<ScreensConfig> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var image = widget.image.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: Text(
              'Pular',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: <Widget>[
              makePage(
                image: image.toString(),
                title: 'Colheita',
                content: 'Aqui você pode ver as colheitas que você já fez',
                reverse: false,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Image.asset('assets/images/hortalicias/$image.png',
                          fit: BoxFit.fill, height: size.height * 0.4),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  image.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  image.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ]),
        ));
  }
}
