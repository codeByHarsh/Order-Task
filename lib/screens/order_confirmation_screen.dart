// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:order_task/constants/constants.dart';
import 'package:order_task/screens/order_placement_screen.dart';
import 'package:order_task/widgets/custom_text.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const String route = '/order_confirmation_screen';

  const OrderConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/order_placed.png',
                width: 120.0,
                height: 120.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomText(
                text: 'Your Order has Been\nPlaced Successfully!',
                textStyle: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: CostomColors.bottomButtonColor,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, PlaceOrderScreen.route);
              // riverpod.BuildContextX(context)
              //     .read(itemListProvider)
              //     .getItemList();

              // riverpod.BuildContextX(context)
              //     .read(placeOrerProvider)
              //     .placeOrder(
              //       name: 'Sonu',
              //       mobile: '8118906634',
              //       email: 'firstnet@gmail.com',
              //       productId: '4',
              //       mrp: '450',
              //       quantity: '1',
              //       netAmount: '450',
              //       discount: '10',
              //       deliveryCharge: '450',
              //       payableAmount: '440',
              //     );
            },
            child: CustomText(
              text: 'Continue Shopping',
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
