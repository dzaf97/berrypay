import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/data/repositories/register_repo.dart';
import 'package:berrypay_global_x/app/global_widgets/app_button.dart';
import 'package:berrypay_global_x/app/global_widgets/loading_widget.dart';
import 'package:berrypay_global_x/app/global_widgets/widget_text_form_field.dart';
import 'package:berrypay_global_x/app/modules/nationality/controllers/nationality_controller.dart';
import 'package:berrypay_global_x/app/modules/register/controllers/country_controller.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_my_controller.dart';

class EditProfileMyView extends GetView<EditProfileMyController> {
  const EditProfileMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CountryController(RegisterRepo()));
    Get.put(NationalityController(RegisterRepo()));

    CountryController countryController = Get.find();
    NationalityController nationalityController = Get.find();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(LocaleKeys.edit_profile_page_edit_profile_text.tr,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: FormField(
            controller: controller,
            countryController: countryController,
            nationalityController: nationalityController,
          ),
        ),
        bottomNavigationBar: SubmitButton(
          controller: controller,
          countryController: countryController,
          nationalityController: nationalityController,
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.controller,
    required this.countryController,
    required this.nationalityController,
  }) : super(key: key);

  final EditProfileMyController controller;
  final CountryController countryController;
  final NationalityController nationalityController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading.value
              ? const BerryPayLoading()
              : AppButton.rounded(
                  title: 'Update',
                  onTap: () {
                    controller.updateProfile(
                      UpdateRequest(
                        fullName: controller.fullname.text,
                        phoneNo: Get.find<StorageProvider>()
                                .getProfileInfoResponse()
                                ?.mobile
                                .number ??
                            "",
                      ),
                    );

                    // if (controller.formKey.currentState!.validate()) {
                    //   controller.registerSender(SenderRegisterRequest(
                    //     userLoginId: controller.email.text,
                    //     senderFirstName: controller.firstName.text,
                    //     senderMiddleName: controller.middleName.text,
                    //     senderLastName: controller.lastName.text,
                    //     senderGender: controller.selectedGender.value,
                    //     senderAddress: controller.address1.text,
                    //     senderCity: controller.address2.text,
                    //     senderState: controller.address3.text,
                    //     senderZipCode: controller.poscode.text,
                    //     senderCountry: countryController.selectedCountry.value,
                    //     // senderCountry: 'MYS',
                    //     senderMobile: controller.phone.text,
                    //     senderNationality:
                    //         nationalityController.selectedNationalityCode.value,
                    //     // senderNationality: 'MYS',
                    //     senderIdType: controller.selectedCustomerType.value,
                    //     senderIdNumber: controller.id.text,
                    //     senderIdIssueCountry: '',
                    //     senderIdIssueDate: '',
                    //     senderIdExpireDate: '',
                    //     senderDateOfBirth: controller.dob.text,
                    //     senderOccupation: controller.selectedOccupation.value,
                    //     senderSourceOfFund: controller.selectedSourceFund.value,
                    //     senderCustomerType: 'I',
                    //     senderEmail: controller.email.text,
                    //     senderNativeFirstname: '',
                    //     senderNativeLastname: '',
                    //     senderBeneficiaryRelationship:
                    //         controller.selectedRelationship.value,
                    //     senderCompanyName: '',
                    //     senderCompanyRegNumber: '',
                    //     senderCompanyIncorporateDate: '',
                    //     username: controller.username,
                    //   ));
                  }),
        ));
  }
}

