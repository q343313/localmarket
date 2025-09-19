import 'dart:convert';

class Favoritemodels {
  final int? userid; // ab nullable rakho, insert ke waqt null hoga
  final String useremail;
  final String owneremail;
  final dynamic product;

  Favoritemodels({
    this.userid,
    required this.useremail,
    required this.owneremail,
    required this.product,
  });

  factory Favoritemodels.fromJson(Map<String, dynamic> json) {
    return Favoritemodels(
      userid: json["userid"],
      useremail: json["useremail"],
      owneremail: json["owneremail"],
      product: json["product"] is String
          ? jsonDecode(json["product"]) // ✅ proper decode
          : json["product"], // ✅ already Map
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "userid": userid,
      "useremail": useremail,
      "owneremail":owneremail,
      "product": jsonEncode(product is String ? jsonDecode(product) : product),// ✅ Map -> JSON string
    };
  }

  // ✅ equality override (important for contains() check)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Favoritemodels &&
        other.useremail == useremail && // ya koi unique user field
        other.product.toString() == product.toString(); // product unique check
  }

  @override
  int get hashCode => useremail.hashCode ^ product.hashCode;
}
