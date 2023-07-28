import 'dart:io';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/remitx/member.dart';
import 'package:berrypay_global_x/app/data/repositories/auth_repo.dart';
import 'package:berrypay_global_x/app/data/repositories/remittance_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ManualKycController extends GetxController {
  final RemittanceRepo remittanceRepo;
  final AuthRepo authRepo;
  ManualKycController(this.remittanceRepo, this.authRepo);

  var selectedImagePath = ''.obs;
  var selectedIdFront = ''.obs;
  var selectedIdBack = ''.obs;
  RxBool isLoading = false.obs;
  var selectedImageSize = ''.obs;

  UploadDocumentResponse? uploadDocumentResponse;

  // var selectedImageSize = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      logger('selectedImagePath ${selectedImagePath.value}');
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 2024).toStringAsFixed(2)} Mb";

      logger(' selectedImageSize ${selectedImageSize.value}');

      // Get.toNamed(Routes.KYC_IMAGE,
      //     arguments: {'image': selectedImagePath.value});
    } else {
      AppSnackbar.errorSnackbar(title: 'No image selected');
    }
  }

  void getFrontId(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedIdFront.value = pickedFile.path;

      // Get.toNamed(Routes.KYC_IMAGE,
      //     arguments: {'image': selectedIdFront.value});

      // selectedImageSize.value =
      //     "${((File(selectedImagePath.value)).lengthSync() / 1024 / 2024).toStringAsFixed(2)} Mb";
    } else {
      AppSnackbar.errorSnackbar(title: 'No image selected');
    }
  }

  void getBackId(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedIdBack.value = pickedFile.path;

      // Get.toNamed(Routes.KYC_IMAGE, arguments: {'image': selectedIdBack.value});
      // selectedImageSize.value =
      // "${((File(selectedImagePath.value)).lengthSync() / 1024 / 2024).toStringAsFixed(2)} Mb";
    } else {
      AppSnackbar.errorSnackbar(title: 'No image selected');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
