import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localmarket/config/components/shimerwidget.dart';
import 'package:localmarket/riverpad/googleAdsRiverpad/googleAdsProvider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../allpaths.dart';
import '../../../../config/components/customStore.dart';
import '../../../../config/components/customcchemanager.dart';


class ShopingCartScreen extends ConsumerStatefulWidget {
  const ShopingCartScreen({super.key});

  @override
  ConsumerState<ShopingCartScreen> createState() => _ShopingCartScreenState();
}

class _ShopingCartScreenState extends ConsumerState<ShopingCartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future((){
      ref.read(favoriteProvider.notifier).refreshFavorites();
    });
    final adsNotifier = ref.read(googleAdsProvider.notifier);
    adsNotifier.initializeBannerAd();
    adsNotifier.initializeInterstitialAd();
    adsNotifier.initializeRewardedAd();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(firebasedata);
    final profile = ref.watch(profileproviders);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Consumer(builder: (context,ref,_){
                final ads = ref.watch(googleAdsProvider);
               return ads.isBannerLoaded?Container(
                 width: ads.bannerAd!.size.width.toDouble(),
                 height: ads.bannerAd!.size.height.toDouble(),
                 child: AdWidget(ad: ads.bannerAd!),
               )
                   :Container();
              }),
              SizedBox(height: 10,),
              database.when(
                data: (value) {
                  final products = value.docs.expand((e) => e["product"]).toList();
                  precacheAllImages(products);

                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.docs.length,
                      itemBuilder: (context, index) {
                        final user = value.docs[index];

                        return Column(
                          children: [
                            user["product"].isEmpty
                                ? Container()
                                : buildprofilewidget(user, profile, context),
                            const SizedBox(height: 10),
                            user["product"].isEmpty
                                ? Container()
                                : SizedBox(
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: user["product"].length,
                                itemBuilder: (context, index) {
                                  final product = user["product"][index];
                                  return  buildProductCard(context, product,user);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
                error: (error, stack) => Text(error.toString()),
                loading: () => ProductShimmer(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).brightness== Brightness.dark
        ? AppColors.secondaryButtonDarkMode
        : AppColors.secondaryButtonLightMode,
        onPressed: () {
          addproductdialog(context, ref);
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}





















