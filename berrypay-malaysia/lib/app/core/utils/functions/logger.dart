import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var l = Logger();

/// This function will check the current application environment
/// set by the user based on [AppConst.stagingApiUrl]
/// It also will double check with the Flutter's [print] statement
/// based on [kDebugMode]. <- Hover on this word to see the elaboration
logger(Object? object, {String? name}) {
  if (kDebugMode) {
    l.d(object.toString());
  }
}
