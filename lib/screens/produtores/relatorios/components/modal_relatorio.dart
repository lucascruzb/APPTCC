import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:listy/components/realm/schemas.dart';

import '../../../../components/s3/s3_storage_util.dart';

class DrawingModal extends StatelessWidget {
  final List<ObjetosDetectado> boundingBoxes;
  final String imagePath;

  const DrawingModal({
    super.key,
    required this.boundingBoxes,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Resultado da analise de imagem'),
            const SizedBox(height: 10),
            ImageWithBoundingBoxes(
              boundingBoxes: boundingBoxes.map((e) {
                return {
                  'left': e.left,
                  'top': e.top,
                  'width': e.width,
                  'height': e.height,
                  'tagName': e.tagName,
                  'probability': e.probability,
                };
              }).toList(),
              imagePath: imagePath,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWithBoundingBoxes extends StatelessWidget {
  final List<Map<String, dynamic>> boundingBoxes;
  final String imagePath;

  const ImageWithBoundingBoxes({
    super.key,
    required this.boundingBoxes,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading image'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: snapshot.data!,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child:
                      CustomPaint(painter: BoundingBoxPainter(boundingBoxes)),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<String> _loadImage() async {
    final s3controller = S3StorageUtil();
    return await s3controller.getDownloadUrl(key: imagePath);
  }
}

class BoundingBoxPainter extends CustomPainter {
  final List<Map<String, dynamic>> boundingBoxes;

  BoundingBoxPainter(this.boundingBoxes);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintRed = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final Paint paintGreen = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var boundingBox in boundingBoxes) {
      final double left = boundingBox['left'] * size.width;
      final double top = boundingBox['top'] * size.height;
      final double width = boundingBox['width'] * size.width;
      final double height = boundingBox['height'] * size.height;

      // Desenhar o quadrado delimitador
      Rect boundingBoxRect = Rect.fromLTWH(left, top, width, height);
      final Paint paint =
          boundingBox['tagName'] == 'Tomato_fullyripe' ? paintGreen : paintRed;
      canvas.drawRect(boundingBoxRect, paint);

      // Adicionar texto
      final double textLeft = left;
      final double textTop = top - 10;
      final double probability = boundingBox['probability'] * 100;
      final TextStyle textColor = boundingBox['tagName'] == 'Tomato_fullyripe'
          ? const TextStyle(color: Colors.green)
          : const TextStyle(color: Colors.red);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: probability.toStringAsFixed(2),
          style: textColor,
        ),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);

      textPainter.paint(canvas, Offset(textLeft, textTop));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
