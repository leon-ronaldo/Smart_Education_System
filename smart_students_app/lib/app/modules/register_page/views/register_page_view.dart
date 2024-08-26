import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        color: const Color(0xfff3f3f4),
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: screenSize.width,
                    height: screenSize.height * 0.7,
                    child: PageView(
                        controller: controller.pageController.value,
                        children: [RegisterPageHeroImage()])),
                RegisterPageNextButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterPageNextButtons extends StatelessWidget {
  const RegisterPageNextButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
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
      child: Text(
        'Get Started',
        style: TextStyle(fontSize: screenSize.width * 0.04),
      ),
    );
  }
}

class RegisterPageHeroImage extends GetWidget<RegisterPageController> {
  const RegisterPageHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          height: screenSize.height * 0.4,
          width: screenSize.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://cdn.dribbble.com/userupload/16074872/file/original-ac696b4f53280f57e83b7dbe9bda6911.png?resize=1200x900"),
                  fit: BoxFit.fitWidth)),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Your window into your immersive learning experience with technology.',
            style: TextStyle(fontSize: screenSize.width * 0.05),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Row(
              children: List.generate(
                  4,
                  (index) => Container(
                        color: Colors.blueAccent,
                        height: 2,
                        width: (controller.pageController.value.page ?? 0.0)
                                    .toInt() ==
                                index
                            ? screenSize.width * 0.1
                            : 2,
                      )),
            ),
          ),
        )
      ],
    );
  }
}
