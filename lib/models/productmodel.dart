


class ProductModel {
  final List<String> image;
  final String name;
  final int price;
  final String detail;
  final String company;
  final String productlocation;

  ProductModel({
    required this.image,
    required this.name,
    required this.company,
    required this.detail,
    required this.price,
    required this.productlocation
});

  ProductModel.fromJson(Map<String,dynamic>json):
      image = json["image"],
  productlocation = json["productlocation"],
  price = json["price"],
  company = json["company"],
  detail = json["detail"],
  name = json["name"];

  Map<String,dynamic>toMap(){
    return {
      "image":image,
      "company":company,
      "productlocation":productlocation,
      "price":price,
      "detail":detail,
      "name":name
    };
  }
}