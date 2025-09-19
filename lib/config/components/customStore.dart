

import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../allpaths.dart';
import 'customcchemanager.dart';

Widget buildprofilewidget(user,profile,BuildContext context){
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)),
    color: Theme.of(context).brightness ==
        Brightness.dark
        ? Colors.grey.shade900
        : Colors.grey.shade100,
    child: ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileDetail(user: user)));
      },
      leading: builduserimagewidget(
          user, profile, context),
      title: Text(
        user["username"],
        style: TextStyle(
            fontSize: 14, fontFamily: "title"),
      ),
      subtitle: Text(
        user["useremail"],
        style: TextStyle(
            fontSize: 16, fontFamily: "body_p"),
      ),
    ),
  );
}

Widget buildProductCard(BuildContext context, product,user) {
  return SizedBox(
    width: 200,
    child: InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(product: product,user: user,)));
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: ProductImage(url: (product["image"] is List && product["image"].isNotEmpty)
                        ? product["image"][0]   // list hai to first url lo
                        : (product["image"] is String
                        ? product["image"]  // agar ek string hai to wahi lo
                        : "https://via.placeholder.com/150"), )
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.black45,
                    child: Consumer(builder: (context,ref,_){
                      final userMap = (user is Map) ? user : user.data() as Map<String, dynamic>;
                      final productMap = (product is Map) ? product : product.data() as Map<String, dynamic>;
                      final isFav = ref.watch(favoriteProvider.select(
                              (state) => state.favorites.any((e) => e.product["name"] == productMap["name"])
                      ));
                      return IconButton(
                        onPressed: (){
                          ref.read(favoriteProvider.notifier).addFavorite(productMap, userMap);
                          print("Value added in favorite ");
                          print(ref.watch(favoriteProvider.notifier).isExists(userMap, productMap));
                        },
                        icon:isFav?
                        Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite_border,
                            color: Colors.white, size: 20),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"],
                    style: const TextStyle(
                      fontFamily: "title",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${product["price"]} PKR",
                    style: TextStyle(
                      fontFamily: "body_c",
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future addproductdialog(BuildContext context, WidgetRef ref) {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController companycontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  final formkkey = GlobalKey<FormState>();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 12,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Text(
                  "Add New Product",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 24),

                CustomTextfieldWidget(
                  controller: imagecontroller,
                  label: "Image Url...",
                  validator: (value)=>AppValidations.validateImageUrl(value.toString()),
                  minlines: 2,
                  lines: 3,
                  preffixicon: Icons.image,
                  onChanged: (value) =>
                      ref.read(addproductprovider.notifier).addimage(value),
                ),
                SizedBox(height: 10,),
                CustomTextfieldWidget(
                  controller: namecontroller,
                  label: "Product Name",
                  validator: (value)=>AppValidations.usernameValidation(value.toString()),
                  preffixicon: Icons.production_quantity_limits,
                  onChanged: (value) =>
                      ref.read(addproductprovider.notifier).addname(value),
                ),
                SizedBox(height: 10,),
                CustomTextfieldWidget(
                  controller: pricecontroller,
                  label: "Product Price",
                  preffixicon: Icons.price_change,
                  textInputType: TextInputType.number,
                  onChanged: (value) =>
                      ref.read(addproductprovider.notifier).addprice(int.parse(value)),
                ),
                SizedBox(height: 10,),
                CustomTextfieldWidget(
                  controller: companycontroller,
                  label: "Product Company",
                  validator: (value)=>AppValidations.addressValidation(value.toString()),
                  preffixicon: Icons.compare,
                  onChanged: (value) =>
                      ref.read(addproductprovider.notifier).addcompany(value),
                ),
                SizedBox(height: 10,),
                CustomTextfieldWidget(
                    controller: locationcontroller,
                    label: "Product Location",
                    preffixicon: Icons.location_on,
                    validator: (value)=>AppValidations.addressValidation(value.toString()),
                    onChanged: (value) =>
                        ref.read(addproductprovider.notifier).addlocation(value)
                ),
                const SizedBox(height: 10),
                CustomTextfieldWidget(
                  controller: biocontroller,
                  label: "User Detail...",
                  minlines: 2,
                  validator: (value)=>AppValidations.addressValidation(value.toString()),
                  lines: 3,
                  preffixicon: Icons.note_add_outlined,
                  onChanged: (value) =>
                      ref.read(addproductprovider.notifier).adddetaile(value),
                ),
                const SizedBox(height: 16),
                Consumer(builder: (context, ref, _) {
                  final producteni = ref.watch(addproductprovider
                      .select((val) => val.productEnum));
                  switch (producteni) {
                    case ProductEnum.loading:
                      return const CupertinoActivityIndicator(
                          color: Colors.blue);
                    case ProductEnum.success:
                    case ProductEnum.failure:
                    case ProductEnum.initial:
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ref
                                    .read(addproductprovider.notifier)
                                    .resetstates();
                                namecontroller.clear();
                                pricecontroller.clear();
                                imagecontroller.clear();
                                biocontroller.clear();
                                locationcontroller.clear();
                                companycontroller.clear();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "title",
                                  fontSize: 20,
                                ),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                if (formkkey.currentState!.validate()) {
                                  ref
                                      .read(addproductprovider.notifier)
                                      .addproductinaccount();
                                  namecontroller.clear();
                                  pricecontroller.clear();
                                  imagecontroller.clear();
                                  biocontroller.clear();
                                  locationcontroller.clear();
                                  companycontroller.clear();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                Theme.of(context).colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "title",
                                    color: Colors.white),
                              ))
                        ],
                      );
                  }
                }),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget builduserimagewidget(user, profile, BuildContext context) {
  return user["useremail"] == profile.value
      ? Stack(
    children: [
      buildprofileimagewidget(user, context),
      Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.blue,
            child: const Center(
                child: Icon(Icons.person,
                    size: 10, color: Colors.white)),
          ))
    ],
  )
      : buildprofileimagewidget(user, context);
}

Widget buildprofileimagewidget(user, BuildContext context) {
  return InkWell(
    onTap: (){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.scaffoldDarkMode
              : AppColors.scaffoldLightMode,
          content: Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: user["userimage"].isNotEmpty
                    ?  DecorationImage(image:FileImage(File(user["userimage"])),fit: BoxFit.cover):null
            ),
            child:user["userimage"].isNotEmpty
                ? null
                :  Center(
              child:  CircleAvatar(
                radius: 78,
                backgroundColor: Colors.grey.shade300,
                child: Text(
                  user["username"].toString().substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontFamily: "heading",
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
                ,
              ),
            ),

          ),
        );
      });
    },
    child: CircleAvatar(
      radius: 28,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.white10
          : Colors.grey.shade200,
      backgroundImage: user["userimage"].isNotEmpty
          ? FileImage(File(user["userimage"]))
          : null,
      child: user["userimage"] == null || user["userimage"].isEmpty
          ? Text(
        user["username"].toString().substring(0, 1).toUpperCase(),
        style: TextStyle(
          fontFamily: "heading",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      )
          : null,
    ),
  );
}