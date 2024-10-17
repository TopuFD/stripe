import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_payment/const.dart';
import 'package:my_payment/home_page.dart';

void main()async {
  await setup();
  runApp(const MyApp());
}
Future<void> setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = ApiService.publishableKey;
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
