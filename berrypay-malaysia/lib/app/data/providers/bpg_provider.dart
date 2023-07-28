import 'dart:convert';
import 'dart:developer';

import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:berrypay_global_x/app/data/model/app_error.dart';
import 'package:berrypay_global_x/app/data/model/bpg/auth.dart';
import 'package:berrypay_global_x/app/data/model/bpg/country.dart';
import 'package:berrypay_global_x/app/data/model/bpg/profile.dart';
import 'package:berrypay_global_x/app/data/model/bpg/user_profile.dart';
import 'package:berrypay_global_x/app/data/providers/storage_providers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class BpgProvider extends GetConnect {
  Map<String, String> defaultHeader = {};

  @override
  void onInit() {
    httpClient.baseUrl = dotenv.env['URL'];
  }

  loginBpg(LoginRequest request) async {
    var response =
        await httpClient.post("auth-v2/login", body: request.toJson());
    if (response.status.isOk) {
      logger("loginBpg: ${response.bodyString}", name: "BpgProvider");
      Login login = Login.fromJson(response.body);

      defaultHeader["Authorization"] = "Bearer ${login.token?.accessToken}";
      return login;
    } else {
      logger("Error: ${response.bodyString}", name: "BpgProvider");
      return AppError(message: "Wrong username/password.");
    }
  }

  refreshToken(String refreshToken) async {
    var response = await httpClient.post("auth-v2/refresh", body: {"refreshToken": refreshToken});
    if (response.status.isOk) {
      log("refreshToken: ${response.bodyString}", name: "BpgProvider");
      RefreshToken login = RefreshToken.fromJson(response.body);
      defaultHeader["Authorization"] = "Bearer ${login.accessToken}";
      return login;
    } else {
      logger("Error: ${response.bodyString}", name: "BpgProvider");
      return AppError(message: "Wrong username/password.");
    }
  }

  updateFcmToken(FcmTokenRequest request) async {
    logger("Header: $defaultHeader", name: "BpgProvider");

    var response = await httpClient.put(
      'user/fcm-token',
      headers: defaultHeader,
      body: request.toJson(),
    );
    logger("Response: ${response.body}", name: "BpgProvider");

    if (response.status.isOk) {
      return FcmTokenResponse.fromJson(response.body);
    } else {
      logger("Error: ${response.bodyString}", name: "BpgProvider");
      return AppError(message: "Something went wrong");
    }
  }

  userInfo(UserInfoRequest userInfoRequest) async {
    logger("Header: $defaultHeader", name: "BpgProvider");
    var response = await httpClient.get(
      'userprofile/username/${userInfoRequest.username}',
      headers: defaultHeader,
    );
    logger("Response: ${response.body}", name: "BpgProvider");

    if (response.status.isOk) {
      return ProfileInfoResponse.fromJson(response.body);
    } else {
      logger("Error: ${response.bodyString}", name: "BpgProvider");
      return AppError(message: "message");
    }
  }

  updateProfile(UpdateRequest updateRequest) async {
    var response = await httpClient.post(
      "/user/username/${updateRequest.phoneNo}",
      headers: {"Content-Type": "application/json"},
      body: updateRequest.toJson(),
    );

    if (response.status.isOk) {
      return UpdateResponse.fromJson(response.body);
    } else {
      logger("Error: ${response.bodyString}", name: "BpgProvider");
      return AppError(message: "message");
    }
  }

  registerBpg(RegisterBpgRequest request) async {
    logger('register request ${jsonEncode(request)}');
    var response = await httpClient.post('user/public/register',
        body: request.toJson(), headers: {"Content-Type": "application/json"});

    logger('response ${response.body}');

    if (response.status.isOk) {
      logger('masuk response ok ${response.body}');
      RegisterResponse registerResponse =
          RegisterResponse.fromJson(response.body);
      logger("Success: ${response.bodyString}", name: "BpgProvider");
      return registerResponse;
    } else {
      logger("Error: ${response.bodyString}", name: "BpgProvider");

      if (response.body != null) {
        RegisterErrorResponse errorResponse =
            RegisterErrorResponse.fromJson(response.body);
        return AppError(message: errorResponse.message!);
      }
      return AppError(message: 'Something went wrong');
    }
  }

  getCountry() async {
    final String response =
        await rootBundle.loadString('assets/data/Countries.json');
    final List data = await jsonDecode(response);

    return data.map((e) => Country.fromJson(e)).toList();
  }

  getProfileDetails(String username) async {
    logger(username);
    var response = await httpClient.get("user/profile/$username",
        contentType: "application/json",
        headers: {
          // "Content-Type": "application/json",
          "Authorization": "Bearer ${Get.find<StorageProvider>().getToken()!}",
        });

    logger(httpClient.baseUrl);

    logger(response.body);

    if (response.status.isOk) {
      Profile getUserDetailsResponse = Profile.fromJson(response.body);

      return getUserDetailsResponse;
    } else {
      return AppError(message: "Error");
    }
  }

  resetPassword(ResetPasswordRequest request) async {
    var response = await httpClient.post("auth-v2/reset-password",
        headers: {
          "Content-Type": "application/json",
        },
        body: request.toJson());

    if (response.status.isOk) {
      return;
    } else {
      logger('object');
      return AppError(message: "Error in reset password. Try again");
    }
  }


}
