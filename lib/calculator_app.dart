import 'package:flutter/material.dart';
import 'package:flutter_calculator/colors.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var outputSize = 48.0;
  var hideInput = false;

  onClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll('x', "*");
        Parser parcer = Parser();
        Expression expression = parcer.parse(userInput);
        ContextModel contextModel = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, contextModel);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 45;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: operatorColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
            Row(
              children: [
                calcButton(
                  number: "AC",
                  color: operatorColor,
                  tcolor: orangeColor,
                ),
                calcButton(
                  number: "<",
                  tcolor: orangeColor,
                  color: operatorColor,
                ),
                calcButton(
                  number: "",
                  color: operatorColor,
                ),
                calcButton(
                  number: "/",
                  color: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  number: "7",
                ),
                calcButton(
                  number: "8",
                ),
                calcButton(
                  number: "9",
                ),
                calcButton(
                  number: "x",
                  color: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  number: "4",
                ),
                calcButton(
                  number: "5",
                ),
                calcButton(
                  number: "6",
                ),
                calcButton(
                  number: "-",
                  color: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  number: "1",
                ),
                calcButton(
                  number: "2",
                ),
                calcButton(
                  number: "3",
                ),
                calcButton(
                  number: "+",
                  color: operatorColor,
                ),
              ],
            ),
            Row(
              children: [
                calcButton(
                  number: "%",
                  color: operatorColor,
                ),
                calcButton(
                  number: "0",
                ),
                calcButton(
                  number: ".",
                  color: operatorColor,
                ),
                calcButton(
                  number: "=",
                  color: orangeColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget calcButton({color = buttonColor, number, tcolor = Colors.white}) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 4,
            backgroundColor: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22)),
        onPressed: () => onClick(number),
        child: Text(
          number,
          style: TextStyle(
              fontSize: 18, color: tcolor, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
