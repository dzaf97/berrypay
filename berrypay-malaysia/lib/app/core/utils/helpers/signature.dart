import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GenerateSignature {
  String generateSignature(Map<String, dynamic> requestBody) {
    Base64Codec base64 = const Base64Codec();

    var raw = json.decode(utf8.decode(base64.decode(base64
        .normalize(Get.find<StorageProvider>().getToken()!.split(".")[1]))));

    // Define your secret key
    String secretKey = raw["secret_key"];

    logger(secretKey);
    // logger('secret_key $secretKey');
    requestBody.remove("signature");

    // Separate the values of the request body by "|"
    String separatedValues = requestBody.values
        .map((value) =>
            (value.runtimeType == String) ? value : jsonEncode(value))
        .join('|');

    log('separatedValues $separatedValues');

    var key = utf8.encode(secretKey);
    var bytes = utf8.encode(separatedValues);
    var hmacSha512 = Hmac(sha512, key);
    var digest = hmacSha512.convert(bytes);
    var encodedBytes = Uint8List.fromList(digest.bytes);
    var base64String = base64.encode(encodedBytes);

    return base64String;
  }
}
