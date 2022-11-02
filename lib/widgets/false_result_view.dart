import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

import '../models/FalseResultRow.dart';

// ignore: must_be_immutable
class Result extends StatefulWidget {
  List<ResultRow> resultList;
  Map<String, dynamic> data;

  _ResultState createState() => _ResultState();

  Result(this.resultList, this.data);
}

class _ResultState extends State<Result> {
  double fx0, fx1, x2, fx2, lastFx;
  void initState() {
    super.initState();
    var f = widget.data["function"] as SingleVariableFunction;
    var x0 = widget.data["pointx0"];
    var x1 = widget.data["pointx1"];
    fx0 = f(x0);
    fx1 = f(x1);
    x2 = (x0 * fx1 - x1 * fx0) / (fx1 - fx0);
    fx2 = f(x2);
    lastFx = f(widget.resultList[widget.resultList.length - 1].x2);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      Text(
                          "f(x)=${widget.data["expression"].toString()}"),
                      Text("Error(e)=${widget.data["error"]}"),
                      Text(
                          "Now, finding root interval by using tabulation method"),
                      Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
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
                                widget.data["pointx0"].toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                                textAlign: TextAlign.center,
                              ),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text(
                                widget.data["pointx1"].toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            )),
                          ], rows: [
                            DataRow(cells: [
                              DataCell(Center(child: Text("f(x)"))),
                              DataCell(
                                  Center(child: Text(fx0.toStringAsFixed(4)))),
                              DataCell(
                                  Center(child: Text(fx1.toStringAsFixed(4)))),
                            ])
                          ]),
                        ),
                      ),
                      Text(
                          "Here, the sign of f(x) changes between interval (${widget.data['pointx0']},${widget.data['pointx1']}).So, at least one root must lie between [${widget.data['pointx0']},${widget.data['pointx1']}]."),
                      Center(
                        child: DataTable(dividerThickness: 0, columns: [
                          DataColumn(
                              label: Expanded(
                            child: Text(
                              "x0=${widget.data['pointx0']}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text(
                              "x1=${widget.data['pointx1']}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ))
                        ], rows: [
                          DataRow(cells: [
                            DataCell(Center(
                                child:
                                    Text("f(x0)=${fx0.toStringAsFixed(4)}"))),
                            DataCell(Center(
                                child:
                                    Text("f(x1)=${fx1.toStringAsFixed(4)}"))),
                          ])
                        ]),
                      ),
                      Text(
                        "Now,",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                          "Applying formula for false position method. we get,"),
                      Text("x2 = (x0*f(x1)-x1*f(x0))/(f(x1)-f(x0))"),
                      Text(
                          "=(${widget.data['pointx0']} * ${fx1.toStringAsFixed(4)} - ${widget.data['pointx1']} * ${fx0.toStringAsFixed(4)})/(${fx1.toStringAsFixed(4)} - ${fx0.toStringAsFixed(4)}) "),
                      Text("=${fx2.toStringAsFixed(4)}"),
                      Text(
                        "And,",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                          "f(x2)=f(${fx2.toStringAsFixed(4)})=${fx2.toStringAsFixed(4)} !=0"),
                      Text(
                          "Now, Finding sucessive approximation root using table for false position method.We get"),
                    ],
                  )),
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
                          "x1",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "f(x1)",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "x2",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "f(x2)",
                          textAlign: TextAlign.center,
                        ))),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                          "f(x0)*f(x2)<0",
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
                              child: Text(e.x1.toString().length > 5
                                  ? e.x1.toStringAsFixed(5)
                                  : e.x1.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.fx1.toString().length > 5
                                  ? e.fx1.toStringAsFixed(5)
                                  : e.fx1.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.x2.toString().length > 5
                                  ? e.x2.toStringAsFixed(5)
                                  : e.x2.toString()),
                            )),
                            DataCell(Center(
                              child: Text(e.fx2.toString().length > 5
                                  ? e.fx2.toStringAsFixed(5)
                                  : e.fx2.toString()),
                            )),
                            DataCell(Center(
                                child: Text(
                              e.isLessThan0 ? "T" : "F",
                              textAlign: TextAlign.center,
                            )))
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
                      "The root of the given function lies at x=${widget.resultList[widget.resultList.length - 1].x2.toStringAsFixed(4)} correct upto required decimal place with f(x2)=${lastFx.toStringAsFixed(4)} ~ 0.")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
