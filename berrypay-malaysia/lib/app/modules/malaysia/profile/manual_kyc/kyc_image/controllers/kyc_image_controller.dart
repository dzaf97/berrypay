import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/malaysia/profile/manual_kyc/controllers/manual_kyc_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class KycImageController extends GetxController {
  //TODO: Implement KycImageController

  ManualKycController? manualKycController;

  var selectedImagePath = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    selectedImagePath.value = Get.arguments['image'];
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;

      logger('selectedImagePath ${selectedImagePath.value}');
    } else {
      AppSnackbar.errorSnackbar(title: 'No image selected');
    }
  }
}
