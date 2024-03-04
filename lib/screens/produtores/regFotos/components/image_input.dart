import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:listy/components/realm/realm_services.dart';
import 'package:realm/realm.dart';

import '../../../../components/azure/azure_api_client.dart';
import '../../../../components/realm/schemas.dart';
import '../../../../components/s3/s3_storage_util.dart';
import '../../../../components/widgets.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Producao? selectedOption1;
  String? descricaoOpcao1;
  List<Produto>? opcoes;
  Produto? selectedOption2;
  String? selectedOption3;
  List<Capacidade>? produtos;

  @override
  Widget build(BuildContext context) {
    RealmServices realmServices = Provider.of<RealmServices>(context);
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma imagem!',
                  style: TextStyle(color: Colors.black)),
        ),
        Expanded(
          flex: 4,
          child: _storedImage == null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 5,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.camera),
                        label: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: FittedBox(
                            child: Text('Tirar Foto',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => _pickImage(ImageSource.camera),
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.image),
                        label: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: FittedBox(
                            child: Text('Escolher da Galeria',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ElevatedButton(
                        onPressed: () {
                          _showOptionsModal(
                              realmServices); // Close the bottom sheet
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: FittedBox(
                            child: Text('Enviar para o S3',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Future<void> _showOptionsModal(RealmServices realmServices) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (selectedOption1 == null)
                    const Text('Selecione a produção',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  if (selectedOption1 == null)
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: StreamBuilder<RealmResultsChanges<Producao>>(
                            stream: realmServices.getProducao().changes,
                            builder: (context, snapshot) {
                              final data = snapshot.data;

                              if (data == null) return waitingIndicator();

                              final results = data.results;
                              return DropdownButton<Producao>(
                                value: selectedOption1,
                                isExpanded: true,
                                onChanged: (Producao? newValue) async {
                                  setState(() {
                                    selectedOption1 = newValue;
                                    produtos =
                                        realmServices.getCapacidades().toList();
                                    realmServices.switchProdutos(
                                        selectedOption1!.iDProdutos.toList());
                                  });
                                },
                                items: results
                                    .toList()
                                    .map<DropdownMenuItem<Producao>>(
                                        (Producao value) {
                                  return DropdownMenuItem<Producao>(
                                    value: value,
                                    child: Text(value.descricao,
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.black)),
                                  );
                                }).toList(),
                              );
                            })
                        // : Text(selectedOption1.toString(),
                        //     style: const TextStyle(
                        //         fontSize: 16, color: Colors.black)),
                        ),
                  const SizedBox(height: 20),
                  if (selectedOption1 != null)
                    const Text('Produção selecionada:',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  if (selectedOption1 != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Text(selectedOption1!.descricao,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    ),
                  if (selectedOption1 != null && selectedOption2 == null)
                    const Text('Selecione a planta:',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  if (selectedOption1 != null && selectedOption2 == null)
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: StreamBuilder<RealmResultsChanges<Produto>>(
                          stream: realmServices.getProdutos().changes,
                          builder: (context, snapshot) {
                            final data = snapshot.data;
                            if (data == null) return waitingIndicator();
                            final results = data.results;
                            return DropdownButton<Produto>(
                              value: selectedOption2,
                              isExpanded: true,
                              onChanged: (Produto? newValue) {
                                setState(() {
                                  selectedOption2 = newValue;
                                });
                              },
                              items: results
                                  .toList()
                                  .map<DropdownMenuItem<Produto>>(
                                      (Produto value) {
                                return DropdownMenuItem<Produto>(
                                  value: value,
                                  child: Text(
                                      produtos!
                                          .where((element) =>
                                              element.id.toString() ==
                                              value.iDEspecime.toString())
                                          .first
                                          .capacidade,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black)),
                                );
                              }).toList(),
                            );
                          },
                        )),
                  const SizedBox(height: 20),
                  if (selectedOption1 != null && selectedOption2 != null)
                    const Text('Planta selecionada:',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  if (selectedOption1 != null && selectedOption2 != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Text(selectedOption2!.nomePlanta.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    ),
                  if (selectedOption1 != null &&
                      selectedOption2 != null &&
                      selectedOption3 == null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: DropdownButton<String>(
                        value: selectedOption3,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption3 = newValue;
                          });
                        },
                        items: ["Frutos", "Pragas"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          );
                        }).toList(),
                      ),
                    ),
                  if (selectedOption1 != null &&
                      selectedOption2 != null &&
                      selectedOption3 != null)
                    const Text('Tipo de analise selecionada:',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  if (selectedOption1 != null &&
                      selectedOption2 != null &&
                      selectedOption3 != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Text(selectedOption3.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                    ),
                  if (selectedOption1 != null &&
                      selectedOption2 != null &&
                      selectedOption3 != null)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _uploadImageToS3(realmServices.currentUser!.id);
                      },
                      child: const Text('Confirmar'),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: source,
    );

    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _uploadImageToS3(String id) async {
    final realmServices = Provider.of<RealmServices>(context, listen: false);
    String imagePath = _storedImage!.path;
    String formato = imagePath.substring(imagePath.lastIndexOf('.'));
    String url, res;
    dynamic result, resposta;
    List<String> objetos = [];
    final amplifyService = S3StorageUtil();
    realmServices.switchObjetosDetectado([]);
    if (_storedImage != null) {
      result = await amplifyService.uploadImage(
          'imagem_analisada/$id${DateTime.now().millisecondsSinceEpoch}$formato',
          _storedImage!);
      if (result != null) {
        url = await amplifyService.getDownloadUrl(key: result.uploadedItem.key);
        final azureClient = VisionApiClient("34896d3a8c86483eb261c60ff2ab698a",
            "https://contadortomatesteste-prediction.cognitiveservices.azure.com/customvision/v3.0/Prediction/f0e3807a-c8ac-4051-a468-ee21f2d63113/detect/iterations/Iteration7/url");
        resposta = await azureClient.detectObjects(url);
        for (Map<String, dynamic> detectedObject in resposta) {
          // Acessando informações específicas de cada objeto
          double probability = detectedObject["probability"];
          String tagName = detectedObject["tagName"];

          // Acessando informações da bounding box
          Map<String, dynamic> boundingBox = detectedObject["boundingBox"];
          double left = boundingBox["left"];
          double top = boundingBox["top"];
          double width = boundingBox["width"];
          double height = boundingBox["height"];

          res = realmServices.createObjetosDetectado(
              height, left, probability, tagName, top, width);
          objetos.add(res);
        }
        realmServices.createRelatoriosDeteccao(selectedOption2!.id.toString(),
            result.uploadedItem.key, objetos, selectedOption3!);
      } else {}
    }
    _storedImage = null;
  }
}
