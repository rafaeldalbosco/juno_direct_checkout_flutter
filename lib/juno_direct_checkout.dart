import 'dart:async';

import 'package:flutter/services.dart';

class JunoDirectCheckout {
  static const MethodChannel _channel =
      const MethodChannel('juno_direct_checkout');

  //prod
  static Future<String> init(Map<String, dynamic> args) async {
    final String init = await _channel.invokeMethod('init', args);
    return init;
  }

  /*{
      "cardNumber": "0000 0000 0000 0000",
      "holderName": "fulano de tal",
      "securityCode": "123",
      "expirationMonth": "12",
      "expirationYear": "2020"
    }*/
  static Future<String> getCardHash(Map<String, dynamic> args) {
    return _channel.invokeMethod('getCardHash', args);
  }

  //cardNumber: 
  static Future<bool> isValidCardNumber(Map<String, dynamic> args) {
    return _channel.invokeMethod('isValidCardNumber', args);
  }

  //cardNumber: , securityCode
  static Future<bool> isValidSecurityCode(Map<String, dynamic> args) {
    return _channel.invokeMethod('isValidSecurityCode', args);
  }

  //expiratinoMonth: , expiratinoYear
  static Future<bool> isValidExpireDate(Map<String, dynamic> args) {
    return _channel.invokeMethod('isValidExpireDate', args);
  }

  /*{
      "cardNumber": "0000 0000 0000 0000",
      "holderName": "fulano de tal",
      "securityCode": "123",
      "expirationMonth": "12",
      "expirationYear": "2020"
    }*/
  static Future<bool> isValidCardData(Map<String, dynamic> args) {
    return _channel.invokeMethod('isValidCardData', args);
  }

  //cardNumber: 
  static Future<String> getCardType(Map<String, dynamic> args) {
    return _channel.invokeMethod('getCardType', args);
  }
}
