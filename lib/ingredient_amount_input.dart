import 'package:flutter/material.dart';

class IngredientAmountInput extends StatefulWidget {
  final TextEditingController percentage;
  final TextEditingController amount;
  final double remaining;
  final int location;
  final Function(int i) removeIngredient;

  const IngredientAmountInput(
      {super.key,
        required this.percentage,
        required this.amount,
        required this.remaining,
        required this.location,
        required this.removeIngredient});

  @override
  State<IngredientAmountInput> createState() => _IngredientAmountInputState();
}

class _IngredientAmountInputState extends State<IngredientAmountInput> {
  final _formKey = GlobalKey<FormState>();
  // bool isPercentageValid = false;
  // bool isAmountValid = false;

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
                    } else if (double.tryParse(value!) == null || !(double.tryParse(value)! > 0)) {
                      return "Invalid";
                    } else {
                      return null;
                    }
                  }),
            ),
            Flexible(
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text("Amount (Kg)"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    // label: const Text("percentage")
                  ),
                  controller: widget.amount,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == "") {
                      return "Required";
                    } else if (double.tryParse(value!) == null || !(double.tryParse(value)! > 0)) {
                      return "Invalid";
                    } else {
                      return null;
                    }
                  }),
            ),
            Flexible(
              flex: 2,
              child: Text(
                'Remaining: ${widget.remaining.toStringAsFixed(2)} Kg',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
