// *Import flutter packages
import "package:flutter/material.dart";
import 'package:function_tree/function_tree.dart';

import '../models/FalseResultRow.dart';
import '../widgets/false_result_view.dart';
import '../widgets/user_input.dart';

class FalsePositionMethod extends StatefulWidget {
  static const routeName = "/false-position-method";
  @override
  _FalsePositionMethodState createState() => _FalsePositionMethodState();
}

class _FalsePositionMethodState extends State<FalsePositionMethod> {
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
      "pointx0": -1,
      "pointx1": -1
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

    int tempx0, tempx1;

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
    tempx0 = i;

    // *End point of root
    x1 = i + 1;
    tempx1 = i + 1;

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
        fx2: fx2,
        isLessThan0: fx0 * fx2 < 0 ? true : false);
    tempResultList.add(resultRow);

    num temp = 0;

    while ((temp - x2).abs() > error) {
      iteration++;
      temp = x2;
      if (fx2 == 0)
        break;
      else if (fx0 * fx2 > 0) {
        x0 = x2;
        fx0 = fx2;
      } else {
        x1 = x2;
        fx1 = fx2;
      }
      x2 = (x0 * fx1 - x1 * fx0) / (fx1 - fx0);
      fx2 = f(x2);
      resultRow = ResultRow(
          iteration: iteration,
          x0: x0,
          fx0: fx0,
          x1: x1,
          fx1: fx1,
          x2: x2,
          fx2: fx2,
          isLessThan0: fx0 * fx2 < 0 ? true : false);
      tempResultList.add(resultRow);
    }

    setState(() {
      resultList = tempResultList;
      data = {
        "expression": expression,
        "modifiedExpression": newExpression,
        "function": f,
        "error": error,
        "pointx0": tempx0,
        "pointx1": tempx1
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("False Position Method"),
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