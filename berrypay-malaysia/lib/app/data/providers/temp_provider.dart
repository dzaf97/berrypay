import 'package:berrypay_global_x/app/core/utils/functions/logger.dart';
import 'package:get/get.dart';

class TempProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://currency-exchange.p.rapidapi.com/';
  }

  getExchangeRate(String from, String to, double amount) async {
    var response = await httpClient.get(
        ('https://currency-exchange.p.rapidapi.com/exchange?from=$from&to=$to&q=$amount'),
        headers: {
          'Content-Type': 'application/json',
          'X-RapidAPI-Host': 'currency-exchange.p.rapidapi.com',
          'X-RapidAPI-Key': 'fb3edb97ebmshfb2299f9b3d04b9p19aa36jsn23f68d230ccf'
        });

    logger(
        "getExchangeRateRapidApi: ${response.statusCode} | ${response.body}");

    if (response.statusCode == 401) {
      logger('error');
    }

    logger("End getExchangeRateRapidApi");
    return response.body;
  }
}
