import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task1/core/utities/constants.dart';
import 'package:task1/features/weather/domain/entities/ai_prediction_entity.dart';

class AiModelService {
  Future<AiPredictionEntity> predict(List<int> features) async {
    // Convert features to a JSON object
    final Map<String, dynamic> requestBody = {'features': features};

    final response = await http.post(
      Uri.parse('${AppConstants.AiModelBaseUrl}/predict'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      // Check if response is a list or an object containing a list
      List<dynamic> predictionList;
      if (responseData is List) {
        predictionList = responseData;
      } else if (responseData is Map &&
          responseData.containsKey('prediction') &&
          responseData['prediction'] is List) {
        predictionList = responseData['prediction'];
      } else {
        throw Exception('Unexpected response format: $responseData');
      }

      // Assuming the first element in the list is the prediction (0 or 1)
      // If the list is empty or doesn't contain a valid prediction, default to 0 (stay inside)
      final int predictionValue = predictionList.isNotEmpty
          ? (predictionList[0] is int ? predictionList[0] : 0)
          : 0;

      final bool shouldGoOutside = predictionValue == 1;

      return AiPredictionEntity(shouldGoOutside: shouldGoOutside);
    } else {
      throw Exception('Failed to get prediction: ${response.statusCode}');
    }
  }
}
