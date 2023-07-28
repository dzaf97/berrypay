import 'package:berrypay_global_x/generated/locales.g.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contact_controller.dart';

class ContactMyView extends GetView<ContactMyController> {
  const ContactMyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(LocaleKeys.contact_us_page_contact.tr,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset("assets/images/contact.png",
                    width: 250, height: 250),
                Text(
                  LocaleKeys.contact_us_page_check_us_out_text.tr,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  LocaleKeys.contact_us_page_in_reach_text.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () async =>
                controller.launchContactUrl('mailto:servicedesk@berrypay.com'),
            leading:
                Image.asset("assets/icons/gmail.png", width: 25, height: 25),
            title: const Text("servicedesk@berrypay.com"),
          ),
          ListTile(
            onTap: () async =>
                controller.launchContactUrl('mailto:info@berrypay.com'),
            leading:
                Image.asset("assets/icons/gmail.png", width: 25, height: 25),
            title: const Text("info@berrypay.com"),
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.green,
            ),
            onTap: () async =>
                controller.launchContactUrl('tel:+6285883566917'),
            title: const Text("+62 858-8356-6917 (Indonesia)"),
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Colors.green,
            ),
            onTap: () async => controller.launchContactUrl('tel:+60386855179'),
            title: const Text("+603 8685 5179 (Malaysia)"),
          ),
          ListTile(
            title: const Text('BerryPay Global'),
            leading:
                Icon(Icons.facebook, size: 30, color: Colors.lightBlue[900]),
            onTap: () async => controller
                .launchContactUrl('https://www.facebook.com/BerryPayGlobal/'),
          ),
          ListTile(
            title: const Text('@berrypayoffical'),
            leading: Image.asset("assets/icons/instagram.png",
                width: 25, height: 25),
            onTap: () async => controller.launchContactUrl(
                'https://www.instagram.com/berrypayofficial/'),
          ),
          ListTile(
            title: const Text('https://berrypay.com/'),
            leading: const Icon(Icons.web, size: 30, color: Colors.grey),
            onTap: () async =>
                controller.launchContactUrl('https://berrypay.com/'),
          ),
        ],
      ),
    );
  }
}
