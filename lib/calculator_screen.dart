import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '';   // screen pe ye dikhta hai
  String num1 = '';      // first number
  String num2 = '';      // second number
  String operator = '';  

 // button dabane pe
  void onBtnTap(String value) {
    if (value == 'C') {
      display = '';
      num1 = '';     // basically sab uda dega ye
      num2 = '';
      operator = '';
    } else if (value == 'DEL') {
      // delete last input
      if (num2.isNotEmpty) {
        num2 = num2.substring(0, num2.length - 1);
        display = num2;
      } else if (operator.isNotEmpty) {
        operator = '';
      } else if (num1.isNotEmpty) {
        num1 = num1.substring(0, num1.length - 1);
        display = num1;
      }
    } else if ('+-x/'.contains(value)) {
      // set operator
      operator = value;
    } else if (value == '=') {
      double n1 = double.tryParse(num1) ?? 0;
      double n2 = double.tryParse(num2) ?? 0;
      double result = 0;

      if (operator == '+') result = n1 + n2;
      if (operator == '-') result = n1 - n2;
      if (operator == 'x') result = n1 * n2;
      if (operator == '/') {
        if (n2 == 0) {
          display = 'Cannot divide by zero';
          num1 = '';
          num2 = '';
          operator = '';
          setState(() {});
          return;
        }
        result = n1 / n2;
      }

      display = result.toString();
      num1 = display;
      num2 = '';
      operator = '';
    } else {
      // numbers
      if (operator.isEmpty) {
        num1 += value;
        display = num1;
      } else {
        num2 += value;
        display = num2;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final buttons = [
      '1','2','3','4','5','6','7','8','9','0',
      '+','-','x','/','=','C','DEL'
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(20),
              child: Text(
                display.isEmpty ? '0' : display,
                style: TextStyle(fontSize: 100),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              children: buttons.map((btn) {
                return ElevatedButton(
                  onPressed: () => onBtnTap(btn),
                  child: Text(btn, style: TextStyle(fontSize: 20)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
