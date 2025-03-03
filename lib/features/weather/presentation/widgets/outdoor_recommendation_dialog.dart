import 'package:flutter/material.dart';
import 'package:task1/features/weather/domain/entities/ai_prediction_entity.dart';

class OutdoorRecommendationDialog extends StatelessWidget {
  final AiPredictionEntity prediction;

  const OutdoorRecommendationDialog({Key? key, required this.prediction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              prediction.shouldGoOutside
                  ? Icons.wb_sunny_rounded
                  : Icons.home_rounded,
              size: 64,
              color: prediction.shouldGoOutside ? Colors.orange : Colors.blue,
            ),
            SizedBox(height: 16),
            Text(
              prediction.shouldGoOutside
                  ? 'You can go outside today!'
                  : 'Better stay indoors today',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              prediction.shouldGoOutside
                  ? 'The weather conditions are favorable for outdoor activities.'
                  : 'The weather conditions suggest staying indoors would be more comfortable.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Got it!'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
