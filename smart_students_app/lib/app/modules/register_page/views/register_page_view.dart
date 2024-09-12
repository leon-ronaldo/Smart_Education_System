import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:smart_students_app/main.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
          color: const Color(0xfff3f3f4),
          child: Obx(
            () => PopScope(
              canPop: controller.canPop.value,
                    onPopInvokedWithResult: (didPop, result) {
            controller.currentPage.value == 0 ? Get.back() : controller.pageController.value.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                    },
                    child: SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Obx(
                  () => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 500),
                    crossFadeState: controller.loading.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: Center(
                      child: SpinKitCubeGrid(color: Colors.blueAccent,),
                    ),
                    secondChild: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 500),
                      crossFadeState: controller.success.value
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      secondChild: Container(
                        color: const Color(0xffffffff),
                        height: screenSize.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: screenSize.height * 0.25,
                                width: screenSize.width,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/success.pnh'),
                                        fit: BoxFit.fitWidth))),
                            Text('Hello ${controller.firstNameController.text}',
                                style: TextStyle(
                                    height: 2,
                                    fontSize: screenSize.width * 0.045,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  'Explore Our App And Experience The Best Learning Ever...',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: screenSize.width * 0.035,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      firstChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: screenSize.width,
                              height: screenSize.height * 0.7,
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                  controller: controller.pageController.value,
                                  children: [
                                    RegisterPageHeroImage(),
                                    RegisterPageStudentGeneralDetailsSection(),
                                    RegisterPagePersonalDetailsSection(),
                                    RegisterPageClassAndPhotoDetailsSection()
                                  ])),
                          RegisterPageNextButtons()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
                    ),
          ),
      ),
    );
  }
}

class RegisterPageNextButtons extends GetWidget<RegisterPageController> {
  const RegisterPageNextButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: screenSize.height * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: index == controller.currentPage.value
                      ? screenSize.width * 0.1
                      : 3,
                  height: 3,
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(5000))),
                ),
              );
            }),
          ),
        ),
        Obx(
          () => InkResponse(
            onTap: controller.currentPage.value == 3
                ? () {
                      for(var path in [controller.firstfilePath, controller.secondfilePath]) {
                        if (path.value == "") {
                          Get.snackbar('Warning', 'Add both photos', duration: const Duration(milliseconds: 1500));
                          return;
                        }
                    }
                    
                    controller.register();
                  }
                : () {
                    if (controller.currentPage.value == 1) {
                      for(var editor in [controller.firstNameController, controller.lastNameController, controller.studentIDController, controller.ageController, controller.bDayController, controller.classRoomController]) {
                        if (editor.text.isEmpty) {
                          Get.snackbar('Warning', 'Some fields are missing', duration: const Duration(milliseconds: 1500));
                          return;
                        }
                      }
                    }
                    if (controller.currentPage.value == 2) {
                      for(var editor in [controller.phoneController, controller.genderController, controller.emailController, controller.addressController]) {
                        if (editor.text.isEmpty) {
                          Get.snackbar('Warning', 'Some fields are missing', duration: const Duration(milliseconds: 1500));
                          return;
                        }
                      }
                    }
                    
                    controller.pageController.value.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                            offset: const Offset(0, 4),
                            color: Colors.grey.shade200,
                            blurRadius: 3)
                        .scale(3)
                  ]),
              child: Obx(
                () => Text(
                  controller.currentPage.value == 0
                      ? 'Get Started'
                      : controller.currentPage.value == 3
                          ? 'Submit'
                          : 'Next',
                  style: TextStyle(fontSize: screenSize.width * 0.04),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: controller.currentPage.value == 0 ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Text(
                    'Already Have An Account?',
                    style: TextStyle(fontSize: screenSize.width * 0.03),
                  ),
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: screenSize.width * 0.03,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blueAccent),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RegisterPageHeroImage extends GetWidget<RegisterPageController> {
  const RegisterPageHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: screenSize.height * 0.3,
          width: screenSize.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/hero.png"),
                  fit: BoxFit.fitWidth)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your window into your immersive learning experience with technology.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.width * 0.05),
          ),
        ),
      ],
    );
  }
}

