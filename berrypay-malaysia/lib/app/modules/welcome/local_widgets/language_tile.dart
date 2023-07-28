import 'package:berrypay_global_x/app/data/model/locale_model.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    Key? key,
    required this.language,
  }) : super(key: key);

  final RxString language;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) => Wrap(
        children: <Widget>[
          ListTile(leading: Text(LocaleKeys.profile_page_select_lang_text.tr)),
          ListTile(
            title: const Text('Bahasa Indonesia'),
            onTap: () async {
              language.value = 'Bahasa Indonesia';

              Get.updateLocale(const Locale('id', 'ID'));
              Get.find<StorageProvider>().setLanguage(
                LocaleModel(language: 'id', countryCode: 'ID'),
              );

              Get.back();
            },
          ),
          ListTile(
            title: const Text('Bahasa Melayu'),
            onTap: () async {
              language.value = 'Bahasa Melayu';

              Get.updateLocale(const Locale('ms', 'MS'));
              Get.find<StorageProvider>().setLanguage(
                LocaleModel(language: 'ms', countryCode: 'MS'),
              );

              Get.back();
            },
          ),
          ListTile(
            title: const Text('English'),
            onTap: () async {
              language.value = 'English';

              Get.updateLocale(const Locale('en', 'US'));
              Get.find<StorageProvider>().setLanguage(
                LocaleModel(language: 'en', countryCode: 'US'),
              );

              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
