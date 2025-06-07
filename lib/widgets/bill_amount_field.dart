import 'package:flutter/material.dart';

class BillAmountField extends StatelessWidget {
  const BillAmountField({
    super.key,
    required this.billAmount,
    required this.onChanged,
  });

  final String billAmount;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Bill Amount',
        hintText: '20.24',
        prefixIcon: Icon(Icons.attach_money),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          gapPadding: 4.0,
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        onChanged(value);
      },
    );
  }
}
