import 'package:flutter/foundation.dart';

class ResultRow {
  num iteration, x0, fx0, x1, fx1, x2, fx2;
  bool isLessThan0;

  ResultRow(
      {@required this.iteration,
      @required this.x0,
      @required this.fx0,
      @required this.x1,
      @required this.fx1,
      @required this.x2,
      @required this.fx2,
      @required this.isLessThan0});
}
