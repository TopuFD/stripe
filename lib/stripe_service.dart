import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_payment/const.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();
  // Future<void> makePayment() async {
  //   try {
  //     String? paymentIntentClientCecret = await createPaymentIntent(10, "usd");
  //     if (paymentIntentClientCecret == null) return;
  //     await Stripe.instance.initPaymentSheet(
  //         paymentSheetParameters: SetupPaymentSheetParameters(
  //             paymentIntentClientSecret: paymentIntentClientCecret,
  //             merchantDisplayName: "topu"));
  //     await paymentProcess();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  Future<void> makePayment() async {
  try {
    String? paymentIntentClientSecret = await createPaymentIntent(10, "usd");
    if (paymentIntentClientSecret == null) {
      print("Failed to get client secret");
      return;
    }
    print("Client secret: $paymentIntentClientSecret"); // Debugging

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: "topu",
      ),
    );
    await paymentProcess();
  } catch (e) {
    print(e.toString());
  }
}


  // Future<String?> createPaymentIntent(int amount, String currency) async {
  //   try {
  //     final Dio dio = Dio();
  //     Map<String, dynamic> paymentData = {
  //       "amount": calculateAmmount(amount),
  //       "currency": currency,
  //     };

  //     final response = await dio.post(
  //       "https://api.stripe.com/v1/payment_intents",
  //       data: paymentData,
  //       options: Options(
  //         contentType: Headers.formUrlEncodedContentType,
  //         headers: {
  //           "Authorization": "Bearer ${ApiService.secretKey}",
  //           "Content-Type": "application/x-www-form-urlencoded",
  //         },
  //       ),
  //     );

  //     if (response.data != null) {
  //       return response.data["client_cecret"];
  //     }
  //     return null;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  Future<String?> createPaymentIntent(int amount, String currency) async {
  try {
    final Dio dio = Dio();
    Map<String, dynamic> paymentData = {
      "amount": calculateAmmount(amount),
      "currency": currency,
    };

    final response = await dio.post(
      "https://api.stripe.com/v1/payment_intents",
      data: paymentData,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
          "Authorization": "Bearer ${ApiService.secretKey}",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
    );

    if (response.data != null) {
      return response.data["client_secret"]; // Fix the typo here
    }
    return null;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

  // Future<void> paymentProcess()async{
  //   try {
  //     await Stripe.instance.presentPaymentSheet();
  //   } catch (e) {
  //     print(e.toString());      
  //   }
  // }
  Future<void> paymentProcess() async {
  try {
    await Stripe.instance.presentPaymentSheet();
    print("Payment sheet presented successfully");
  } catch (e) {
    print("Error presenting payment sheet: ${e.toString()}");
  }
}


  String calculateAmmount(int ammount) {
    final calculatedAmmount = ammount * 100;
    return calculatedAmmount.toString();
  }
}
