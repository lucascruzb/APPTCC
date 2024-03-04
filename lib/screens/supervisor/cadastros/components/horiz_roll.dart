import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HorizRoll extends StatefulWidget {
  const HorizRoll({
    super.key,
    required List<dynamic> listProd,
  }) : _listProd = listProd;

  final List<dynamic> _listProd;

  @override
  State<HorizRoll> createState() => _HorizRoll();
}

class _HorizRoll extends State<HorizRoll> {
  List<dynamic> get _listProd => widget._listProd;
  List<dynamic> get _listImage => _listProd.map((e) => e['image']).toList();
  final CarouselController _carouselController = CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image(
                image: _listProd[_current]['image'],
                fit: BoxFit.fitWidth,
                width: size.width),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                height: size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                    ])),
              ),
            ),
            Positioned(
              bottom: 0,
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
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,
                items: _listImage.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
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
                                          color: theme.primaryColor, width: 5),
                                      image: DecorationImage(
                                          image: _listImage[_current],
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
                                          color: theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'nome : ${_listProd[_current]['title']}',
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
                                          color: theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'endereco : ${_listProd[_current]['endereco']}',
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: size.width,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 2),
                                          color: theme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'telefone : ${_listProd[_current]['telefone']}',
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: _current == _listProd.indexOf(movie)
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
            )
          ],
        ),
      ),
    );
  }
}
