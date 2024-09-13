import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:smart_admin_app/main.dart';

import '../controllers/class_room_page_controller.dart';

class ClassRoomPageView extends GetView<ClassRoomPageController> {
  const ClassRoomPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        color: Color(0xfffffdfc),
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 10),
        child: SingleChildScrollView(
          child: Obx(
            () => Visibility(
              visible: !controller.success.value,
              replacement: Container(
                  height: screenSize.height,
                  alignment: Alignment.center,
                  child: const Text('Success bro')),
              child: Visibility(
                replacement: SizedBox(
                    height: screenSize.height,
                    child: const Center(
                        child: SpinKitPouringHourGlassRefined(
                            color: Colors.blueAccent))),
                visible: controller.ready.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavBar(
                      profileUrl: controller.data['profileUrl'].toString(),
                    ),
                    ClassRoomPageHeroSection(),
                    ClassRoomPageStudentsSection()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  NavBar({super.key, required this.profileUrl});

  String profileUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
        margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Smart Education',
              style: TextStyle(fontSize: screenSize.width * 0.05),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profileUrl),
              backgroundColor: Colors.grey.shade200,
            )
          ],
        ));
  }
}

class ClassRoomPageHeroSection extends GetWidget<ClassRoomPageController> {
  const ClassRoomPageHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(bottom: 10, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenSize.width * 0.5,
            child: Text(
              controller.data['institutionName'].toString(),
              style: TextStyle(
                  fontSize: screenSize.width * 0.04,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: screenSize.width * 0.65,
            child: Text(
              'Class Room ${romanNumerals[controller.data['classGrade']]} ${controller.data['classSection']}',
              style: TextStyle(
                  fontSize: screenSize.width * 0.08,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ClassRoomPageStudentsSection extends StatefulWidget {
  const ClassRoomPageStudentsSection({super.key});

  @override
  State<ClassRoomPageStudentsSection> createState() => _ClassRoomPageStudentsSectionState();
}

class _ClassRoomPageStudentsSectionState extends State<ClassRoomPageStudentsSection> {
  final controller = Get.find<ClassRoomPageController>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: screenSize.width,
            child: Text(
              'Students',
              style: TextStyle(
                  fontSize: screenSize.width * 0.06,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.7,
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.studentsThatAppear.value.length,
                itemBuilder: 
                  (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '**${controller.studentsThatAppear.value[index]['studentID']} - ${controller.studentsThatAppear.value[index]['firstName']} ${controller.studentsThatAppear.value[index]['lastName']}',
                          style: TextStyle(
                              fontSize: screenSize.width * 0.04,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(onPressed: () {
                          controller.studentsThatAppear.value.removeAt(index);
                          setState(() {
                            
                          });
                        }, style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))), child: Text('Remove this student'))
                      ],
                    ),
                  
                ),
              ),
            ),
          ),
          InkResponse(
            onTap: () {
              controller.updateClass();
            },
            child: Container(
              width: screenSize.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15, bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Colors.blueAccent)),
              child: Text(
                'Confirm List',
                style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
