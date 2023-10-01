import 'package:flutter/material.dart';
import 'package:recipe_calculator/ingredient_count_input.dart';
import 'dart:developer';

import 'ingredient_amount_input.dart';

class CountInput extends StatefulWidget {
  CountInput({super.key, required this.switchInput});

  Function switchInput;

  @override
  State<CountInput> createState() => _CountInputState();
}

class _CountInputState extends State<CountInput> {
  late final TextEditingController _count;
  late final List<TextEditingController> _percentage = [];
  late final List<double> _amount = [];

  late String totalCount = "";
  late final List<double> _ingredientResult = [];

  @override
  void initState() {
    _addIngredient();
    _count = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _percentage) {
      element.dispose();
    }
    _count.dispose();
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _percentage.add(TextEditingController());
      _amount.add(0);
    });
  }

  void _removeIngredient(i) {
    setState(() {
      _percentage.removeAt(i);
      _amount.removeAt(i);
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
      if (double.tryParse(_count.text) == null) {
        showErrorDialog("Enter valid total count");
        return;
      }
      for (var element in _percentage) {
        totalPercentages += double.tryParse(element.text) ?? 0;
      } //adding all percentages to check if they reach 100
      if (totalPercentages != 100) {
        showErrorDialog("All percentages must add up to 100");
        return;
      }
      for (int i=0;i<_percentage.length;i++){
        setState(() {
          _amount[i] = double.parse(_count.text)*(double.parse(_percentage[i].text)/100);
        });

      }
    }

    return Scaffold(
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
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          child: TextFormField(
                            controller: _count,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                label: const Text("Total Count")),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value){
                              if (value == "") {
                                return "Required";
                              } else if (double.tryParse(value!) == null || !(double.tryParse(value)! > 0)) {
                                return "Invalid";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    for (int i = 0; i < _percentage.length; i++)
                      IngredientCountInput(percentage: _percentage[i], amount: _amount[i], location: i, removeIngredient: _removeIngredient)
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
