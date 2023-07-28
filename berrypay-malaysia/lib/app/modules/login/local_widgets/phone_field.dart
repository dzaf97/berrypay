import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    Key? key,
    required this.username,
    required this.selectedCode,
    required this.focusNode,
  }) : super(key: key);

  final FocusNode focusNode;
  final TextEditingController username;
  final RxString selectedCode;
  final List<DropdownMenuItem> countryCodes = const [
    DropdownMenuItem<String>(
      value: "+60",
      child: Text("+60"),
    ),
    DropdownMenuItem<String>(
      value: "+971",
      child: Text("+971"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26))),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.phone_android,
            color: Colors.black87,
            size: 20,
          ),
          const SizedBox(width: 16),
          Obx(
            () => DropdownButton(
              underline: Container(),
              elevation: 0,
              items: countryCodes,
              value: selectedCode.value,
              onChanged: (value) {
                selectedCode.value = value;
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: username,
              textInputAction: TextInputAction.next,
              focusNode: focusNode,
              // onSubmitted: (term) {
              //   FocusScope.of(context).unfocus();
              //   FocusScope.of(context).requestFocus(fnTwo);
              // },
              autofocus: false,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 17),
              decoration: InputDecoration(
                hintText: LocaleKeys.phoneNum_field_hint.tr,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
