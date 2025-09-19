import 'dart:io';

import 'package:flutter/services.dart';
import 'package:localmarket/riverpad/googleAdsRiverpad/googleAdsProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../allpaths.dart';
import '../../../../config/components/customcchemanager.dart';
import 'package:http/http.dart'as http;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


final wiatprovider= StateProvider((ref)=>true);
class ProductDetails extends ConsumerStatefulWidget {
  const ProductDetails({super.key,required this.product,required this.user});
  final dynamic product;
  final dynamic user;

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    downloadimafge(ref);
    super.initState();
  }

  XFile ?xfile;

  downloadimafge(WidgetRef ref)async{
    Future((){
      ref.read(wiatprovider.notifier).state = false;
    });
     xfile = await getShareableFile(widget.product["image"][0]);
     setState(() {});
    Future((){
      ref.read(wiatprovider.notifier).state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = List<String>.from(widget.product["image"]);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        centerTitle: true,
        actions: [
          Consumer(builder: (context,ref,_){
            final wwat = ref.watch(wiatprovider);
            return Visibility(
              visible: wwat,
                child: IconButton(
              icon:Icon(Icons.share),
              onPressed: ()async{
                if(wwat){
                  final message = "Product: ${widget.product["name"]}\nPrice: ${widget.product["price"]}\nLocation: ${widget.product["productlocation"]}";
                  await Share.shareXFiles([xfile??await getShareableFile(widget.product["image"][0]),], text: message);
                }
              },
            ));
          }),
          SizedBox(width: 10,)
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
                child: buildproductimage(_pageController, images,widget.user,widget.product),
              ),

              const SizedBox(height: 20),
              sectionTitle(widget.product["name"]),
              const SizedBox(height: 8),
              Text(
                "${widget.product["price"]} PKR",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 12),
              buildproductmore(Icon(Icons.branding_watermark),widget.product["company"]),
              const SizedBox(height: 12),
              buildproductmore(Icon(Icons.location_on,color: Colors.red,),widget.product["productlocation"]),
              const SizedBox(height: 20),
              sectionTitle("About this Product"),
              const SizedBox(height: 8),
              sectionBox(widget.product["detail"], context, 23),
              const SizedBox(height: 80), // Space for bottom bar
            ],
          ),
        ),
      ),

      // 🔹 Sticky Bottom Bar
      bottomNavigationBar: buildnavigationbuttons(context,widget.user,widget.product),
    );
  }
}





// Future<void> saveNetworkImageWithProgress(String imageUrl, {Function(double)? onProgress}) async {
//   try {
//     // 1️⃣ Request permission
//     var status = await Permission.storage.request();
//     if (!status.isGranted) return;
//
//     final dio = Dio();
//
//     // 2️⃣ Download image into memory with progress
//     final response = await dio.get<List<int>>(
//       imageUrl,
//       options: Options(responseType: ResponseType.bytes),
//       onReceiveProgress: (received, total) {
//         if (total != -1) {
//           double progress = received / total;
//           if (onProgress != null) onProgress(progress);
//           print("Downloading: ${(progress * 100).toStringAsFixed(0)}%");
//         }
//       },
//     );
//
//     final Uint8List bytes = Uint8List.fromList(response.data!);
//
//     // 3️⃣ Save to gallery
//     final result = await ImageGallerySaver.saveImage(
//       bytes,
//       quality: 100,
//       name: "my_image_${DateTime.now().millisecondsSinceEpoch}",
//     );
//
//     if (result['isSuccess']) {
//       print("✅ Image saved to gallery!");
//     } else {
//       print("❌ Failed to save image");
//     }
//   } catch (e) {
//     print("Error saving image: $e");
//   }
// }

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
            return Consumer(builder: (context,ref,_){
              return  Expanded(
                child: OutlinedButton(
                  onPressed: (){
                    final ads = ref.watch(googleAdsProvider);
                    if(ads.isRewardedLoaded){
                      ref.read(googleAdsProvider.notifier).showRewardedAd(onUserEarnedReward: () { });
                    }else{
                      ref.read(googleAdsProvider.notifier).initializeRewardedAd();
                    }
                    ref.read(craftProvider.notifier).toggleFavorite(productMap, userMap);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Add to Cart", style: TextStyle(fontFamily: "title", fontSize: 16)),
                ),
              );
            });
          }
        }),

        const SizedBox(width: 12),
        Expanded(
          child: Consumer(builder: (context,ref,_){
            return ElevatedButton(
            onPressed: () {
              final ads = ref.watch(googleAdsProvider);
              if(ads.isInterstitialLoaded){
                ads.interstitialAd?.show();
              }else{
                ref.read(googleAdsProvider.notifier).initializeInterstitialAd();
              }
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
            );
  },
        ),)
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

Future<XFile> getShareableFile(String? url, {String fallbackAsset = "assets/images/ec.png"}) async {
  try {
    if (url != null) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/image.jpg');
        await file.writeAsBytes(bytes);
        return XFile(file.path);
      }
    }
  } catch (e) {
    print("Error downloading image: $e");
  }

  final byteData = await rootBundle.load(fallbackAsset);
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/fallback_image.jpg');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return XFile(file.path);
}



// void showShareOptions(BuildContext context, XFile xfile, String productName, String price, String location) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         padding: EdgeInsets.all(20),
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: Icon(Icons.messenger, color: Colors.green),
//               title: Text('Share via WhatsApp'),
//               onTap: () async {
//
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.email),
//               title: Text('Share via Email'),
//               onTap: () async {
//                 final message = "Product: $productName\nPrice: $price\nLocation: $location";
//                 await Share.shareXFiles([xfile], text: message);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.copy),
//               title: Text('Copy Link'),
//               onTap: () {
//                 // Copy product link to clipboard
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
