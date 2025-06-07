import 'package:flutter/material.dart';

class PersonWidget extends StatelessWidget {
  const PersonWidget({
    super.key,
    required this.theme,
    required int totalPerson,
    required this.onDecrement,
    required this.onIncrement,
  }) : _totalPerson = totalPerson;

  final ThemeData theme;
  final int _totalPerson;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Split", style: theme.textTheme.titleMedium),
        Row(
          children: [
            IconButton(onPressed: onDecrement, icon: Icon(Icons.remove)),
            const SizedBox(width: 4),
            Text("$_totalPerson", style: theme.textTheme.titleMedium),
            const SizedBox(width: 4),
            IconButton(onPressed: onIncrement, icon: Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
