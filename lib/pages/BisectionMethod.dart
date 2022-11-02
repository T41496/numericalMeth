// *Import flutter packages
import "package:flutter/material.dart";
import 'package:function_tree/function_tree.dart';

import '../models/BisectionResultRow.dart';
import '../widgets/user_input.dart';
import '../widgets/bisection_result_view.dart';

class BisectionMethod extends StatefulWidget {
  static const routeName = "/bisection-method";
  @override
  _BisectionMethodState createState() => _BisectionMethodState();
}

class _BisectionMethodState extends State<BisectionMethod> {
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
      "pointA": -1,
      "pointB": -1
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

    int tempA, tempB;

    ResultRow resultRow;
    num iteration = 0;

    List<ResultRow> tempResultList = [];

    num a, b, fa, fb, x, fx, i;

    for (i = 0; i < 10; i++) {
      if (f(i).isNaN) continue;
      if (f(i).isInfinite) continue;

      bool isFirstValueNegative = f(i) < 0 ? true : false;
      bool isSecondValueNegative = f(i + 1) < 0 ? true : false;

      if (isFirstValueNegative != isSecondValueNegative) break;
    }

    //* Starting point of root
    a = i;
    tempA = i;

    // *End point of root
    b = i + 1;
    tempB = i + 1;

    fa = f(a);
    fb = f(b);

    x = (a + b) / 2;
    fx = f(x);

    resultRow = ResultRow(
        iteration: iteration,
        a: a,
        b: b,
        x: x,
        isNegative: fx < 0 ? true : false);
    tempResultList.add(resultRow);

    while ((b - a).abs() > error) {
      iteration++;
      if ((fa * fx) > 0) {
        a = x;
        fa = fx;
      } else {
        b = x;
        fb = fx;
      }
      x = (a + b) / 2;
      fx = f(x);

      resultRow = ResultRow(
          iteration: iteration,
          a: a,
          b: b,
          x: x,
          isNegative: fx < 0 ? true : false);
      tempResultList.add(resultRow);
    }

    setState(() {
      resultList = tempResultList;
      data = {
        "expression": expression,
        "modifiedExpression": newExpression,
        "function": f,
        "error": error,
        "pointA": tempA,
        "pointB": tempB
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bisection Method"),
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
          if (resultList.length > 0) Result(resultList, data),
        ],
      ),
    );
  }
}

//Ernest Neo
//www.T41496.com.np