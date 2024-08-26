import 'package:get/get.dart';

import '../modules/add_classroom_page/bindings/add_classroom_page_binding.dart';
import '../modules/add_classroom_page/views/add_classroom_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ADD_CLASSROOM_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CLASSROOM_PAGE,
      page: () => const AddClassroomPageView(),
      binding: AddClassroomPageBinding(),
    ),
  ];
}
