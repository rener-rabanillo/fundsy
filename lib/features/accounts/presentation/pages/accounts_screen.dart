import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Text(
        'Accounts',
        style: text.bodyMedium!.copyWith(
          color: color.onSurface
        ),
      ),
    );
  }
}
