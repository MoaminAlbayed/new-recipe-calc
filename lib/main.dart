import 'package:flutter/material.dart';
import 'package:recipe_calculator/count_input.dart';
import 'dart:developer';

import 'amount_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isAmountInput;

  @override
  void initState() {
    isAmountInput = true;
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    void switchInput() {
      setState(() {
        isAmountInput = !isAmountInput;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isAmountInput
          ? AmountInput(switchInput: switchInput)
          : CountInput(switchInput: switchInput)
    );
  }
}

// class AmountInput extends StatefulWidget {
//   const AmountInput({super.key});
//
//   @override
//   State<AmountInput> createState() => _AmountInputState();
// }
//
// class _AmountInputState extends State<AmountInput> {
//   late final List<TextEditingController> _percentage = [];
//   late final List<TextEditingController> _amount = [];
//   late final List<double> _remaining = [];
//
//   late String totalCount = "";
//   late final List<double> _ingredientResult = [];
//
//
//   @override
//   void initState() {
//     _addIngredient();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     for (var element in _percentage) {element.dispose();}
//     for (var element in _amount) {element.dispose();}
//     super.dispose();
//   }
//
//   void _addIngredient() {
//     setState(() {
//       _percentage.add(TextEditingController());
//       _amount.add(TextEditingController());
//       _remaining.add(0);
//     });
//   }
//
//   void _removeIngredient(i) {
//     setState(() {
//       _percentage.removeAt(i);
//       _amount.removeAt(i);
//       _remaining.removeAt(i);
//     });
//   }
//
//   void showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Error'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text(message),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Approve'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     double findMinimum (List<double> list){
//       double minimum =list[0];
//       for (int i=1; i<list.length; i++){
//         if (list[i]<minimum) minimum = list[i];
//       }
//       return minimum;
//     }
//
//     void calculate() {
//       double totalPercentages=0;
//       for (var element in _percentage) { totalPercentages+=double.tryParse(element.text)??0;} //adding all percentages to check if they reach 100
//       if (totalPercentages != 100) {
//         showErrorDialog("All percentages must add up to 100");
//         return;
//       }
//       for (var element in _amount) { if (double.tryParse(element.text) == null) {
//           showErrorDialog("Please enter all amounts");
//           return;
//         }
//       }
//
//       for (int i=0;i<_percentage.length;i++) {
//         _ingredientResult.add(double.parse(_amount[i].text)/(double.parse(_percentage[i].text)/100));
//       }
//
//       setState(() {
//         totalCount = findMinimum(_ingredientResult).floor().toString();
//       });
//
//       for (int i=0;i<_percentage.length;i++) {
//         setState(() {
//           _remaining[i] = double.parse(_amount[i].text)-((double.parse(_percentage[i].text)/100) * double.parse(totalCount));
//         });
//
//       }
//     }
//
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       //   title: Text("Recipe Calculator"),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: ListView(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         MaterialButton(
//                           onPressed: _addIngredient,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           color: Colors.blue,
//                           child: const Text("Add Ingredient"),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         MaterialButton(
//                           onPressed: calculate,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           color: Colors.green,
//                           child: const Text("Calculate"),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         MaterialButton(
//                           onPressed: () {
//                             int total = 0;
//                             for (int i = 0; i < _percentage.length; i++) {
//                               total += int.parse(_percentage[i].value.text);
//                             }
//                             log("total: $total");
//                           },
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                           color: Colors.blue,
//                           child: const Text("Log"),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text("Total Count: $totalCount",
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     for (int i = 0; i < _percentage.length; i++)
//                       IngredientAmountInput(
//                         percentage: _percentage[i],
//                         amount: _amount[i],
//                         remaining: _remaining[i],
//                         removeIngredient: _removeIngredient,
//                         location: i,
//                       )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IngredientAmountInput extends StatefulWidget {
//   final TextEditingController percentage;
//   final TextEditingController amount;
//   final double remaining;
//   final int location;
//   final Function(int i) removeIngredient;
//
//   const IngredientAmountInput(
//       {super.key,
//       required this.percentage,
//       required this.amount,
//       required this.remaining,
//       required this.location,
//       required this.removeIngredient});
//
//   @override
//   State<IngredientAmountInput> createState() => _IngredientAmountInputState();
// }
//
// class _IngredientAmountInputState extends State<IngredientAmountInput> {
//   final _formKey = GlobalKey<FormState>();
//   bool isPercentageValid = false;
//   bool isAmountValid = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       child: Form(
//         key: _formKey,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             InkWell(
//               onTap: () => widget.removeIngredient(widget.location),
//               child: const Icon(Icons.delete),
//             ),
//             Flexible(
//                 child: TextField(
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0)),
//                   label: const Text("Ingredient Name")),
//             )),
//             Flexible(
//               child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     label: const Text("Percentage"),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                   ),
//                   controller: widget.percentage,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) {
//                     if (value == "") {
//                       return "Required";
//                     } else if (double.tryParse(value!) == null || !(double.tryParse(value)! > 0)) {
//                       return "Invalid";
//                     } else {
//                       return null;
//                     }
//                   }),
//             ),
//             Flexible(
//               child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     label: const Text("Amount (Kg)"),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5.0)),
//                     // label: const Text("percentage")
//                   ),
//                   controller: widget.amount,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   validator: (value) {
//                     if (value == "") {
//                       return "Required";
//                     } else if (double.tryParse(value!) == null || !(double.tryParse(value)! > 0)) {
//                       return "Invalid";
//                     } else {
//                       return null;
//                     }
//                   }),
//             ),
//             Flexible(
//               flex: 2,
//               child: Text(
//                 'Remaining: ${widget.remaining.toStringAsFixed(2)} Kg',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
