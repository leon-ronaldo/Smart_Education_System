import 'package:get/get.dart';

import '../controllers/attendance_page_controller.dart';

class AttendancePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AttendancePageController>(
      () => AttendancePageController(),
    );
  }
}
