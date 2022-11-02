// *Import flutter packages
import "package:flutter/material.dart";
import 'package:function_tree/function_tree.dart';
import 'package:math_expressions/math_expressions.dart';

import '../models/NewtonRapshonResultRow.dart';
import '../widgets/newton_result_view.dart';

class NewtonRaphsonMethod extends StatefulWidget {
  static const routeName = "/newton-raphson-method";
  @override
  _NewtonRaphsonMethodState createState() => _NewtonRaphsonMethodState();
}

class _NewtonRaphsonMethodState extends State<NewtonRaphsonMethod> {
  var expressionController = TextEditingController();
  var errorController = TextEditingController();
  var initialPointController = TextEditingController();

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

  String initialPointValidator(dynamic value) {
    if (value.toString().isEmpty) return "Required*";
    return null;
  }

  void _calculationHandler(BuildContext context) {
    // *Hide softkeyboard
    FocusScope.of(context).requestFocus(new FocusNode());

    double error = double.parse(errorController.text);
    num x0 = double.parse(initialPointController.text);
    String expression = expressionController.text;

    if (expression.isEmpty || error.toString().isEmpty || x0.toString().isEmpty)
      return;

    ResultRow resultRow;
    num iteration = 0;

    List<ResultRow> tempResultList = [];

    num fx0, gx0, x1, fx1;

    // *To find derivative
    Parser p = Parser();
    Expression exp = p.parse(expressionController.text);
    Expression expDerived = exp.derive('x');

    String derivativeOfExpression = expDerived.simplify().toString();

    SingleVariableFunction g =
        derivativeOfExpression.toSingleVariableFunction();

    fx0 = f(x0);
    gx0 = g(x0);

    x1 = x0 - fx0 / gx0;
    fx1 = f(x1);

    resultRow = ResultRow(
        iteration: iteration, x0: x0, fx0: fx0, gx0: gx0, x1: x1, fx1: fx1);
    tempResultList.add(resultRow);

    while ((x1 - x0).abs() > error) {
      iteration++;
      x0 = x1;
      fx0 = f(x0);
      gx0 = g(x0);

      x1 = x0 - fx0 / gx0;
      fx1 = f(x1);

      resultRow = ResultRow(
          iteration: iteration, x0: x0, fx0: fx0, gx0: gx0, x1: x1, fx1: fx1);
      tempResultList.add(resultRow);
    }
    setState(() {
      resultList = tempResultList;
      data = {
        "expression": expression,
        "derivativeOfExpression": derivativeOfExpression,
        "modifiedExpression": newExpression,
        "function": f,
        "derivativeFunction": g,
        "error": error,
        "initialPointOfRootInterval": double.parse(initialPointController.text)
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Newton Raphson Method"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: expressionController,
                      autofocus: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Expression*",
                          hintText: "Note:for log(x) type:ln(x)/2.3026"),
                      validator: expressionValidator,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: initialPointController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Initial point of root interval*",
                      ),
                      validator: initialPointValidator,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: errorController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Error*",
                          hintText: "0.0005"),
                      validator: errorValidator,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 300,
                          child: ElevatedButton(
                            onPressed: () {
                              validator(context);
                            },
                            child: Text("Calculate"),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              textStyle: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (resultList.length > 0) Result(resultList, data)
        ],
      ),
    );
  }
}

//Ernest Neo
//www.T41496.com.np