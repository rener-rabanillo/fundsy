import 'package:flutter/material.dart';
import 'package:fundsy/core/layouts/main_app_layout.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    final TextTheme text = Theme.of(context).textTheme;

    return MainAppLayout(
      title: 'Dashboard',
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Padding(
        padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              Text(
                'headlineLarge: ${text.headlineLarge?.fontSize}',
                style: text.headlineLarge?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'headlineMedium: ${text.headlineMedium?.fontSize}',
                style: text.headlineMedium?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'headlineSmall: ${text.headlineSmall?.fontSize}',
                style: text.headlineSmall?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'titleLarge: ${text.titleLarge?.fontSize}',
                style: text.titleLarge?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'titleMedium: ${text.titleMedium?.fontSize}',
                style: text.titleMedium?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'titleSmall: ${text.titleSmall?.fontSize}',
                style: text.titleSmall?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'bodyLarge: ${text.bodyLarge?.fontSize}',
                style: text.bodyLarge?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'bodyMedium: ${text.bodyMedium?.fontSize}',
                style: text.bodyMedium?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'bodySmall: ${text.bodySmall?.fontSize}',
                style: text.bodySmall?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'labelLarge: ${text.labelLarge?.fontSize}',
                style: text.labelLarge?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'labelMedium: ${text.labelMedium?.fontSize}',
                style: text.labelMedium?.copyWith(
                  color: color.onSurface
                ),
              ),
              Text(
                'labelSmall: ${text.labelSmall?.fontSize}',
                style: text.labelSmall?.copyWith(
                  color: color.onSurface
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
