import 'package:get/get.dart';

import '../controllers/class_room_page_controller.dart';

class ClassRoomPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassRoomPageController>(
      () => ClassRoomPageController(),
    );
  }
}
