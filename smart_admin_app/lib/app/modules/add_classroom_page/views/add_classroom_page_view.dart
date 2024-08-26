import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:smart_admin_app/app/modules/home/views/home_view.dart';

import '../controllers/add_classroom_page_controller.dart';

class AddClassroomPageView extends GetView<AddClassroomPageController> {
  const AddClassroomPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top + 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(profileUrl: controller.profileUrl),
              AddClassRoomPageHeader(),
              ClassRoomForm()
            ],
          ),
        ),
      ),
    );
  }
}

class AddClassRoomPageHeader extends StatelessWidget {
  const AddClassRoomPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: screenSize.width * 0.6,
      child: Text(
        'Add A\nClass Room',
        style: TextStyle(
          fontSize: screenSize.width * 0.075,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class ClassRoomForm extends GetWidget<AddClassroomPageController> {
  const ClassRoomForm({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: screenSize.width,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(7, (index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: List.generate(2, (classSelctionIndex) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ['Grade *', 'Section *'][classSelctionIndex],
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => TextField(
                                    enabled:
                                        classSelctionIndex == 0 ? false : null,
                                    onChanged: classSelctionIndex == 1
                                        ? (text) => controller.changeClassId()
                                        : null,
                                    maxLength:
                                        classSelctionIndex == 1 ? 5 : null,
                                    maxLengthEnforcement:
                                        classSelctionIndex == 1
                                            ? MaxLengthEnforcement
                                                .truncateAfterCompositionEnds
                                            : null,
                                    controller: [
                                      controller.gradeController.value,
                                      controller.classController.value
                                    ][classSelctionIndex],
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                        counterText: '',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))),
                                  ),
                                ),
                              ),
                              if (classSelctionIndex == 0)
                                Column(
                                  children: List.generate(2, (suffixIndex) {
                                    return Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.all(3),
                                        color: Colors.grey.shade200,
                                        child: InkResponse(
                                          onTap: () {
                                            if (suffixIndex == 0 &&
                                                (!(controller
                                                        .gradeCounter.value >=
                                                    12))) {
                                              controller.gradeCounter.value++;
                                              controller.gradeController.value
                                                      .text =
                                                  controller.romanNumerals[
                                                      controller
                                                          .gradeCounter.value]!;
                                              controller.changeClassId();
                                            }
                                            if (suffixIndex == 1 &&
                                                !(controller
                                                        .gradeCounter.value <=
                                                    1)) {
                                              controller.gradeCounter.value--;
                                              controller.gradeController.value
                                                      .text =
                                                  controller.romanNumerals[
                                                      controller
                                                          .gradeCounter.value]!;
                                              controller.changeClassId();
                                            }
                                          },
                                          child: Icon(
                                            [
                                              Icons.keyboard_arrow_up,
                                              Icons.keyboard_arrow_down
                                            ][suffixIndex],
                                            size: 18,
                                          ),
                                        ));
                                  }),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }

          if (index == 6) {
            return InkResponse(
              onTap: () => controller.createClassRoom(),
              child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  width: screenSize.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text('Create Class Room',
                      style: TextStyle(
                        fontSize: screenSize.width * 0.04,
                        color: Colors.white,
                      ))),
            );
          }

          if (index == 1) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class ID',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  Obx(
                    () => TextField(
                        controller: controller.classIDController.value,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            enabled: false,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))))),
                  )
                ],
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    [
                      null,
                      null,
                      'Mentor ID *',
                      'Smart Board ID',
                      'Noise Controller ID',
                      'Fire Sensor ID',
                      null
                    ][index]
                        .toString(),
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                TextField(
                    controller: [
                      null,
                      null,
                      controller.classMentorController,
                      controller.classSmartBoardIDController,
                      controller.classNoiseIDController,
                      controller.classFireIDController,
                      null
                    ][index],
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5))))),
              ],
            ),
          );
        }),
      ),
    );
  }
}
