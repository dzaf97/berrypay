import 'package:azlistview/azlistview.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:get/get.dart';

class NationalityController extends GetxController {
  final RegisterRepo registerRepo;
  NationalityController(this.registerRepo);

  final RxString selectedNationality = "Malaysia".obs;
  final RxString selectedNationalityCode = "MYS".obs;
  final RxList<Country> nationality = <Country>[].obs;

  @override
  void onInit() async {
    super.onInit();
    nationality.value = await registerRepo.getCountry();

    SuspensionUtil.sortListBySuspensionTag(nationality);
    SuspensionUtil.setShowSuspensionStatus(nationality);
  }
}
