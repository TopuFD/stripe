import 'package:flutter/material.dart';
import 'package:my_payment/stripe_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("payment method"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              StripeService.instance.makePayment();
            },
            child: Text("Purchese")),
      ),
    );
  }
}
