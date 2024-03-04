import 'dart:convert';
import 'package:http/http.dart' as http;

class VisionApiClient {
  final String subscriptionKey;
  final String endpoint;

  VisionApiClient(this.subscriptionKey, this.endpoint);

  Future<List<dynamic>> detectObjects(String imageUrl) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Prediction-Key': subscriptionKey,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode({'url': imageUrl}),
      );

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> tags = responseBody['predictions'];

      List<dynamic> tagStrings = [];
      if (tags.isEmpty) {
      } else {
        for (dynamic tag in tags) {
          if (tag['probability'] > 0.44) {
            tagStrings.add(tag);
          }
        }
      }

      return tagStrings;
    } catch (error) {
      return [];
    }
  }
}
