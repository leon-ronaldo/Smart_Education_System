import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ClassRoomPageController extends GetxController {
  RxBool ready = false.obs;
  RxBool success = false.obs;

  final data = Get.arguments['data'];

  Map classRoom = {};
  List students = [];
  RxList studentsThatAppear = [].obs;

  @override
  void onInit() {
    super.onInit();
    getClassRooms();
    print(data['classRoomID']);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getClassRooms() async {
    final response = await http.get(
        Uri.parse('https://smart-education-system.onrender.com/admin/snsct/${data['classRoomID']}'));

    if (response.statusCode == 200) {
      classRoom = jsonDecode(response.body)['classRoom'];
      students = jsonDecode(response.body)['students'];
      studentsThatAppear.value = students;
      print(students);
      ready.value = true;
    } else {
      print(response.body);
    }
  }

  void updateClass() async {
    try {
      final response = await http.post(Uri.parse(
          'https://smart-education-system.onrender.com/admin/snsct/${data['classRoomID']}/confirm'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({
            'students': studentsThatAppear.value
          }));

      if (response.statusCode == 200) {
        print(students);
        success.value = true;
      } else {
        print(response.body);
      }
    } on Exception catch (e) {
      // TODO
    }
  }
}
