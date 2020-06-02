library flutter_uikit;

import 'package:flutter/material.dart';

export 'ui_button.dart';
export 'ui_image.dart';
export 'ui_text.dart';
export 'ui_tableView.dart';
export 'ui_dialog.dart';
export 'ui_scrollView.dart';
export 'ui_row.dart';
export 'ui_column.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

class UIKit {
  static ColorFilter colorFilter = ColorFilter.mode(Colors.white, BlendMode.colorBurn);
}