class FormField extends StatelessWidget {
  const FormField({
    Key? key,
    required this.controller,
    required this.countryController,
    required this.nationalityController,
  }) : super(key: key);
  final EditProfileMyController controller;
  final CountryController countryController;
  final NationalityController nationalityController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(75)),
              child: Text(controller.userProfile!.fullName[0],
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.edit_profile_page_fullname_text.tr,
              hintText: 'Enter name',
              iconData: Icons.person_outline,
              controller: controller.fullname,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return LocaleKeys.edit_profile_page_please_enter_fullname.tr;
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: TextFieldWidget(
              labelText: LocaleKeys.edit_profile_page_email.tr,
              hintText: 'Enter email',
              iconData: Icons.email_outlined,
              controller: controller.email,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return LocaleKeys.edit_profile_page_please_enter_email.tr;
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value)) {
                  return "Please enter valid email";
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
              //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //   color: Colors.grey.shade300,
              //   width: double.infinity,
              //   child: const Text(
              //     "Sender Information",
              //     style: TextStyle(fontSize: 15),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender First Name',
              //     hintText: 'Sender First Name',
              //     controller: controller.fullname,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter first name";
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     isRequired: false,
              //     labelText: 'Sender Middle Name',
              //     hintText: 'Sender Middle Name',
              //     controller: controller.middleName,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender Last Name',
              //     hintText: 'Sender Last Name',
              //     controller: controller.lastName,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter last name";
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Gender',
              //     hintText: 'Gender',
              //     controller: controller.gender,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: DropdownTextForm(
              //     controller: controller,
              //     title: 'Sender Gender',
              //     widget: DropdownButton(
              //       // Initial Value
              //       value: controller.selectedGender.value,
              //       underline: Container(),
              //       isExpanded: true,
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodySmall!
              //           .copyWith(color: Colors.grey),

              //       // Down Arrow Icon
              //       icon: const Icon(Icons.keyboard_arrow_down),

              //       items: const [
              //         //add items in the dropdown
              //         DropdownMenuItem(
              //           child: Text("Female"),
              //           value: "Female",
              //         ),
              //         DropdownMenuItem(
              //           child: Text("Male"),
              //           value: "Male",
              //         ),
              //       ],

              //       onChanged: (value) {
              //         //   //get value when changed
              //         controller.selectedGender.value = value!;
              //         logger("You have selected $value");
              //       },
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender Email',
              //     hintText: 'Sender email',
              //     controller: controller.email,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: DropdownTextForm(
              //     controller: controller,
              //     title: 'Sender ID Type',
              //     widget: Obx(
              //       () => controller.isLoading.value
              //           ? const Center(child: CircularProgressIndicator())
              //           : DropdownButton(
              //               // Initial Value
              //               value: controller.selectedCustomerType.value,
              //               underline: Container(),
              //               isExpanded: true,
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodySmall!
              //                   .copyWith(color: Colors.grey),

              //               // Down Arrow Icon
              //               icon: const Icon(Icons.keyboard_arrow_down),

              //               items: controller.customerDocTypeResponse
              //                   .map((e) => DropdownMenuItem(
              //                       value: e.Data,
              //                       child: Text('${e.Data} - ${e.Value}')))
              //                   .toList(),

              //               onChanged: (value) {
              //                 controller.selectedCustomerType.value = value!;
              //                 //   //get value when changed
              //                 logger("You have selected $value");
              //               },
              //             ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender ID',
              //     hintText: 'Sender ID',
              //     controller: controller.id,
              //     suffixIcon: const Tooltip(
              //       message:
              //           "Identification of the sender (e.g. NRIC, passport number), alphanumeric only (eg. 801010012222) and no special characters ('-', '/', blank space)",
              //       waitDuration: Duration(seconds: 1),
              //       showDuration: Duration(seconds: 2),
              //       padding: EdgeInsets.all(5),
              //       margin: EdgeInsets.all(5),
              //       height: 35,
              //       textStyle: TextStyle(
              //           fontSize: 15,
              //           color: Colors.white,
              //           fontWeight: FontWeight.normal),
              //       child: Icon(Icons.info),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     controller: controller.dob,
              //     labelText: 'Date of Birth',
              //     hintText: 'xx-xx-xxxx',
              //     iconData: Icons.calendar_month,
              //     ontap: () async {
              //       FocusScope.of(context).requestFocus(FocusNode());
              //       DateTime dateDob = DateTime.now();

              //       logger(dateDob);

              //       DateTime? date = (await showDatePicker(
              //           context: context,
              //           initialDate: dateDob,
              //           firstDate: DateTime(1900),
              //           lastDate: DateTime(2100)));

              //       if (date != null) {
              //         controller.dob.text = date.toIso8601String().split("T")[0];
              //         logger(controller.dob.text);
              //       }
              //     },
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter date of birth";
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: GestureDetector(
              //     onTap: () {
              //       Get.to(() => const NationalityView());
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       padding: const EdgeInsets.only(
              //           top: 20, bottom: 10, left: 20, right: 20),
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: const BorderRadius.all(Radius.circular(10)),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.grey.shade200,
              //                 blurRadius: 10,
              //                 offset: const Offset(0, 5)),
              //           ],
              //           border: Border.all(
              //               color: Colors.grey.shade200.withOpacity(0.05))),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.stretch,
              //         children: [
              //           Row(
              //             children: [
              //               Text(
              //                 'Nationality',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .titleLarge!
              //                     .copyWith(fontSize: 15),
              //                 textAlign: TextAlign.start,
              //               ),
              //               const SizedBox(
              //                 width: 5,
              //               ),
              //               Text(
              //                 '*',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .titleLarge!
              //                     .copyWith(color: Colors.red),
              //                 textAlign: TextAlign.start,
              //               )
              //             ],
              //           ),
              //           const SizedBox(height: 10),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               // Obx(
              //               //   () => Text(
              //               //     // 'test',
              //               //     nationalityController.nationality
              //               //         .where((p0) =>
              //               //             p0.cca2 ==
              //               //             nationalityController
              //               //                 .selectedNationality.value)
              //               //         .first
              //               //         .flag!,
              //               //     style: const TextStyle(fontSize: 24),
              //               //   ),
              //               // ),
              //               // const SizedBox(width: 20),
              //               Obx(
              //                 () => Text(
              //                   nationalityController.selectedNationality.value,
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodySmall!
              //                       .copyWith(color: Colors.grey),
              //                 ),
              //               ),

              //               const Icon(Icons.keyboard_arrow_down),
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender Address',
              //     hintText: 'Sender Address',
              //     controller: controller.address1,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter address";
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender City',
              //     hintText: 'Sender City',
              //     controller: controller.address2,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter city";
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender State',
              //     hintText: 'Sender State',
              //     controller: controller.address3,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter state";
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: GestureDetector(
              //     onTap: () {
              //       Get.to(() => const CountryView());
              //     },
              //     child: Container(
              //       width: double.infinity,
              //       padding: const EdgeInsets.only(
              //           top: 20, bottom: 10, left: 20, right: 20),
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: const BorderRadius.all(Radius.circular(10)),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.grey.shade200,
              //                 blurRadius: 10,
              //                 offset: const Offset(0, 5)),
              //           ],
              //           border: Border.all(
              //               color: Colors.grey.shade200.withOpacity(0.05))),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.stretch,
              //         children: [
              //           Row(
              //             children: [
              //               Text(
              //                 'Country',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .titleLarge!
              //                     .copyWith(fontSize: 15),
              //                 textAlign: TextAlign.start,
              //               ),
              //               const SizedBox(
              //                 width: 5,
              //               ),
              //               Text(
              //                 '*',
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .titleLarge!
              //                     .copyWith(color: Colors.red),
              //                 textAlign: TextAlign.start,
              //               )
              //             ],
              //           ),
              //           const SizedBox(height: 10),
              //           Row(
              //             children: [
              //               Obx(
              //                 () => Text(
              //                   // 'test',
              //                   countryController.countries
              //                       .where((p0) =>
              //                           p0.cca2 ==
              //                           countryController.selectedCountryCode.value)
              //                       .first
              //                       .flag!,
              //                   style: const TextStyle(fontSize: 24),
              //                 ),
              //               ),
              //               const SizedBox(width: 20),
              //               Obx(
              //                 () => Text(
              //                   countryController.selectedCountry.value,
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodySmall!
              //                       .copyWith(color: Colors.grey),
              //                 ),
              //               )
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender Poscode',
              //     hintText: 'Sender Poscode',
              //     controller: controller.poscode,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter posscode";
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: DropdownTextForm(
              //     controller: controller,
              //     title: 'Sender Occupation',
              //     widget: Obx(
              //       () => controller.isLoading.value
              //           ? const Center(child: CircularProgressIndicator())
              //           : DropdownButton(
              //               // Initial Value
              //               value: controller.selectedOccupation.value,
              //               underline: Container(),
              //               isExpanded: true,
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodySmall!
              //                   .copyWith(color: Colors.grey),

              //               // Down Arrow Icon
              //               icon: const Icon(Icons.keyboard_arrow_down),

              //               items: controller.occupationResponse
              //                   .map((e) => DropdownMenuItem(
              //                       value: e.Data,
              //                       child: Text('${e.Data} - ${e.Value}')))
              //                   .toList(),

              //               onChanged: (value) {
              //                 //   //get value when changed
              //                 controller.selectedOccupation.value = value!;
              //                 logger("You have selected $value");
              //               },
              //             ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: TextFieldWidget(
              //     labelText: 'Sender Phone Number',
              //     hintText: 'Sender Phone Number',
              //     controller: controller.phone,
              //     enabled: false,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return "Please enter phone number";
              //       }
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: DropdownTextForm(
              //     controller: controller,
              //     title: 'Beneficiary Relationship',
              //     widget: Obx(
              //       () => controller.isLoading.value
              //           ? const Center(child: CircularProgressIndicator())
              //           : DropdownButton(
              //               // Initial Value
              //               value: controller.selectedRelationship.value,
              //               underline: Container(),
              //               isExpanded: true,
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodySmall!
              //                   .copyWith(color: Colors.grey),

              //               // Down Arrow Icon
              //               icon: const Icon(Icons.keyboard_arrow_down),

              //               items: controller.relationshipResponse
              //                   .map((e) => DropdownMenuItem(
              //                       value: e.Data,
              //                       child: Text('${e.Data} - ${e.Value}')))
              //                   .toList(),

              //               onChanged: (value) {
              //                 controller.selectedRelationship.value = value!;
              //                 //   //get value when changed
              //                 logger("You have selected $value");
              //               },
              //             ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              //   child: DropdownTextForm(
              //     controller: controller,
              //     title: 'Sender Source of Funds',
              //     widget: Obx(
              //       () => controller.isLoading.value
              //           ? const Center(child: CircularProgressIndicator())
              //           : DropdownButton(
              //               // Initial Value
              //               value: controller.selectedSourceFund.value,
              //               underline: Container(),
              //               isExpanded: true,
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodySmall!
              //                   .copyWith(color: Colors.grey),

              //               // Down Arrow Icon
              //               icon: const Icon(Icons.keyboard_arrow_down),

              //               items: controller.sourceOfFund
              //                   .map((e) => DropdownMenuItem(
              //                       value: e.Data,
              //                       child: Text('${e.Data} - ${e.Value}')))
              //                   .toList(),

              //               onChanged: (value) {
              //                 //   //get value when changed
              //                 controller.selectedSourceFund.value = value!;
              //               },
              //             ),
              //     ),
              //   ),
              ),
        ],
      ),
    );
  }
}

 // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.only(
          //       top: 20, bottom: 10, left: 20, right: 20),
          //   decoration: BoxDecoration(
          //       color: AppColor.white,
          //       borderRadius: const BorderRadius.all(Radius.circular(10)),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey.shade200,
          //             blurRadius: 10,
          //             offset: const Offset(0, 5)),
          //       ],
          //       border: Border.all(
          //           color: Colors.grey.shade200.withOpacity(0.05))),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Row(
          //         children: [
          //           Text(
          //             LocaleKeys.edit_profile_page_gender_text.tr,
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline6!
          //                 .copyWith(fontSize: 15),
          //             textAlign: TextAlign.start,
          //           ),
          //           const SizedBox(
          //             width: 5,
          //           ),
          //           Text(
          //             '*',
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .headline6!
          //                 .copyWith(color: Colors.red),
          //             textAlign: TextAlign.start,
          //           )
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 5,
          //       ),
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Expanded(
          //               child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Radio<String>(
          //                 value: "M",
          //                 groupValue: "gender",
          //                 onChanged: (value) {},
          //                 activeColor: const Color(0xFFF12B2A),
          //                 materialTapTargetSize:
          //                     MaterialTapTargetSize.shrinkWrap,
          //               ),
          //               Text(LocaleKeys.edit_profile_page_male_gender.tr)
          //             ],
          //           )),
          //           Expanded(
          //               child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: <Widget>[
          //               Radio<String>(
          //                 activeColor: const Color(0xFFF12B2A),
          //                 value: "F",
          //                 groupValue: "gender",
          //                 onChanged: (value) {},
          //                 materialTapTargetSize:
          //                     MaterialTapTargetSize.shrinkWrap,
          //               ),
          //               Text(LocaleKeys.edit_profile_page_female_gender.tr)
          //             ],
          //           )),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // TextFieldWidget(
          //   labelText: LocaleKeys.edit_profile_page_dob_text.tr,
          //   hintText: 'Select date of birth',
          //   iconData: Icons.date_range,
          //   controller: controller.dob,
          //   ontap: () async {
          //     FocusScope.of(context).requestFocus(FocusNode());

          //     DateTime date1 =
          //         controller.profileInfoResponse!.wallet.my != null
          //             ? DateFormat("dd-MM-yyyy").parse(controller.dob.text)
          //             : DateTime.now();

          //     // logger(' : $date1');

          //     DateTime? date = (await showDatePicker(
          //         context: context,
          //         // initialDate: DateTime.now(),
          //         initialDate: date1,
          //         firstDate: DateTime(1900),
          //         lastDate: DateTime(2100)));

          //     if (date != null) {
          //       controller.dob.text = date.toIso8601String().split("T")[0];
          //       logger(controller.dob.text);
          //     }
          //   },
          // ),
          // const SizedBox(
          //   height: 15,
          // ),