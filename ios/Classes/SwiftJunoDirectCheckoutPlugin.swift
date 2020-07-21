import Flutter
import UIKit
import DirectCheckout

public class SwiftJunoDirectCheckoutPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "juno_direct_checkout", binaryMessenger: registrar.messenger())
    let instance = SwiftJunoDirectCheckoutPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  //private var flutterResult = Optional<Any>(nilLiteral: <#()#>)
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments else {
        return
    }
    if (call.method == "init") {
        let resultado = inicializar(args: args)
        if (resultado != "") {
            result(resultado)
        } else {
            result(FlutterError(code: "notInicialized", message: "Send args prod=true/false and public_token=YOUR_PUBLIC_TOKEN", details: nil))
        }
        return
    }
    if let myArgs = args as? [String: Any],
        let cardNumber = myArgs["cardNumber"] as? String,
        let holderName = myArgs["holderName"] as? String,
        let securityCode = myArgs["securityCode"] as? String,
        let expirationMonth = myArgs["expirationMonth"] as? String,
        let expirationYear = myArgs["expirationYear"] as? String {
      let card = Card(
            cardNumber: cardNumber,
            holderName: holderName,
            securityCode: securityCode,
            expirationMonth: expirationMonth,
            expirationYear: expirationYear
        )
      switch (call.method) {
        case "getCardHash":
            let resultado = inicializar(args: args)
            if (resultado == "") {
                result(FlutterError(code: "notInicialized", message: "Send args prod=true/false and public_token=YOUR_PUBLIC_TOKEN", details: nil))
                return
            }
            getHash(card: card, flutterResult: result)
        case "isValidCardNumber":
          result(DirectCheckout.isValidCardNumber(cardNumber))
        case "isValidSecurityCode":
          result(DirectCheckout.isValidSecurityCode(cardNumber, securityCode))
        case "isValidExpireDate":
          result(DirectCheckout.isValidExpireDate(month: expirationMonth, year: expirationYear))
        case "isValidCardData":
          do {
            let valido = try card.validate()
            result(valido);
          } catch {
            result(FlutterError(code: "isValidCardDataError", message: error.localizedDescription, details: nil))
          }
        case "getCardType":
          result(card.getType())
        default:
          result(FlutterMethodNotImplemented)
      }
    } else {
      result(FlutterError(code: "argsNotFound", message: "Send args cardNumber, holderName, securityCode, expirationMonth and expirationYear", details: nil))
    }
  }

    func inicializar(args: Any) -> String {
        if let myArgs = args as? [String: Any],
            let prod = myArgs["prod"] as? Bool,
            let publicToken = myArgs["public_token"] as? String {
              if (prod) {
                DirectCheckout.initialize(publicToken: publicToken, environment: .production)
                return "true = PRODUCTION"
              } else {
                DirectCheckout.initialize(publicToken: publicToken, environment: .sandbox)
                return "true = SANDBOX"
              }
            }
        return ""
  }
    
  func getHash(card: Card, flutterResult: @escaping FlutterResult) -> Void {
    DirectCheckout.getCardHash(card) { result in
        do {
            let hash = try result.get()
            /* Sucesso - A variável hash conterá o hash do cartão de crédito */
            flutterResult(hash)
        } catch let error {
            print(error)
            /* Erro - A variável error conterá o erro ocorrido ao obter o hash */
            flutterResult("Não foi possível gerar o hash")
        }
    }
  }
}
