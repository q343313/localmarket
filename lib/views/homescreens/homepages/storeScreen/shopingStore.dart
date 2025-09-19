import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:localmarket/riverpad/googleAdsRiverpad/googleAdsProvider.dart';
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
    super.initState();
    final adsNotifier = ref.read(googleAdsProvider.notifier);
    adsNotifier.initializeBannerAd();
    adsNotifier.initializeInterstitialAd();
    adsNotifier.initializeRewardedAd();
  }


  @override
  Widget build(BuildContext context) {
    final database = ref.watch(firebasedata);
    final profile = ref.watch(profileproviders);
    final ads  = ref.watch(googleAdsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Products",
        ),
        actions: [
          IconButton(onPressed: ()async{
            if(ads.isInterstitialLoaded){
              ads.interstitialAd?.show();
            }else{
              ref.read(googleAdsProvider.notifier).initializeInterstitialAd();
            }
          }, icon: Icon(Icons.ads_click))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: [
              Consumer(builder: (context,ref,_){
                final ads = ref.watch(googleAdsProvider);
               return ads.isBannerLoaded?Container(
                 width: ads.bannerAd!.size.width.toDouble(),
                 height: ads.bannerAd!.size.height.toDouble(),
                 child: AdWidget(ad: ads.bannerAd!),
               )
                   :Container();
              }),
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
                loading: () => const CupertinoActivityIndicator(color: CupertinoColors.activeBlue),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addproductdialog(context, ref);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}






















