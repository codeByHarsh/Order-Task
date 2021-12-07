// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators, unnecessary_null_comparison, division_optimization

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:order_task/api_provider/item_list.dart';
import 'package:order_task/api_provider/place_order.dart';
import 'package:order_task/constants/constants.dart';
import 'package:order_task/models/items.dart';
import 'package:order_task/screens/order_confirmation_screen.dart';
import 'package:order_task/widgets/custom_text.dart';
import 'package:http/http.dart' as http;
import 'package:order_task/widgets/custom_textform_field.dart';

class PlaceOrderScreen extends StatefulWidget {
  static const String route = '/placed_order_screen';

  const PlaceOrderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  TextEditingController nameC = TextEditingController();
  TextEditingController mobNoC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController netAmountC = TextEditingController();
  TextEditingController discountC = TextEditingController();
  TextEditingController delChargeC = TextEditingController();
  TextEditingController payAmountC = TextEditingController();
  @override
  void initState() {
    super.initState();
    riverpod.BuildContextX(context).read(itemListProvider).getItemList();
  }

  _onSubmit() async {
    if (nameC.text == null || nameC.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Name Required'),
        backgroundColor: Colors.red,
      ));
      return;
    } else if (mobNoC.text == null || mobNoC.text == '') {
      print('mobNoC.text.length');
      print(mobNoC.text);
      print(mobNoC.text.length);
      if (mobNoC.text.length < 10 && mobNoC.text != '') {
        print('mobNoC.text.length65656');
        print(mobNoC.text);
        print(mobNoC.text.length);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Mobile Number Must Shound be 10 digits!'),
          backgroundColor: Colors.red,
        ));
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Mobile Number Required'),
        backgroundColor: Colors.red,
      ));
      return;
    } else if (emailC.text == null || emailC.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email Required'),
        backgroundColor: Colors.red,
      ));
      return;
    } else if (product == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Choose Any Prosuct!'),
        backgroundColor: Colors.red,
      ));
      return;
    } else if (quantity == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Choose Quantity'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    int netAmount = int.parse(mrp!) * int.parse(quantity!);
    int discount = 0;
    int deliveryCharge = 0;
    int payableAmount = 0;

    print('dataaaaaa');
    double a = 10.5;
    String s = '12.5';
    print(a.toInt());
    print(double.parse(s).toInt());
    print(int.parse(quantity!));

    if (int.parse(quantity!) > 1 && int.parse(quantity!) <= 3) {
      discount =
          (((int.parse(mrp!) * int.parse(quantity!)) * 10) / 100).toInt();
      discount >= 200 ? discount = 200 : discount;
    } else if (int.parse(quantity!) > 3 && int.parse(quantity!) <= 6) {
      discount =
          (((int.parse(mrp!) * int.parse(quantity!)) * 15) / 100).toInt();
      discount >= 200 ? discount = 300 : discount;
    } else if (int.parse(quantity!) > 6 && int.parse(quantity!) <= 10) {
      discount =
          (((int.parse(mrp!) * int.parse(quantity!)) * 20) / 100).toInt();
      discount >= 200 ? discount = 500 : discount;
    }

    print('discount id  $discount');
    print(int.parse(quantity!));

    //delivery charge logic
    if (int.parse(quantity!) > 1 && int.parse(quantity!) <= 3) {
      deliveryCharge = 100;
    } else if (int.parse(quantity!) > 3 && int.parse(quantity!) <= 6) {
      deliveryCharge = 50;
    } else if (int.parse(quantity!) > 6 && int.parse(quantity!) <= 10) {
      deliveryCharge = 0;
    }

    //payable amount logic
    payableAmount = ((netAmount + deliveryCharge) - discount);
    print('data printinggggg');
    print('name is' + nameC.text);
    print('mobile is' + mobNoC.text);
    print('email is' + emailC.text);
    print('product is' + product.toString());
    print('Mrp is' + mrp.toString());
    print('Quantity is' + quantity.toString());
    print('Net Amount is' + netAmount.toString());
    print('Discount is' + discount.toString());
    print('Delivery Charge is' + deliveryCharge.toString());
    print('Payable Amount is' + payableAmount.toString());

    netAmountC.text = netAmount.toString();
    discountC.text = discount.toString();
    delChargeC.text = deliveryCharge.toString();
    payAmountC.text = payableAmount.toString();

    http.Response response = await riverpod.BuildContextX(context)
        .read(placeOrerProvider)
        .placeOrder(
          name: nameC.text,
          mobile: mobNoC.text,
          email: emailC.text,
          productId: '3',
          mrp: mrp,
          quantity: quantity,
          netAmount: netAmount.toString(),
          discount: discount.toString(),
          deliveryCharge: deliveryCharge.toString(),
          payableAmount: payableAmount.toString(),
        );
    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, OrderConfirmationScreen.route);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error Occured Try Again!'),
        backgroundColor: Colors.red,
      ));
      return;
    }
  }

  String? product;
  String? quantity;
  String? mrp;
  @override
  Widget build(BuildContext context) {
    print('build method called');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CostomColors.appBarColor,
          title: const Text(
            'Place Order',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        body: Container(
          color: Colors.grey.shade100,
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(bottom: 65.0),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          child: SingleChildScrollView(child: columnItem()),
        ),
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: CostomColors.bottomButtonColor,
            ),
            onPressed: () {
              _onSubmit();

              // Navigator.pushReplacementNamed(
              //     context, OrderConfirmationScreen.route);

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
              text: 'Place Order',
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

  Container columnItem() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Name*',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            hintText: 'Enter Name',
            initVal: nameC,
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Mobile No*',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            initVal: mobNoC,
            hintText: 'Enter Mobile Number',
            isMob: true,
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Email*',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            initVal: emailC,
            hintText: 'Enter Email',
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Choose Product*',
          ),
          SizedBox(
            height: 6.0,
          ),
          riverpod.Consumer(builder: (context, watch, child) {
            List<Items> items2 = watch(itemListProvider).itemList;
            product = watch(itemListProvider).product;
            // print('data length');
            // print(items2.length);
            return Container(
              height: 45.0,
              padding: EdgeInsets.only(left: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: DropdownButton(
                hint: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Choose Product',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                isExpanded: true,
                value: product,
                underline: SizedBox(),
                items: items2.map((e) {
                  return DropdownMenuItem(
                    child: Text(
                      e.productName!,
                    ),
                    value: e.mrp.toString(),
                    // value: e.mrp.toString() != null
                    //     ? product = e.productName
                    //     : product = e.productName,
                  );
                }).toList(),
                onChanged: (val) {
                  print('product mrp');
                  print(val);
                  context.read(itemListProvider).setMrp(val.toString());
                  // setState(() {
                  //   product = val.toString();
                  // });
                },
              ),
            );
          }),
          SizedBox(
            height: 6.0,
          ),
          riverpod.Consumer(
            builder: (context, watch, child) {
              mrp = watch(itemListProvider).mrp;
              return CustomText(
                text: "MRP:$mrp",
                textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.w500),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Choose Quantity*',
          ),
          SizedBox(
            height: 6.0,
          ),
          riverpod.Consumer(builder: (context, watch, child) {
            // List<Items> items2 = watch(itemListProvider).itemList;
            quantity = watch(itemListProvider).quantity;

            // print('data length');
            // print(items2.length);
            return Container(
              height: 45.0,
              padding: EdgeInsets.only(left: 5.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: DropdownButton(
                hint: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'Choose Quantity',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
                value: quantity,
                isExpanded: true,
                underline: SizedBox(),
                items: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                    .map((e) {
                  return DropdownMenuItem(
                    child: Text(
                      e.toString(),
                    ),
                    value: e.toString(),
                  );
                }).toList(),
                onChanged: (val) {
                  // print(val);
                  // setState(() {
                  //   quantity = val.toString();
                  // });
                  context.read(itemListProvider).setQuantity(val.toString());
                },
              ),
            );
          }),
          // Container(
          //   height: 45.0,
          //   width: double.infinity,
          //   // color: Colors.white,
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.grey,
          //       ),
          //       borderRadius: BorderRadius.all(Radius.circular(4.0))),

          //   child: DropdownButton<String>(
          //     isExpanded: true,
          //     underline: SizedBox(),
          //     hint: Padding(
          //       padding: EdgeInsets.only(left: 5.0),
          //       child: Text(
          //         'Choose Quantity',
          //         style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          //       ),
          //     ),
          //     items: <String>['A', 'B', 'C', 'D'].map((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //     onChanged: (val) {
          //       print(val);
          //     },
          //   ),
          // ),
          // CustomTextFormField(
          //   initVal: 'Name',
          // ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Net Amount',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            initVal: netAmountC,
            backColor: true,
            readOnly: true,
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Discount',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            initVal: discountC,
            readOnly: true,
            backColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Delivery Charges',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            initVal: delChargeC,
            readOnly: true,
            backColor: true,
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Payable Amount',
          ),
          SizedBox(
            height: 6.0,
          ),
          CustomTextFormField(
            initVal: payAmountC,
            readOnly: true,
            backColor: true,
          ),
        ],
      ),
    );
  }
}
