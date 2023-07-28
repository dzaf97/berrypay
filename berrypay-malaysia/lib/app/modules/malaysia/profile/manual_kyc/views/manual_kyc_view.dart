import 'dart:io';
import 'dart:math';

import 'package:berrypay_global_x/app/core/theme/theme.dart';
import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../controllers/manual_kyc_controller.dart';

class ManualKycView extends GetView<ManualKycController> {
  const ManualKycView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text(
            '',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'UPLOAD IDENTIFICATION',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                    'We need to confirm your identification with a formal identification'),
                const SizedBox(
                  height: 20,
                ),
                BoxMenuKYC(
                  file: Obx(
                    () => controller.selectedImagePath.value == ''
                        ? const SizedBox()
                        : DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 10],
                            color: Colors.grey,
                            strokeWidth: 1,
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(controller.selectedImagePath.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // child: Image.file(
                            //   File(controller.selectedImagePath.value),
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                  ),
                  step: 'Step 1',
                  title: 'Selfie',
                  subtitle: 'Take your selfie',
                  image: 'assets/images/face.png',
                  onTap: () {
                    controller.getImage(ImageSource.camera);
                    // controller.selectedImagePath.value == ''
                    //     ? controller.getImage(ImageSource.camera)
                    //     : Get.toNamed(Routes.KYC_IMAGE, arguments: {
                    //         'image': controller.selectedImagePath.value
                    //       });
                  },
                  controller: controller,
                ),
                const SizedBox(
                  height: 15,
                ),
                BoxMenuKYC(
                  file: Obx(
                    () => controller.selectedIdFront.value == ''
                        ? const SizedBox()
                        : DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 10],
                            color: Colors.grey,
                            strokeWidth: 1,
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(controller.selectedIdFront.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                  step: 'Step 2',
                  title: 'Front ID',
                  subtitle: 'Take a photo of front of IC.',
                  image: 'assets/images/card.png',
                  onTap: () {
                    controller.selectedIdFront.value == ''
                        ? controller.getFrontId(ImageSource.camera)
                        : Get.toNamed(Routes.KYC_IMAGE, arguments: {
                            'image': controller.selectedIdFront.value
                          });
                  },
                  controller: controller,
                ),
                const SizedBox(
                  height: 15,
                ),
                BoxMenuKYC(
                  file: Obx(
                    () => controller.selectedIdBack.value == ''
                        ? const SizedBox()
                        : DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),
                            dashPattern: [10, 10],
                            color: Colors.grey,
                            strokeWidth: 1,
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(controller.selectedIdBack.value),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                  step: 'Step 3',
                  title: 'Back ID',
                  subtitle: 'Take a photo of back of IC.',
                  image: 'assets/images/card.png',
                  onTap: () {
                    controller.selectedIdBack.value == ''
                        ? controller.getBackId(ImageSource.camera)
                        : Get.toNamed(Routes.KYC_IMAGE, arguments: {
                            'image': controller.selectedIdBack.value
                          });
                  },
                  controller: controller,
                ),
                // ExpansionTile(
                //   title: Text("SELFIE"), //header title
                //   children: [
                //     Column(
                //       children: [
                //         Obx(
                //           () => controller.selectedImagePath.value == ''
                //               ? Text('Please take your selfie')
                //               : Image.file(
                //                   File(controller.selectedImagePath.value),
                //                   // width: ,
                //                 ),
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             controller.getImage(ImageSource.camera);
                //           },
                //           child: Container(
                //             color: Colors.black12,
                //             padding: const EdgeInsets.all(8),
                //             // width: double.infinity,
                //             child: Obx(() =>
                //                 controller.selectedImagePath.value == ''
                //                     ? Text("Open Camera")
                //                     : Text("Retake photo")),
                //           ),
                //         ),
                //         const SizedBox(
                //           height: 20,
                //         ),
                //       ],
                //     )
                //   ],
                // ),
                // ExpansionTile(
                //   title: Text("FRONT IDENTITY CARD"), //header title
                //   children: [
                //     Obx(
                //       () => controller.selectedIdFront.value == ''
                //           ? Text('Please take your front ID document')
                //           : Image.file(
                //               File(controller.selectedIdFront.value),
                //               // width: ,
                //             ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         controller.getFrontId(ImageSource.camera);
                //       },
                //       child: Container(
                //         color: Colors.black12,
                //         padding: EdgeInsets.all(8),
                //         child: Obx(() => controller.selectedIdFront.value == ''
                //             ? Text("Open Camera")
                //             : Text("Retake photo")),
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //   ],
                // ),
                // ExpansionTile(
                //   title: Text("BACK IDENTITY CARD"), //header title
                //   children: [
                //     Obx(
                //       () => controller.selectedIdBack.value == ''
                //           ? Text('Please take your back ID document')
                //           : Image.file(
                //               File(controller.selectedIdBack.value),
                //               // width: ,
                //             ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         controller.getBackId(ImageSource.camera);
                //       },
                //       child: Container(
                //         color: Colors.black12,
                //         padding: EdgeInsets.all(8),
                //         child: Obx(() => controller.selectedIdBack.value == ''
                //             ? Text("Open Camera")
                //             : Text("Retake photo")),
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 10,
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => controller.isLoading.value
              ? const BerryPayLoading()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton.rectangle(onTap: () {
                    // controller.uploadDocument();
                  }),
                ),
        ));
  }
}

