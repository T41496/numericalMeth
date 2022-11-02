import 'package:flutter/foundation.dart';

class ResultRow {
  num iteration, x0, fx0, gx0, x1, fx1;

  ResultRow({
    @required this.iteration,
    @required this.x0,
    @required this.fx0,
    @required this.gx0,
    @required this.x1,
    @required this.fx1,
  });
}
