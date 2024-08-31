import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxBool ready = false.obs;

  RxMap data = {
    'profileUrl': 'https://snscourseware.org/images/SNS%20Institutionsapp.png',
    'institutionName': 'SNS College of Technology',
    'notifications': [
      {
        'type': 'Smart Board Session',
        'triggeredOn': DateTime.now().toIso8601String(),
        'classRoom': 'III CSE B'
      },
      {
        "type": "Noise Control Alert",
        "triggeredOn": "2024-08-25T15:00:00Z",
        "classRoom": "II ECE A"
      },
      {
        "type": "Temperature Sensor Alert",
        "triggeredOn": "2024-08-25T15:00:00Z",
        "classRoom": "Cafeteria",
        "temperature": 28.5
      }
    ],
  }.obs;

  @override
  void onInit() {
    super.onInit();
    getClassRooms();
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
    final response =
        await http.get(Uri.parse('http://10.0.2.2:5000/admin/SNSCT/'));

    if (response.statusCode == 200) {
      data.value['classRooms'] = jsonDecode(response.body);
      ready.value = true;
    } else {
      print(response.body);
    }
  }
}
