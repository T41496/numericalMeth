import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import '../models/NewtonRapshonResultRow.dart';

// ignore: must_be_immutable
class Result extends StatefulWidget {
  List<ResultRow> resultList;
  Map<String, dynamic> data;

  _ResultState createState() => _ResultState();

  Result(this.resultList, this.data);
}

class _ResultState extends State<Result> {
  double fx0, gx0, x1, fx1;
  void initState() {
    super.initState();
    var f = widget.data["function"] as SingleVariableFunction;
    var g = widget.data["derivativeFunction"] as SingleVariableFunction;
    var x0 = widget.data["initialPointOfRootInterval"];
    fx0 = f(x0);
    gx0 = g(x0);
    x1 = x0 - fx0 / gx0;
    fx1 = f(x1);
  }

  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
            child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Soln:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We have,",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text("f(x)=${widget.data["expression"]}"),
                  Text("f'(x)=${widget.data["derivativeOfExpression"]}"),
                  Text("Error(e)=${widget.data["error"]}"),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                      "let x0=${widget.data["initialPointOfRootInterval"]} be the initial value for root interval, then"),
                  Text(
                      "f(x0)=f(${widget.data["initialPointOfRootInterval"]})=${fx0.toStringAsFixed(4)}"),
                  Text(
                      "f'(x0)=f'(${widget.data["initialPointOfRootInterval"]})=${gx0.toStringAsFixed(4)}"),
                  SizedBox(
                    height: 6,
                  ),
                  Text("Applying formula for Newton Raphson Method, We get"),
                  Text(
                      "x1=x0-f(x0)/f'(x0)=${widget.data["initialPointOfRootInterval"]}-(${fx0.toStringAsFixed(4)} / ${gx0.toStringAsFixed(4)}) =${x1.toStringAsFixed(4)} "),
                  Text(
                    "And,",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                      "f(x1)=f(${x1.toStringAsFixed(4)})=${fx1.toStringAsFixed(4)}"),
                  Text(
                      "Now, Calculating sucessive approximated root by using table for Newton Raphson Method. We get"),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 6,
                      dataRowHeight: 40,
                      columns: const <DataColumn>[
                        DataColumn(label: Expanded(child: Text("Iteration"))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "x0",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "f(x0)",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "f'(x0)",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "x1=x0-f(x0)/f'(x0)",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "f(x1)",
                          textAlign: TextAlign.center,
                        ))),
                      ],
                      rows: [
                        ...widget.resultList.map((e) {
                          return DataRow(cells: [
                            DataCell(
                                Center(child: Text(e.iteration.toString()))),
                            DataCell(Center(
                              child: Text(e.x0.toString().length > 5
                                  ? e.x0.toStringAsFixed(5)
                                  : e.x0.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.fx0.toString().length > 5
                                  ? e.fx0.toStringAsFixed(5)
                                  : e.fx0.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.gx0.toString().length > 5
                                  ? e.gx0.toStringAsFixed(5)
                                  : e.gx0.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.x1.toString().length > 5
                                  ? e.x1.toStringAsFixed(5)
                                  : e.x1.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.fx1.toString().length > 5
                                  ? e.fx1.toStringAsFixed(5)
                                  : e.fx1.toString()),
                            )),
                          ]);
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Hence at ${widget.resultList.length - 1} step,"),
                  Text("|xn-xn-1|< Error(e)"),
                  Text(
                    "Thus,",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                      "The root of the given function lies at x=${widget.resultList[widget.resultList.length - 1].x1.toStringAsFixed(4)} correct upto required decimal place using Newton Raphson Method.")
                ],
              ),
            ),
          ]),
        ),
      ),
    )));
  }
}
