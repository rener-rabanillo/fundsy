import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Insights',
        style: text.bodyMedium!.copyWith(
          color: color.onSurface
        ),
      ),
    );
  }
}
