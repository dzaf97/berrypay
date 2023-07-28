import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:get/get.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {
    logger("detached");
  }

  @override
  void onInactive() {
    logger("inactice");
  }

  @override
  void onPaused() {
    logger("paused");
  }

  @override
  void onResumed() {
    logger("resumed");
  }
}
