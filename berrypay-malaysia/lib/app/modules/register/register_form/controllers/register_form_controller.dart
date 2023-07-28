import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_base.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/fasspay_enum.dart';
import 'package:berrypay_global_x/app/data/model/fasspay/profile/profile_model.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/snackbar.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/app/modules/register/register_form/views/register_form_view.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterFormController extends GetxController {
  final RegisterRepo registerRepo;
  RegisterFormController(this.registerRepo);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController docExpiryDate = TextEditingController();
  TextEditingController email = TextEditingController();

  Rx<IdType> id = IdType.NRIC.obs;
  Rx<IdentificationType> idType = IdentificationType.IdentificationTypeNRIC.obs;
  RxString selectedGender = 'Female'.obs;
  RxBool passwordIsClose = true.obs;
  RxBool cPasswordIsClose = true.obs;
  RxBool tnc = false.obs;
  RxBool isLoading = false.obs;
  RxString? selectedIdType = "".obs;
  RxString? selectedIdValue = "".obs;
  List<DataDocType>? dataDocType;
  DataOnboarding? data;
  String? phoneNo;
  CountryController countryController = Get.find();
  NationalityController nationalityController = Get.find();

  @override
  onInit() {
    super.onInit();

    data = Get.arguments["dataOnboarding"];

    phoneNo = Get.arguments['phone'];

    logger('phone no :: $phoneNo');

    getDocType("MYS");

    if (data != null) {
      var dateDob = DateFormat('yyyy-MM-dd').format(DateTime.parse(data!.dob!));

      if (selectedIdValue?.value != 'IC') {
        logger('ic ::');

        for (var doc in data!.document!) {
          if (doc.expiryDate != null) {
            var dateExpiry = DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(doc.expiryDate!));
            logger('dateExpiry $dateExpiry');
            docExpiryDate.text = dateExpiry;
          }
        }
      }

      logger('docExpiryDate.text ${docExpiryDate.text}');

      firstNameController.text = data!.firstName ?? '';
      lastNameController.text = data!.lastName ?? '';
      email.text = data!.email ?? '';
      selectedGender.value = data?.gender ?? 'Female';
      dob.text = dateDob;
      idNumber.text = data!.document?[0].identificationNo ?? '';

      Country nationality = countryController.countries
          .firstWhere((element) => element.cca3 == data!.nationality);

      nationalityController.selectedNationality.value =
          nationality.name!.common!;
      nationalityController.selectedNationalityCode.value = nationality.cca3!;

      Country country = countryController.countries
          .firstWhere((element) => element.cca3 == data!.nationality);

      countryController.selectedCountry.value = country.name!.official!;
      countryController.selectedCountryCode.value = country.cca3!;
      getDocType(nationality.cca3 ?? 'MYS');

      fullNameController = TextEditingController(
          text: '${firstNameController.text} ${lastNameController.text}');
    }

    nationalityController.selectedNationalityCode.listen((p0) {
      logger(p0);
      getDocType(p0);
    });

    firstNameController.addListener(updateText);
    lastNameController.addListener(updateText);
  }

  void updateText() {
    logger('updateText');
    // Combine the text from both individual controllers and set it to the combined controller
    fullNameController.text =
        '${firstNameController.text} ${lastNameController.text}';
  }

  getDocType(String country) async {
    isLoading(true);
    logger('get doctype start');
    logger('id type:: $country');
    var response = await registerRepo.getDocType(country);

    if (verifyResponse(response)) {
      isLoading(false);
      logger('cannot get');
    } else {
      response as GetDocType;
      dataDocType = response.data ?? [];

      logger('doctype ${jsonEncode(dataDocType)}');

      if (data?.isOnboarding == true) {
        logger('is onboarding');
        if (data?.nationality == country) {
          logger('ada ni');
          List<DataDocType> filter = [];

          for (var doc in data!.document!) {
            var filter2 = dataDocType!.firstWhere(
                (element) => element.id!.contains(doc.identificationType!));

            logger(jsonEncode(filter2));

            filter.add(filter2);
          }

          dataDocType = filter;
          logger(jsonEncode(filter));

          selectedIdType?.value = filter[0].id!;
          selectedIdValue?.value = filter[0].docType!;
          isLoading(false);
          return;
        }
        selectedIdType?.value = dataDocType![0].id!;
        selectedIdValue?.value = dataDocType![0].docType!;
        isLoading(false);
        return;
      }

      if (dataDocType!.isNotEmpty) {
        isLoading(false);
        selectedIdType?.value = dataDocType![0].id!;
        selectedIdValue?.value = dataDocType![0].docType!;
        return;
      }

      isLoading(false);
    }
  }

  register(RegisterBpgRequest registerRequest) async {
    isLoading(true);
    logger(jsonEncode(registerRequest));

    if (selectedIdValue?.value == 'IC') {
      idType = IdentificationType.IdentificationTypeNRIC.obs;
    } else if (selectedIdValue?.value == 'PASS') {
      idType.value = IdentificationType.IdentificationTypePassport;
    }

    var date = DateFormat('dd-MM-yyyy').format(DateTime.parse(dob.text));
    String nationalityCca2;

    // get nationality code (cc2)
    if (data != null) {
      Country nationality = nationalityController.nationality
          .firstWhere((element) => element.cca3 == data!.nationality);

      logger(jsonEncode(nationality));
      nationalityCca2 = nationality.cca2!;
    } else {
      Country nationality = nationalityController.nationality.firstWhere(
          (element) =>
              element.cca3 ==
              nationalityController.selectedNationalityCode.value);
      nationalityCca2 = nationality.cca2!;
    }

    // Register BPG account

    var response = await registerRepo.registerBpg(registerRequest);
    logger('re:: ${registerRequest.reregister}');

    if (verifyResponse(response)) {
      AppSnackbar.errorSnackbar(
          title: LocaleKeys.register_page_error_register.tr);
    } else {
      response as RegisterResponse;
      if (response.status == false) {
        isLoading(false);
        AppSnackbar.errorSnackbar(title: '${response.message}');
        return;
      }

      // Fasspay Request

      SSUserProfileVO ssUserProfileVO = SSUserProfileVO(
        fullName: fullNameController.text,
        nickName: usernameController.text.toLowerCase(),
        identificationNo: idNumber.text,
        identificationType: idType.value,
        nationalityCountryCode: nationalityCca2.toUpperCase(),
        mobileNo: '60$phoneNo',
        mobileNoCountryCode: "MY",
        email: response.data?.email,
        dateOfBirth: date,
      );

      logger(jsonEncode(ssUserProfileVO));

      // If success BPG account recreation, register Wallet Account

      FasspayBase responseFasspay =
          await registerRepo.registerFpContinue(ssUserProfileVO);
      if (!responseFasspay.isSuccess) {
        isLoading(false);

        // User create wallet from homepage after login

        logger(responseFasspay.errorMessage!);
      }

      Get.offNamedUntil(Routes.WELCOME, ModalRoute.withName(Routes.WELCOME),
          arguments: false);

      AppSnackbar.successSnackbar(
          title: LocaleKeys.register_page_success_register.tr);
    }

    logger(response.toJson());

    isLoading(false);
  }

  final Uri toLaunch = Uri.parse(
      'https://media.berrypay.xyz/artifacts/BerryPay%20Malaysia%20TnC.pdf');

  void launchMailClient() async {
    const mailUrl = 'mailto:servicedesk@berrypay.com';
    try {
      await launchUrl(Uri.parse(mailUrl));
    } catch (e) {
      await Clipboard.setData(
          const ClipboardData(text: 'servicedesk@berrypay.com'));
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
