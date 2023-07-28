import 'package:berrypay_global_x/app/modules/login/controllers/login_controller.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  final FocusNode focusNode;
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black26))),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.lock,
            color: Colors.black87,
            size: 20,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Obx(
              () => TextField(
                focusNode: focusNode,
                textInputAction: TextInputAction.done,
                // onSubmitted: (term) {
                //   loginBloc.add(Authenticate(usernameController.text,
                //       passwordController.text));
                // },
                controller: controller.password,
                obscureText: controller.toggleEye.value,
                style: const TextStyle(color: Color(0xff444444)),
                decoration: InputDecoration(
                  hintText: LocaleKeys.login_page_pass_field_hint.tr,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              controller.toggleEye.value = !controller.toggleEye.value;
            },
            icon: Obx(
              () => controller.toggleEye.value
                  ? const Icon(
                      FontAwesomeIcons.solidEyeSlash,
                      size: 16,
                      color: Colors.black,
                    )
                  : const Icon(
                      FontAwesomeIcons.solidEye,
                      size: 18,
                      color: Colors.black,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
