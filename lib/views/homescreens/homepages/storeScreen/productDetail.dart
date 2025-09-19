import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../allpaths.dart';
import '../../../../config/components/customcchemanager.dart';

class ProductDetails extends StatelessWidget {
  final dynamic product;
  final dynamic user;

  ProductDetails({super.key, required this.product,required this.user});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final images = List<String>.from(product["image"]);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: buildproductimage(_pageController, images,user,product),
              ),

              const SizedBox(height: 20),
              sectionTitle(product["name"]),
              const SizedBox(height: 8),
              Text(
                "${product["price"]} PKR",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 12),
              buildproductmore(Icon(Icons.branding_watermark), product["company"]),
              const SizedBox(height: 12),
             buildproductmore(Icon(Icons.location_on,color: Colors.red,), product["productlocation"]),
              const SizedBox(height: 20),
              sectionTitle("About this Product"),
              const SizedBox(height: 8),
             sectionBox(product["detail"], context, 23),
              const SizedBox(height: 80), // Space for bottom bar
            ],
          ),
        ),
      ),

      // 🔹 Sticky Bottom Bar
      bottomNavigationBar: buildnavigationbuttons(context,user,product),
    );
  }
}

Widget buildproductimage(controller,List<String>images,user,product){
  return Stack(
    children: [
      PageView.builder(
        controller:controller,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ProductImage(
              url: images[index],
              height: 300,
            ),
          );
        },
      ),
      Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        child: Center(
          child: SmoothPageIndicator(
            controller: controller,
            count: images.length,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.blue,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black54,
          child: Consumer(builder: (context,ref,_){
            final userMap = (user is Map) ? user : user.data() as Map<String, dynamic>;
            final productMap = (product is Map) ? product : product.data() as Map<String, dynamic>;
            final isFav = ref.watch(favoriteProvider.select(
                    (state) => state.favorites.any((e) => e.product["name"] == productMap["name"])
            ));
            return IconButton(
              onPressed: ()=>ref.read(favoriteProvider.notifier).addFavorite(productMap, userMap),
              icon:isFav?
              Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite_border,
                  color: Colors.white, size: 20),
            );
          }),
        ),
      ),
    ],
  );
}

Widget buildnavigationbuttons(BuildContext context,dynamic user,product){
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: const Offset(0, -2),
        )
      ],
    ),
    child: Row(
      children: [
        Consumer(builder: (context, ref, _) {
          final craftState = ref.watch(craftProvider); // 👈 ab yeh state watch kar raha hai
          final userMap = (user is Map<String, dynamic>)
              ? user
              : Map<String, dynamic>.from(user.data() as Map);
          final productMap = (product is Map<String, dynamic>)
              ? product
              : Map<String, dynamic>.from(product.data() as Map);

          final isAdd = craftState.any((e) =>
          e is Map<String, dynamic> &&
              e["product"]?["name"] == productMap["name"]);


          if (isAdd) {
            return Expanded(
              child: OutlinedButton(
                onPressed: (){
                  ref.read(craftProvider.notifier).toggleFavorite(productMap, userMap);
                  final data = userMap;
                  data["product"] = productMap;
                  AddUserData().deleteValueCraft(data);
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Added", style: TextStyle(fontFamily: "title", fontSize: 16)),
              ),
            );
          } else {
            return Expanded(
              child: OutlinedButton(
                onPressed: () => ref.read(craftProvider.notifier).toggleFavorite(productMap, userMap),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Add to Cart", style: TextStyle(fontFamily: "title", fontSize: 16)),
              ),
            );
          }
        }),

        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileDetail(user: user)));
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              "Buy Now",
              style: TextStyle(color: Colors.white,fontFamily: "title",fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}


Widget buildproductmore(Icon icon,String title){
  return  Row(
    children: [
      icon,
      const SizedBox(width: 6),
      Expanded(
        child: Text(
         title,
          style: const TextStyle(fontSize: 16,fontFamily: "body_c"),
        ),
      ),
    ],
  );
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:localmarket/config/domians/appcolors.dart';
//
//
// class ProductDetails extends StatelessWidget {
//   final dynamic product;
//
//   const ProductDetails({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     final images = List<String>.from(product["image"]);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Product Details",),
//         centerTitle: true,
//         leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_sharp,color: Colors.white,)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.share,color: Colors.blue,),
//             onPressed: () {},
//           ),
//           SizedBox(width: 8,),
//         ],
//       ),
//       extendBodyBehindAppBar: true, // Makes the app bar transparent
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildProductImages(images),
//
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product["name"],
//                     style: TextStyle(fontSize: 20,fontFamily: "body_c")
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "${product["price"]} PKR",
//                     style: TextStyle(fontSize: 20,fontFamily: "body_c")
//                   ),
//                   const SizedBox(height: 16),
//
//                   // --- Details Table Section ---
//                   _buildDetailRow("Company", product["company"], context),
//                   _buildDetailRow("Location", product["productlocation"], context),
//
//                   const SizedBox(height: 24),
//
//                   // --- Description Section ---
//                   _sectionTitle("About this product"),
//                   const SizedBox(height: 8),
//                   _sectionText(product["detail"], context),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: _buildBottomBar(context),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
//
//   Widget _buildBottomBar(BuildContext context) {
//     return Padding(padding: EdgeInsets.symmetric(horizontal: 18),
//     child: SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(onPressed: (){}
//           , child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FaIcon(FontAwesomeIcons.buyNLarge,color: Colors.white,),
//               SizedBox(width: 5,),
//               Text("Buy",style: TextStyle(fontFamily: "title",
//               fontSize: 23,
//               color: Colors.white),)
//             ],
//           )),
//     ),);
//   }
//
//   Widget _buildDetailRow(String title, String value, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 18,fontFamily: "body_c",color: Colors.blue)
//           ),
//           Text(
//             value,
//             style: TextStyle(fontFamily: "body_p",fontSize: 20,)
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildProductImages(List<String> images) {
//     return SizedBox(
//       height: 400, // Make the image section taller
//       child: Stack(
//         children: [
//           PageView.builder(
//             itemCount: images.length,
//             itemBuilder: (context, index) {
//               return CachedNetworkImage(
//                 imageUrl: images[index],
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//                 placeholder: (context, url) =>
//                 const Center(child: CircularProgressIndicator()),
//                 errorWidget: (context, url, error) => const Icon(Icons.error),
//               );
//             },
//           ),
//           Positioned(
//             top: 80,
//             right: 20,
//             child: CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.black45,
//               child: IconButton(
//                 icon: const Icon(Icons.favorite_border, color: Colors.white, size: 24),
//                 onPressed: () {
//                   // Handle favorite button tap
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionTitle(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         fontFamily: "title",
//         color: Colors.blue
//       ),
//     );
//   }
//
//   Widget _sectionText(String text, BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 22,
//         fontFamily: "body_p",
//         color: Theme.of(context).brightness == Brightness.dark
//         ? AppColors.secondaryTextDarkMode
//         :AppColors.secondaryTextLightMode,
//         height: 1.5,
//       ),
//     );
//   }
// }