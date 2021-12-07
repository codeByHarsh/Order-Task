// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:order_task/screens/order_confirmation_screen.dart';
import 'package:order_task/screens/order_placement_screen.dart';

void main() {
  runApp(const riverpod.ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Task Demo',
      debugShowCheckedModeBanner: false,
      home: const PlaceOrderScreen(),
      routes: {
        PlaceOrderScreen.route: (ctx) => PlaceOrderScreen(),
        OrderConfirmationScreen.route: (ctx) => OrderConfirmationScreen(),
      },
    );
  }
}
