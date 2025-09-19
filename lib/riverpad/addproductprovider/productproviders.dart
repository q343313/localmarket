


import 'package:flutter_riverpod/legacy.dart';
import 'package:localmarket/allpaths.dart';
import 'package:localmarket/models/productmodel.dart';
import 'package:localmarket/models/profilemodels.dart';

enum ProductEnum {loading,success,failure,initial}
final addproductprovider = StateNotifierProvider<ProductNotifies,ProductStates>((ref)=>ProductNotifies(getIt()));

class ProductNotifies extends StateNotifier<ProductStates>{
  final AddUserData addUserData;
  ProductNotifies(this.addUserData):super(ProductStates(
      productEnum: ProductEnum.initial,
      image: "",
      name: "",
      price: 0,
      company: "",
      location: "",
      detaile: ""
  ));


  void addname(String name)=>state= state.copyWith(name: name);
  void addprice(int price)=>state= state.copyWith(price: price);
  void addlocation(String location)=>state= state.copyWith(location: location);
  void addcompany(String name)=>state= state.copyWith(company: name);
  void addimage(String name)=>state= state.copyWith(image: name);
  void adddetaile(String name)=>state= state.copyWith(detaile: name);

  void addproductinaccount()async{
    state = state.copyWith(productEnum: ProductEnum.loading);
    try {
      ProductModel productModel = ProductModel(
          image: [state.image],
          name: state.name,
          company: state.company,
          detail: state.detaile,
          price: state.price,
          productlocation: state.location
      );

      await addUserData.addProduct(productModel);
      state  = state.copyWith(productEnum: ProductEnum.failure);
      Get.back();
      resetstates();
      Get.snackbar("Product Added", "your product added succesfully",backgroundColor: Colors.green);
    }catch(e){
      state = state.copyWith(productEnum: ProductEnum.failure);
      Get.back();
      resetstates();
      Get.snackbar("Product Failed", "your product added Failed ${e.toString()}",backgroundColor: Colors.red);
    }
  }

  resetstates(){
    state = state.copyWith(name: "",productEnum: ProductEnum.initial,price: 0,company: "",location: "",detaile: '',);
  }

}

class ProductStates {
  final String name;
  final int price;
  final String image;
  final String location;
  final String company;
  final String detaile;
  final ProductEnum productEnum;

  ProductStates({
    required this.productEnum,
    required this.image,
    required this.name,
    required this.price,
    required this.company,
    required this.location,
    required this.detaile,

});

  ProductStates copyWith({
    String?name,
     int? price,
     String ?image,
     String? location,
     String ?company,
     String ?detaile,
     ProductEnum ?productEnum
}){
    return ProductStates(
        productEnum: productEnum??this.productEnum,
        image: image??this.image,
        name: name??this.name,
        price: price??this.price,
        company: company??this.company,
        location: location??this.location,
        detaile: detaile??this.detaile
    );
  }
}