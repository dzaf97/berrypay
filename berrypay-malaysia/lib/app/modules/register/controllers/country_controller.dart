import 'package:azlistview/azlistview.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:get/get.dart';

class CountryController extends GetxController {
  final RegisterRepo registerRepo;
  CountryController(this.registerRepo);

  final RxString selectedCountry = "Malaysia".obs;
  final RxString selectedCountryCode = "MYS".obs;
  final RxList<Country> countries = <Country>[].obs;

  @override
  void onInit() async {
    super.onInit();
    countries.value = await registerRepo.getCountry();
    SuspensionUtil.sortListBySuspensionTag(countries);
    SuspensionUtil.setShowSuspensionStatus(countries);
  }
}
