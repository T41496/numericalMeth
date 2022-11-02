import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import '../models/BisectionResultRow.dart';

// ignore: must_be_immutable
class Result extends StatefulWidget {
  List<ResultRow> resultList;
  Map<String, dynamic> data;

  _ResultState createState() => _ResultState();

  Result(this.resultList, this.data);
}

class _ResultState extends State<Result> {
  double fa, fb, x, fx, lastFx;
  void initState() {
    super.initState();
    var f = widget.data["function"] as SingleVariableFunction;
    var a = widget.data["pointA"];
    var b = widget.data["pointB"];
    fa = f(a);
    fb = f(b);
    x = (a + b) / 2;
    fx = f(x);
    lastFx = f(widget.resultList[widget.resultList.length - 1].x);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Soln:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "We have,",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                            "f(x)=${widget.data["expression"]}"),
                        Text("Error(e)=${widget.data["error"]}"),
                        Text(
                            "Now, finding root interval by using tabulation method"),
                        Center(
                          child: DataTable(columns: [
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "x",
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                widget.data["pointA"].toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                widget.data["pointB"].toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )),
                          ], rows: [
                            DataRow(cells: [
                              DataCell(Center(child: Text("f(x)"))),
                              DataCell(
                                  Center(child: Text(fa.toStringAsFixed(4)))),
                              DataCell(
                                  Center(child: Text(fb.toStringAsFixed(4)))),
                            ])
                          ]),
                        ),
                        Text(
                            "Here, the sign of f(x) changes between interval (${widget.data['pointA']},${widget.data['pointB']}).So, at least one root must lie between [${widget.data['pointA']},${widget.data['pointB']}]."),
                        Center(
                          child: DataTable(dividerThickness: 0, columns: [
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "a=${widget.data['pointA']}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                "b=${widget.data['pointB']}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ))
                          ], rows: [
                            DataRow(cells: [
                              DataCell(Center(
                                  child:
                                      Text("f(a)=${fa.toStringAsFixed(4)}"))),
                              DataCell(Center(
                                  child:
                                      Text("f(b)=${fb.toStringAsFixed(4)}"))),
                            ])
                          ]),
                        ),
                        Text(
                          "Now,",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text("Applying formula for bisection method.We have,"),
                        Text(
                            "x = (a+b)/2 = (${widget.data['pointA']}+${widget.data['pointB']})/2 =$x."),
                        Text(
                          "And,",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text("f(x)=f($x)=${fx.toStringAsFixed(4)}"),
                        Text(
                            "Now, Finding sucessive approximation root using table for bisection method. We get"),
                      ],
                    )),
                    DataTable(
                      columnSpacing: 6,
                      dataRowHeight: 40,
                      columns: const <DataColumn>[
                        DataColumn(label: Expanded(child: Text("Iteration"))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "a",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "b",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "x=(a+b)/2",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "Sign of f(x)",
                          textAlign: TextAlign.center,
                        )))
                      ],
                      rows: [
                        ...widget.resultList.map((e) {
                          return DataRow(cells: [
                            DataCell(
                                Center(child: Text(e.iteration.toString()))),
                            DataCell(Center(
                              child: Text(e.a.toString().length > 5
                                  ? e.a.toStringAsFixed(5)
                                  : e.a.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.b.toString().length > 5
                                  ? e.b.toStringAsFixed(5)
                                  : e.b.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.x.toString().length > 5
                                  ? e.x.toStringAsFixed(5)
                                  : e.x.toString()),
                            )),
                            DataCell(Center(
                                child: Text(
                              e.isNegative ? "-VE" : "+VE",
                              textAlign: TextAlign.center,
                            )))
                          ]);
                        })
                      ],
                    ),
                    Text("Hence at ${widget.resultList.length - 1} step,"),
                    Text("|b-a|< Error(e)"),
                    Text(
                      "Thus,",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                        "The root of the function lies at x=${widget.resultList[widget.resultList.length - 1].x.toStringAsFixed(4)} correct upto required decimal place with f(x)=${lastFx.toStringAsFixed(4)} ~ 0.")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
