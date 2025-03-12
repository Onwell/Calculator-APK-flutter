import 'package:flutter/material.dart';

void main() {
  runApp(SimpleCalculatorApp());
}

class SimpleCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smug Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; // Current output displayed on the screen
  String _expression = ""; // Full expression (e.g., "7 / 2 = 3.50")

  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      // Clear everything
      _output = "0";
      _expression = "";
    } else if (buttonText == "=") {
      // Evaluate the expression
      try {
        // Remove any leading/trailing spaces and split into parts
        _output = _output.trim();
        List<String> parts = _output.split(" ");

        // Ensure the expression has exactly 3 parts (num1, operator, num2)
        if (parts.length != 3) {
          throw Exception("Invalid expression");
        }

        double num1 = double.parse(parts[0]);
        String operator = parts[1];
        double num2 = double.parse(parts[2]);

        double result = 0;
        switch (operator) {
          case "+":
            result = num1 + num2;
            break;
          case "-":
            result = num1 - num2;
            break;
          case "x":
            result = num1 * num2;
            break;
          case "/":
            result = num1 / num2;
            break;
          default:
            throw Exception("Invalid operator");
        }

        // Update the expression and output
        _expression = "$_output = ${result.toStringAsFixed(2)}";
        _output = result.toStringAsFixed(2);
      } catch (e) {
        // Handle invalid expressions
        _expression = "Error";
        _output = "0";
      }
    } else {
      // Append the button text to the output
      if (_output == "0" && buttonText != ".") {
        _output = buttonText;
      } else {
        // Add a space before and after the operator
        if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
          _output = _output.trim() + " $buttonText ";
        } else {
          _output += buttonText;
        }
      }
    }

    setState(() {}); // Update the UI
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smug Calculator'),
      ),
      body: Column(
        children: <Widget>[
          // Display the full expression
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _expression,
              style: TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
          ),
          // Display the current output
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("/"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("x"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("."),
                  buildButton("0"),
                  buildButton("00"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("C"),
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}