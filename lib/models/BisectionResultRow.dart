import 'package:flutter/foundation.dart';

class ResultRow {
  num iteration, a, b, x;
  bool isNegative;

  ResultRow(
      {@required this.iteration,
      @required this.a,
      @required this.b,
      @required this.x,
      @required this.isNegative});
}
