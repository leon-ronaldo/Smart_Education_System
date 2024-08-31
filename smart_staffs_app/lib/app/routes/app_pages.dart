import 'package:get/get.dart';

import '../modules/attendance_page/bindings/attendance_page_binding.dart';
import '../modules/attendance_page/views/attendance_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.REGISTER_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_PAGE,
      page: () => const AttendancePageView(),
      binding: AttendancePageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
  ];
}