class RegisterPageStudentGeneralDetailsSection
    extends GetWidget<RegisterPageController> {
  const RegisterPageStudentGeneralDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(6, (index) {
          if (index == 5) {
            return Container(
              margin: const EdgeInsets.only(top: 5),
              width: screenSize.width,
              alignment: Alignment.center,
              child: Text(
                'Fill Up Your General Details',
                style: TextStyle(fontSize: screenSize.width * 0.04),
              ),
            );
          }

          if (index == 4) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class',
                      style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  TextField(
                      onChanged: (text) =>
                          controller.filterClassRooms(text.toLowerCase()),
                      controller: controller.classRoomController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))))),
                  Container(
                    height: screenSize.height * 0.11,
                    width: screenSize.width,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SingleChildScrollView(
                        child: Obx(
                      () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              controller.classRoomsThatAppear.length, (index) {
                            return InkResponse(
                              onTap: () {
                                controller.classRoomController.text =
                                    '${controller.classRoomsThatAppear.value[index]['collegeCode']} ${romanNumerals[controller.classRoomsThatAppear.value[index]['grade']]} ${controller.classRoomsThatAppear.value[index]['section']}';
                                controller.selectedClassCode.value = controller
                                    .classRoomsThatAppear
                                    .value[index]['classRoomID'];
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                    '${controller.classRoomsThatAppear.value[index]['collegeCode']} ${romanNumerals[controller.classRoomsThatAppear.value[index]['grade']]} ${controller.classRoomsThatAppear.value[index]['section']}',
                                    style: TextStyle(
                                        fontSize: screenSize.width * 0.035,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold)),
                              ),
                            );
                          })),
                    )),
                  )
                ],
              ),
            );
          }

          if (index == 2) {
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
                            ['Register Number', 'Age'][classSelctionIndex],
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLength: classSelctionIndex == 1 ? 5 : null,
                                  controller: [
                                    controller.studentIDController,
                                    controller.ageController
                                  ][classSelctionIndex],
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      counterText: '',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))),
                                ),
                              ),
                              if (classSelctionIndex == 1)
                                Column(
                                  children: List.generate(2, (suffixIndex) {
                                    return Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.all(3),
                                        color: Colors.grey.shade200,
                                        child: InkResponse(
                                          onTap: () {
                                            int age = int.parse(
                                                controller.ageController.text);
                                            if (suffixIndex == 0 &&
                                                (!(age >= 27))) {
                                              controller.ageController.text =
                                                  '${age + 1}';
                                            }
                                            if (suffixIndex == 1 &&
                                                !(age <= 16)) {
                                              controller.ageController.text =
                                                  '${age - 1}';
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

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    [
                      'First Name',
                      'Last Name',
                      null,
                      'Date Of Birth',
                      'Class',
                      null
                    ][index]
                        .toString(),
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                TextField(
                    controller: [
                      controller.firstNameController,
                      controller.lastNameController,
                      null,
                      controller.bDayController,
                      controller.classRoomController,
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

class RegisterPagePersonalDetailsSection
    extends GetWidget<RegisterPageController> {
  const RegisterPagePersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: List.generate(5, (index) {
          if (index == 0) {
            return Container(
              height: screenSize.height * 0.28,
              width: screenSize.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/hero2.png"),
                      fit: BoxFit.fitWidth)),
            );
          }

          if (index == 1) {
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
                            ['Phone', 'Gender'][classSelctionIndex],
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  maxLength: classSelctionIndex == 1 ? 6 : null,
                                  controller: [
                                    controller.phoneController,
                                    controller.genderController
                                  ][classSelctionIndex],
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      counterText: '',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)))),
                                ),
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

          if (index == 4) {
            return Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.center,
                width: screenSize.width,
                child: Text(
                  'Fill Up Your Personal Details',
                  style: TextStyle(fontSize: screenSize.width * 0.04),
                ));
          }

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text([null, null, 'Email', 'Address', null][index].toString(),
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold)),
                TextField(
                    controller: [
                      null,
                      null,
                      controller.emailController,
                      controller.addressController,
                      null
                    ][index],
                    maxLines: index == 3 ? 3 : null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            left: 10, top: index == 3 ? 15 : 0.0),
                        border: const OutlineInputBorder(
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

class RegisterPageClassAndPhotoDetailsSection
    extends GetWidget<RegisterPageController> {
  const RegisterPageClassAndPhotoDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: screenSize.height * 0.26,
                  height: screenSize.height * 0.26,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/frame.png'),
                          fit: BoxFit.fitHeight)),
                ),
                Obx(
                  () => Visibility(
                    replacement: InkResponse(
                        onTap: () {
                          controller
                              .pickFileFromGallery(controller.firstfilePath);
                        },
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 20)),
                    visible:
                        controller.firstfilePath.value == "" ? false : true,
                    child: InkResponse(
                      onTap: () => controller
                          .pickFileFromGallery(controller.firstfilePath),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15, left: 2),
                        height: screenSize.height * 0.18,
                        width: screenSize.height * 0.2,
                        child: Image.file(File(controller.firstfilePath.value),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: screenSize.height * 0.26,
                  height: screenSize.height * 0.26,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/frame.png'),
                          fit: BoxFit.fitHeight)),
                ),
                Obx(
                  () => Visibility(
                    replacement: InkResponse(
                        onTap: () {
                          controller
                              .pickFileFromGallery(controller.secondfilePath);
                        },
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 20)),
                    visible:
                        controller.secondfilePath.value == "" ? false : true,
                    child: InkResponse(
                      onTap: () => controller
                          .pickFileFromGallery(controller.secondfilePath),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15, left: 2),
                        height: screenSize.height * 0.18,
                        width: screenSize.height * 0.2,
                        child: Image.file(File(controller.secondfilePath.value),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          width: screenSize.width,
          child: Text(
            'Upload Your Images',
            style: TextStyle(fontSize: screenSize.width * 0.04),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: screenSize.width,
          child: Text(
            'It is recommended to uploaded a clearer image of yourself (like a passport photo)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenSize.width * 0.032),
          ),
        ),
      ],
    );
  }
}
