import 'package:flutter/material.dart';

class IngredientCountInput extends StatefulWidget {
  final TextEditingController percentage;
  final double amount;
  final int location;
  final Function(int i) removeIngredient;

  const IngredientCountInput(
      {super.key,
      required this.percentage,
      required this.amount,
      required this.location,
      required this.removeIngredient});

  @override
  State<IngredientCountInput> createState() => _IngredientCountInputState();
}

class _IngredientCountInputState extends State<IngredientCountInput> {
  final _formKey = GlobalKey<FormState>();
  // bool isPercentageValid = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => widget.removeIngredient(widget.location),
              child: const Icon(Icons.delete),
            ),
            Flexible(
                child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  label: const Text("Ingredient Name")),
            )),
            Flexible(
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text("Percentage"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  controller: widget.percentage,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == "") {
                      return "Required";
                    } else if (double.tryParse(value!) == null ||
                        !(double.tryParse(value)! > 0)) {
                      return "Invalid";
                    } else {
                      return null;
                    }
                  }),
            ),
            Flexible(
              flex: 2,
              child: Text(
                'Amount: ${widget.amount.toStringAsFixed(2)} Kg',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
