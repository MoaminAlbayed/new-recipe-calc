import 'package:flutter/material.dart';
import 'dart:developer';

import 'ingredient_amount_input.dart';

class AmountInput extends StatefulWidget {
  AmountInput({super.key, required this.switchInput});

  Function switchInput;

  @override
  State<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  late final List<TextEditingController> _percentage = [];
  late final List<TextEditingController> _amount = [];
  late final List<double> _remaining = [];

  late String totalCount = "";
  late final List<double> _ingredientResult = [];

  @override
  void initState() {
    _addIngredient();
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _percentage) {
      element.dispose();
    }
    for (var element in _amount) {
      element.dispose();
    }
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _percentage.add(TextEditingController());
      _amount.add(TextEditingController());
      _remaining.add(0);
    });
  }

  void _removeIngredient(i) {
    setState(() {
      _percentage.removeAt(i);
      _amount.removeAt(i);
      _remaining.removeAt(i);
    });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double findMinimum(List<double> list) {
      double minimum = list[0];
      for (int i = 1; i < list.length; i++) {
        if (list[i] < minimum) minimum = list[i];
      }
      return minimum;
    }

    void calculate() {
      double totalPercentages = 0;
      for (var element in _percentage) {
        totalPercentages += double.tryParse(element.text) ?? 0;
      } //adding all percentages to check if they reach 100
      if (totalPercentages != 100) {
        showErrorDialog("All percentages must add up to 100");
        return;
      }
      for (var element in _amount) {
        if (double.tryParse(element.text) == null) {
          showErrorDialog("Please enter all amounts");
          return;
        }
      }

      for (int i = 0; i < _percentage.length; i++) {
        _ingredientResult.add(double.parse(_amount[i].text) /
            (double.parse(_percentage[i].text) / 100));
      }

      setState(() {
        totalCount = findMinimum(_ingredientResult).floor().toString();
      });

      for (int i = 0; i < _percentage.length; i++) {
        setState(() {
          _remaining[i] = double.parse(_amount[i].text) -
              ((double.parse(_percentage[i].text) / 100) *
                  double.parse(totalCount));
        });
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text("Recipe Calculator"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: _addIngredient,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.orange,
                          child: const Text("Add Ingredient", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: calculate,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.green,
                          child: const Text("Calculate", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () {
                            widget.switchInput();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.blue,
                          child: const Text("Switch Input", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text("Total Count: $totalCount",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 30,
                    ),
                    for (int i = 0; i < _percentage.length; i++)
                      IngredientAmountInput(
                        percentage: _percentage[i],
                        amount: _amount[i],
                        remaining: _remaining[i],
                        removeIngredient: _removeIngredient,
                        location: i,
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
