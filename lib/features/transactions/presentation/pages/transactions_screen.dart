import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Transactions',
        style: text.bodyMedium!.copyWith(
          color: color.onSurface
        ),
      ),
    );
  }
}
