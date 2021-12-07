// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:http/http.dart' as http;
import 'package:order_task/constants/constants.dart';

final placeOrerProvider =
    riverpod.ChangeNotifierProvider<PlaceOrder>((ref) => PlaceOrder());

class PlaceOrder extends ChangeNotifier {
  Status status = Status.loading;
  placeOrder({
    String? name,
    String? mobile,
    String? email,
    String? productId,
    String? mrp,
    String? quantity,
    String? netAmount,
    String? discount,
    String? deliveryCharge,
    String? payableAmount,
  }) async {
    Uri baseUrl = Uri.parse('http://api.acolabz.com/api/orders');
    http.Response response = await http.post(baseUrl, body: <String, dynamic>{
      'name': name,
      'mobile': mobile,
      'email': name,
      'product_id': productId,
      'mrp': mrp,
      'quantity': quantity,
      'net_amount': netAmount,
      'discount': discount,
      'delivery_charge': deliveryCharge,
      'payable_amount': payableAmount,
    });

    if (response.statusCode == 200) {
      status = Status.success;
      print("Order Placed");
      print(response.body);
      notifyListeners();
      return response;
    } else {
      print('Not Placed');
      print(response.body);
      status = Status.error;
      notifyListeners();
      return response;
    }
  }
}
