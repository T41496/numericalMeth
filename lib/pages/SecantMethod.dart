// *Import flutter packages
import "package:flutter/material.dart";
import 'package:function_tree/function_tree.dart';

import '../models/SecantResultRow.dart';
import '../widgets/secant_result_view.dart';
import '../widgets/user_input.dart';

class SecantMethod extends StatefulWidget {
  static const routeName = "/secant-method";
  @override
  _SecantMethodState createState() => _SecantMethodState();
}

class _SecantMethodState extends State<SecantMethod> {
  var expressionController = TextEditingController();
  var errorController = TextEditingController();

  SingleVariableFunction f;

  String expression, newExpression;

  // *Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<ResultRow> resultList;
  Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();

    resultList = [];
    data = {
      "expression": "",
      "modifiedExpression": "",
      "function": null,
      "error": 0,
      "pointX0": -1,
      "pointX1": -1
    };
  }

  void validator(BuildContext context) {
    if (formKey.currentState.validate()) {
      _calculationHandler(context);
    }
  }

  String expressionValidator(dynamic value) {
    if (value.toString().isEmpty) {
      return "Required*";
    } else {
      try {
        expression = value.toString();
        if (expression.contains("ln")) {
          newExpression = expression.replaceAll("ln", "log");
          f = newExpression.toSingleVariableFunction();
        }
        f = expression.toSingleVariableFunction();
        return null;
      } catch (_) {
        return "Bad expression!";
      }
    }
  }

  String errorValidator(dynamic value) {
    if (value.toString().isEmpty) return "Required*";
    if (double.parse(value) >= 0.1) return "Error must be less than 0.1";
    return null;
  }

  void _calculationHandler(BuildContext context) {
    // *Hide softkeyboard
    FocusScope.of(context).requestFocus(new FocusNode());

    double error = double.parse(errorController.text);

    if (expression.isEmpty || error.toString().isEmpty) return;

    int tempX0, tempX1;

    ResultRow resultRow;
    num iteration = 0;

    List<ResultRow> tempResultList = [];

    num x0, x1, fx0, fx1, x2, fx2, i;

    for (i = 0; i < 10; i++) {
      if (f(i).isNaN) continue;
      if (f(i).isInfinite) continue;
      bool isFirstValueNegative = f(i) < 0 ? true : false;
      bool isSecondValueNegative = f(i + 1) < 0 ? true : false;

      if (isFirstValueNegative != isSecondValueNegative) break;
    }

    //* Starting point of root
    x0 = i;
    tempX0 = i;

    // *End point of root
    x1 = i + 1;
    tempX1 = i + 1;

    fx0 = f(x0);
    fx1 = f(x1);

    x2 = (x0 * fx1 - x1 * fx0) / (fx1 - fx0);
    fx2 = f(x2);

    resultRow = ResultRow(
        iteration: iteration,
        x0: x0,
        fx0: fx0,
        x1: x1,
        fx1: fx1,
        x2: x2,
        fx2: fx2);
    tempResultList.add(resultRow);

    num temp = 0;
    String tempX2 = "0";

    while ((temp - x2).abs() > error) {
      iteration++;
      x0 = x1;
      fx0 = fx1;
      x1 = x2;
      fx1 = fx2;

      x2 = (x0 * fx1 - x1 * fx0) / (fx1 - fx0);
      fx2 = f(x2);

      if (x2.toStringAsFixed(4) == tempX2) {
        break;
      }
      tempX2 = x2.toStringAsFixed(4);

      resultRow = ResultRow(
          iteration: iteration,
          x0: x0,
          fx0: fx0,
          x1: x1,
          fx1: fx1,
          x2: x2,
          fx2: fx2);
      tempResultList.add(resultRow);
    }

    setState(() {
      resultList = tempResultList;
      data = {
        "expression": expression,
        "modifiedExpression": newExpression,
        "function": f,
        "error": error,
        "pointX0": tempX0,
        "pointX1": tempX1
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Secant Method"),
      ),
      body: Column(
        children: [
          UserInput(
              expressionController: expressionController,
              errorController: errorController,
              validator: validator,
              formKey: formKey,
              expressionValidator: expressionValidator,
              errorValidator: errorValidator),
          if (resultList.length > 0) Result(resultList, data)
        ],
      ),
    );
  }
}

//Ernest Neo
//www.T41496.com.np