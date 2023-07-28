import 'dart:io';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/kyc_image_controller.dart';

class KycImageView extends GetView<KycImageController> {
  const KycImageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KycImageView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () => controller.selectedImagePath.value == ''
                ? Text('Please take your selfie')
                : Image.file(
                    File(controller.selectedImagePath.value),
                    // width: ,
                  ),
          ),
          // Image.file(
          //   File(controller.selectedImagePath.value),

          //   // width: ,

          // ),
          GestureDetector(
            onTap: () {
              logger('object');
              controller.getImage(ImageSource.camera);
            },
            child: Container(
              color: Colors.black12,
              padding: const EdgeInsets.all(8),
              // width: double.infinity,
              child: Obx(() => controller.selectedImagePath.value == ''
                  ? Text("Open Camera")
                  : Text("Retake photo")),
            ),
          ),
        ],
      ),
    );
  }
}
