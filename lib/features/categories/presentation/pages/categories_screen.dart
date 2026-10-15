import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Categories',
        style: text.bodyMedium!.copyWith(
          color: color.onSurface
        ),
      ),
    );
  }
}
