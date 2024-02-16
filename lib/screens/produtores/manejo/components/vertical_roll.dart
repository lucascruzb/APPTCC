// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
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
                return Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.only(top: 40),
                  height: size.height * 0.65,
                  width: size.width * 0.8,
                  child: ScreensConfig(image: image.toString()),
                );
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
  _ScreensConfigState createState() => _ScreensConfigState();
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
    // Size size = MediaQuery.of(context).size;
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

  int _current = 0;
  Widget makePage({image, title, content, reverse = false}) {
    Size size = MediaQuery.of(context).size;
    CarouselController carouselController = CarouselController();

    final List<dynamic> listImagens = [
      {
        'title': 'hortalicia 1',
        'image': const AssetImage(
          'assets/images/hortalicias/hortalicias1.png',
        )
      },
      {
        'title': 'hortalicia 2',
        'image': const AssetImage('assets/images/hortalicias/hortalicias2.png')
      },
      {
        'title': 'hortalicia 3',
        'image': const AssetImage('assets/images/hortalicias/hortalicias3.png')
      },
      {
        'title': 'hortalicia 4',
        'image': const AssetImage('assets/images/hortalicias/hortalicias4.png')
      },
      {
        'title': 'hortalicia 5',
        'image': const AssetImage('assets/images/hortalicias/hortalicias5.png')
      },
      {
        'title': 'hortalicia 6',
        'image': const AssetImage('assets/images/hortalicias/hortalicias6.png')
      },
      {
        'title': 'hortalicia 7',
        'image': const AssetImage('assets/images/hortalicias/hortalicias7.png')
      },
      {
        'title': 'hortalicia 8',
        'image': const AssetImage('assets/images/hortalicias/hortalicias8.png')
      },
      {
        'title': 'hortalicia 9',
        'image': const AssetImage('assets/images/hortalicias/hortalicias9.png')
      },
      {
        'title': 'hortalicia 10',
        'image': const AssetImage('assets/images/hortalicias/hortalicias10.png')
      },
      {
        'title': 'hortalicia 11',
        'image': const AssetImage('assets/images/hortalicias/hortalicias11.png')
      }
    ];
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Container(
            alignment: Alignment.topCenter,
            width: size.width,
            height: size.height,
            child: Positioned(
              bottom: 20,
              height: size.height,
              width: size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: size.height * 0.8,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.70,
                  clipBehavior: Clip.hardEdge,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: carouselController,
                items: listImagens.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          alignment: Alignment.topCenter,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: size.height * 0.4,
                                  margin: const EdgeInsets.only(top: 80),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 5),
                                      image: DecorationImage(
                                          image: listImagens[_current]['image'],
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(10),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: size.width,
                                  height: size.height * 0.5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      Container(
                                        width: size.width,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'nome : ${listImagens[_current]['title']}',
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: size.width,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: size.width,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity:
                                      _current == listImagens.indexOf(movie)
                                          ? 1.0
                                          : 0.0,
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
            )));
  }
}