class VerifyKYC extends GetView<ManualKycController> {
  const VerifyKYC({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const WithPages(
        // body: WithPages(),

        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   iconTheme:
        //       const IconThemeData(color: Color.fromARGB(255, 227, 179, 179)),
        //   elevation: 0,
        // ),
        // body: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Verify your account',
        //         style: Theme.of(context)
        //             .textTheme
        //             .headlineSmall!
        //             .copyWith(fontWeight: FontWeight.w500),
        //       ),
        //       const SizedBox(
        //         height: 20,
        //       ),
        //       Text(
        //         'We respect your privacy, we will not disclose this information. This is for remittance purpose.',
        //         textAlign: TextAlign.center,
        //         style: Theme.of(context).textTheme.bodySmall,
        //       ),
        //       const SizedBox(
        //         height: 30,
        //       ),
        //       Image.asset(
        //         'assets/icons/scan.png',
        //         width: 110,
        //       )
        //     ],
        //   ),
        // ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: AppButton.rectangle(
        //     title: 'Next',
        //     onTap: () {
        //       Get.to(() => const ManualKycView());
        //     },
        //   ),
        // ),
        );
  }
}

///Example of App with LiquidSwipe by providing list of widgets
class WithPages extends StatefulWidget {
  const WithPages({super.key});

  @override
  _WithPages createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  int page = 0;
  LiquidController? liquidController;
  UpdateType? updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    Container(
      // color: const Color(0xFF911F27),
      color: const Color(0xFF630606),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/passport-1.png',
            width: 250,
          ),
          Column(
            children: const [
              Text(
                "Get ID Document ready",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Before you start, make sure your passport/ID is with you. You will need to scan it during the process",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: const Color(0xFF890F0D),
      // color: const Color(0xFFA64B2A),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/selfie.png',
            width: 250,
          ),
          Column(
            children: const [
              Text(
                "Take a Selfie",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Your face has to be well lit. Make sure you don\'t have any background lights",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    Container(
      color: const Color(0xFFA64B2A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            'assets/images/id-card.png',
            width: 250,
          ),
          Column(
            children: const [
              Text(
                "Scan your ID Document",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Please make sure that all information is within the borders of the scanner",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColor.white),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ];

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              enableLoop: false,
              pages: pages,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              enableSideReveal: true,
              ignoreUserGestureWhileAnimating: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(pages.length, _buildDot),
                  ),
                ],
              ),
            ),
            page == 2
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.MANUAL_KYC);

                          // Get.to(() => CameraPage());

                          // Get.to(ManualKycView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color(0xFFF2D388), // This is what you need!
                        ),
                        child: const Text(
                          "GET STARTED",
                          style: TextStyle(color: AppColor.black),
                        ),
                      ),
                    ))
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.MANUAL_KYC);
                              // Get.to(ManualKycView());

                              // liquidController!
                              //     .animateToPage(page: pages.length - 1, duration: 700);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFF2D388), // This is what you need!
                            ),
                            child: const Text(
                              "Skip",
                              style: TextStyle(color: AppColor.black),
                            ),

                            // color: Colors.white.withOpacity(0.01),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: ElevatedButton(
                            onPressed: () {
                              liquidController!.jumpToPage(
                                  page: liquidController!.currentPage + 1 >
                                          pages.length - 1
                                      ? 0
                                      : liquidController!.currentPage + 1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                  0xFFF2D388), // This is what you need!
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: AppColor.black),
                            ),

                            // color: Colors.white.withOpacity(0.01),
                          ),
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
      logger('page $page');
    });
  }
}

class BoxMenuKYC extends StatelessWidget {
  const BoxMenuKYC({
    Key? key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.image,
    this.onTap,
    required this.controller,
    required this.file,
  }) : super(key: key);

  final String step;
  final String title;
  final String subtitle;
  final String image;
  final Function()? onTap;
  final ManualKycController controller;
  final Widget file;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    image,
                    width: 90,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
                  ),
                ],
              )
            ],
          ),
          file
        ],
      ),
    );
  }
}
