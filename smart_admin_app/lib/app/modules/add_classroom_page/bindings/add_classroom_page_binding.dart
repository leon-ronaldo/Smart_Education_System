import 'package:get/get.dart';

import '../controllers/add_classroom_page_controller.dart';

class AddClassroomPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddClassroomPageController>(
      () => AddClassroomPageController(),
    );
  }
}
