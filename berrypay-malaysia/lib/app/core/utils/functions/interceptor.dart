import 'dart:async';
import 'dart:convert';

import 'package:berrypay_global_x/app/core/utils/functions/verify_response.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/secure_storage.dart';
import 'package:berrypay_global_x/app/core/utils/helpers/signature.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/providers/bpg_provider.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:berrypay_global_x/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

final SecureStorage secureStorage = SecureStorage();

Future<String> streamToString(Stream<List<int>> stream) async {
  final buffer = StringBuffer();

  await for (final chunk in stream) {
    final stringChunk = String.fromCharCodes(chunk);
    buffer.write(stringChunk);
  }

  return buffer.toString();
}

FutureOr<Request<dynamic>> apisixInterceptor(Request request) async {
  if (request.url.toString().contains('public')) {
    return request;
  }

  String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
  String appId = "bpg-my-prod-01";
  Map<String, dynamic> requestBody = {
    "timestamp": timestamp,
    "appId": appId,
  };
  if (await request.bodyBytes.length > 1) {
    requestBody.addAll(jsonDecode(await streamToString(request.bodyBytes)));
  }

  return request;
}

FutureOr<Request<dynamic>> keycloakInterceptor(Request request) async {
  if (request.url.toString().contains('public')) {
    return request;
  }

  var newToken = await Get.find<BpgProvider>()
      .refreshToken(await secureStorage.getRefreshToken() ?? "");
  if (!verifyResponse(newToken)) {
    request.headers["Authorization"] =
        "Bearer ${(newToken as RefreshToken).accessToken}";
    secureStorage.setRefreshToken(newToken.refreshToken ?? "");

    Get.find<StorageProvider>().setToken(newToken.accessToken ?? "");
  } else {
    Get.offNamedUntil(Routes.WELCOME, ModalRoute.withName(Routes.WELCOME));
  }
  return request;
}
