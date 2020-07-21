package br.com.juno.juno_direct_checkout;

import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import br.com.juno.directcheckout.DirectCheckout;
import br.com.juno.directcheckout.model.Card;
import br.com.juno.directcheckout.model.DirectCheckoutListener;
import br.com.juno.directcheckout.model.DirectCheckoutException;

/** JunoDirectCheckoutPlugin */
public class JunoDirectCheckoutPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "juno_direct_checkout");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "juno_direct_checkout");
    channel.setMethodCallHandler(new JunoDirectCheckoutPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "init": 
        Boolean prod = true;
        if (call.hasArgument("prod")) {
          prod = call.argument("prod");
        }
        InitializeDirectCheckoutListener initializeListener = new InitializeDirectCheckoutListener(result);
        DirectCheckout.initialize(context, prod, initializeListener);
        break;
      case "getCardHash":
        CodigoHashDirectCheckoutListener listener = new CodigoHashDirectCheckoutListener(result);
        DirectCheckout.getCardHash(loadCard(call), listener);
        break;
      case "isValidCardNumber":
        String cardNumber = call.argument("cardNumber");
        result.success(DirectCheckout.isValidCardNumber(cardNumber));
        break;
      case "isValidSecurityCode":
        cardNumber = call.argument("cardNumber");
        String securityCode = call.argument("securityCode");
        result.success(DirectCheckout.isValidSecurityCode(cardNumber, securityCode));
        break;
      case "isValidExpireDate":
        String expirationMonth = call.argument("expirationMonth");
        String expirationYear = call.argument("expirationYear");
        result.success(DirectCheckout.isValidExpireDate(expirationMonth, expirationYear));
        break;
      case "isValidCardData":
        try {
          result.success(DirectCheckout.isValidCardData(loadCard(call)));
        } catch (DirectCheckoutException e) {
          result.error("isValidCardDataError", e.getMessage(), null);
        }
        break;
      case "getCardType":
        cardNumber = call.argument("cardNumber");
        try {
          result.success(DirectCheckout.getCardType(cardNumber));        
        } catch (Exception e) {
          result.error("isValidCardDataError", e.getMessage(), null);
        }
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private Card loadCard(MethodCall call) {
    String cardNumber = "";
    if (call.hasArgument("cardNumber")) {
        cardNumber = call.argument("cardNumber");
    }
    String holderName = "";
    if (call.hasArgument("holderName")) {
        holderName = call.argument("holderName");
    }
    String securityCode = "";
    if (call.hasArgument("securityCode")) {
        securityCode = call.argument("securityCode");
    }
    String expirationMonth = "";
    if (call.hasArgument("expirationMonth")) {
        expirationMonth = call.argument("expirationMonth");
    }
    String expirationYear = "";
    if (call.hasArgument("expirationYear")) {
        expirationYear = call.argument("expirationYear");
    }
    return new Card(
            cardNumber,
            holderName,
            securityCode,
            expirationMonth,
            expirationYear
    );
  }
}
