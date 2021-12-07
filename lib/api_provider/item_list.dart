// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:http/http.dart' as http;
import 'package:order_task/constants/constants.dart';
import 'package:order_task/models/items.dart';

final itemListProvider =
    riverpod.ChangeNotifierProvider<ItemList>((ref) => ItemList());

class ItemList extends ChangeNotifier {
  List<Items> itemList = [];
  String mrp = '00';
  String? product;
  String? quantity;
  Status status = Status.loading;
  getItemList() async {
    Uri baseUrl = Uri.parse('http://api.acolabz.com/api/products');
    http.Response response = await http.get(baseUrl);
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      status = Status.success;
      itemList = [...jsonData['data'].map((e) => Items.fromJson(e))];
      // for (int i = 0; i < itemList.length; i++) {
      //   itemListName.add(itemList[i].productName);
      // }
      // print('Data has come');
      // print(itemList.length);
      notifyListeners();
      return true;
    } else {
      print('Something went wrong.');
      itemList = [];
      status = Status.error;
      notifyListeners();
      return null;
    }
  }

  setMrp(String mrp) {
    print('product mrp');
    print(product);
    product = mrp;
    this.mrp = mrp;
    notifyListeners();
  }

  setQuantity(String quantity) {
    this.quantity = quantity;
    notifyListeners();
  }
}
