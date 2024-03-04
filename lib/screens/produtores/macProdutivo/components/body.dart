import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listy/screens/produtores/macProdutivo/components/map.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';

import '../../../../components/realm/realm_services.dart';
import '../../../../components/realm/schemas.dart';
import '../../../../components/widgets.dart';

class Body extends StatefulWidget {
  final List<Producao>? producoesUsuario;

  const Body({super.key, this.producoesUsuario});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController? textController = TextEditingController();
  String? selectedOption1;
  late TextEditingController _descricaoController;
  late TextEditingController _nomePlantaController;
  String? _errorMessage;

  @override
  void initState() {
    _descricaoController = TextEditingController()..addListener(clearError);
    _nomePlantaController = TextEditingController()..addListener(clearError);
    super.initState();
  }

  void clearError() {
    if (_errorMessage != null) {
      setState(() {
        // Reset error message when user starts typing
        _errorMessage = null;
      });
    }
  }

  Future<void> _showOptionsModal(RealmServices realmServices) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final availableHeight = MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top;
        return SizedBox(
          height: availableHeight,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    loginField(
                      _descricaoController,
                      labelText: "Nome da produção",
                    ),
                    const Text('Selecione a produção',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    ElevatedButton(
                      onPressed: () async {
                        LatLng selectedLocation = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapScreen()));
                        realmServices.createProducao(
                            realmServices.getUsuario().first.id.toString(),
                            _descricaoController.text,
                            ProducaoLocation(type: "Point", coordinates: [
                              selectedLocation.latitude,
                              selectedLocation.longitude
                            ]),
                            []);
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      child: const Text('Cadastrar nova Horta'),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices?>(context, listen: true);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.producoesUsuario?.length ?? 0,
            itemBuilder: (context, index) {
              final producao = widget.producoesUsuario![index];
              return Card(
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: Text(producao.descricao),
                  subtitle: Text(
                      'Quantidade de produtos: ${producao.iDProdutos.length}'),
                  onTap: () async {
                    if (producao.iDProdutos.isNotEmpty) {
                      realmServices!.switchProdutos(producao.iDProdutos);
                    }
                    openDialog(
                      context,
                      producao: producao,
                    );
                  },
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => _showOptionsModal(realmServices!),
          child: const Text('Cadastrar nova Horta'),
        )
      ],
    );
  }

  Future openDialog(BuildContext context, {producao}) => showDialog(
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
                  child: ScreensConfig(
                      nomePlantaController: _nomePlantaController,
                      producao: producao),
                ));
              },
            ),
          ));
}

class ScreensConfig extends StatefulWidget {
  final Producao producao;
  final TextEditingController nomePlantaController;

  const ScreensConfig({
    super.key,
    required this.producao,
    required,
    required this.nomePlantaController,
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
    final realmServices = Provider.of<RealmServices?>(context, listen: true);
    var producao = widget.producao;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: ElevatedButton(
              onPressed: () {
                _showOptionsModal(realmServices!); // Close the bottom sheet
              },
              child: const Text("adicionar"),
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
                nomePlantaController: widget.nomePlantaController,
                realmServices: realmServices,
                producao: producao,
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

  Widget makePage(
      {required Producao producao,
      title,
      content,
      reverse = false,
      RealmServices? realmServices,
      required nomePlantaController}) {
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        producao.descricao,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: (widget.producao.iDProdutos.isNotEmpty)
                          ? StreamBuilder<RealmResultsChanges<Produto>>(
                              stream: realmServices!.getProdutos().changes,
                              builder: (context, snapshot) {
                                final data = snapshot.data;

                                if (data == null) return waitingIndicator();

                                final results = data.results;
                                return ListView.builder(
                                  itemCount: results.length,
                                  itemBuilder: (context, index) {
                                    final produto = results[index];
                                    return Expanded(
                                      child: Card(
                                        elevation: 5,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15),
                                        child: ListTile(
                                          title: Text(produto.nomePlanta),
                                          //subtitle: Text(
                                          //    'Quantidade de produtos: ${produto.iDProdutos.length}'),
                                          onTap: () async {},
                                        ),
                                      ),
                                    );
                                  },
                                );
                              })
                          // : Text(selectedOption1.toString(),
                          //     style: const TextStyle(
                          //         fontSize: 16, color: Colors.black)),

                          : const Text('Nenhum produto cadastrado',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black))),
                )
              ]),
        ));
  }

  Future<void> _showOptionsModal(RealmServices realmServices) async {
    CapacidadesUsuario? selectedOption;
    final produtos = realmServices.getCapacidades().toList();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final availableHeight = MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top;
        return SizedBox(
          height: availableHeight,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    loginField(
                      widget.nomePlantaController,
                      labelText: "Nome da produção",
                    ),
                    const Text('Selecione o Especime',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: StreamBuilder<
                            RealmResultsChanges<CapacidadesUsuario>>(
                          stream: realmServices.getCapacidadesUsuario().changes,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) return waitingIndicator();
                            final results = data.results;
                            return DropdownButton<CapacidadesUsuario>(
                              value: selectedOption,
                              isExpanded: true,
                              onChanged: (CapacidadesUsuario? newValue) {
                                selectedOption = newValue!;
                              },
                              items: results
                                  .toList()
                                  .map<DropdownMenuItem<CapacidadesUsuario>>(
                                      (CapacidadesUsuario value) {
                                return DropdownMenuItem<CapacidadesUsuario>(
                                  value: value,
                                  child: Text(
                                      produtos
                                          .where((element) =>
                                              element.id.toString() ==
                                              value.iDCapacidade.toString())
                                          .first
                                          .capacidade,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                );
                              }).toList(),
                            );
                          },
                        )),
                    ElevatedButton(
                      onPressed: () async {
                        realmServices.switchProdutos([]);
                        String id = realmServices.createProduto(
                            selectedOption!.iDCapacidade.toString(),
                            widget.nomePlantaController.text, []);
                        realmServices
                            .updateProducao(widget.producao, iDProdutos: [id]);
                        if (widget.producao.iDProdutos.isNotEmpty) {
                          realmServices.switchProdutos(
                              widget.producao.iDProdutos..add(id));
                        }
                        Navigator.pop(context);
                      },
                      child: const Text('Cadastrar nova Horta'),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
