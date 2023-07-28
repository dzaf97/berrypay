import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMyController extends GetxController {
  void launchAboutUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
