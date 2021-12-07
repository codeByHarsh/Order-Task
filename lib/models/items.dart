class Items {
  int? id;
  String? productName;
  int? mrp;

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productName = json['product_name'],
        mrp = json['mrp'];
}
