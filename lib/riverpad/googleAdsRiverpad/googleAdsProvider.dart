//

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../allpaths.dart';
import '../../data/adsdata/googleadsimplemensts.dart'; // Your AdsHelpers import

/// Provider
final googleAdsProvider = StateNotifierProvider<AdsNotifier, AdsState>(
      (ref) => AdsNotifier(),
);

class AdsNotifier extends StateNotifier<AdsState> {
  AdsNotifier() : super(AdsState());

  late BannerAd bannerAds;
  late InterstitialAd _interstitialAd;
  late RewardedAd? _rewardedAd;

  /// Initialize Banner Ad
  void initializeBannerAd()async{
    bannerAds = BannerAd(size: AdSize.banner
        , adUnitId:"ca-app-pub-3940256099942544/6300978111"
        , listener: BannerAdListener(
            onAdLoaded: (ad){
              state  = state.copyWith(isBannerLoaded: true);
            },onAdClosed: (ads){
          state  = state.copyWith(isBannerLoaded: false);
        },onAdFailedToLoad: (ad,error){
              print(error.toString());
          state  = state.copyWith(isBannerLoaded: false);
        }
        ),
        request: AdRequest());

    await bannerAds.load();
    state = state.copyWith(bannerAd: bannerAds);
  }

  /// Initialize Interstitial Ad
  void initializeInterstitialAd()async{
    await InterstitialAd.load(adUnitId:"ca-app-pub-3940256099942544/1033173712",
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ads){
              _interstitialAd = ads;
              print("Back  Add loaded");
              state = state.copyWith(interstitialAd: ads,isInterstitialLoaded: true);
              _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (ad) {
                    ad.dispose();
                    state  =state.copyWith(isInterstitialLoaded: false);
                    initializeInterstitialAd(); // yahan dubara ad load karega
                  });
            },

            // Jab ad close ho to dobara load kar
            onAdFailedToLoad: (erorr){
              state = state.copyWith(isInterstitialLoaded: false);
            }
        ));
  }

  /// Show Interstitial Ad
  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          state = state.copyWith(
            interstitialAd: null,
            isInterstitialLoaded: false,
          );
          initializeInterstitialAd(); // Load next one
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          state = state.copyWith(
            interstitialAd: null,
            isInterstitialLoaded: false,
          );
          initializeInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }



  /// Initialize Rewarded Ad
  void initializeRewardedAd() {
    RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917",
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          state = state.copyWith(
            rewardedAd: _rewardedAd,
            isRewardedLoaded: true,
          );
        },
        onAdFailedToLoad: (error) {
          state = state.copyWith(isRewardedLoaded: false);
        },
      ),
    );
  }

  /// Show Rewarded Ad
  void showRewardedAd({required void Function() onUserEarnedReward}) {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          state = state.copyWith(
            rewardedAd: null,
            isRewardedLoaded: false,
          );
          _rewardedAd = null;
          initializeRewardedAd(); // Load next one
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          state = state.copyWith(
            rewardedAd: null,
            isRewardedLoaded: false,
          );
          _rewardedAd = null;
          initializeRewardedAd();
        },
      );

      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
        onUserEarnedReward();
      });
    }
  }

  /// Dispose Ads
  @override
  void dispose() {
    bannerAds?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }
}

/// State Class
class AdsState {
  final bool isBannerLoaded;
  final bool isInterstitialLoaded;
  final bool isRewardedLoaded;
  final BannerAd? bannerAd;
  final InterstitialAd? interstitialAd;
  final RewardedAd? rewardedAd;

  const AdsState({
    this.isBannerLoaded = false,
    this.isInterstitialLoaded = false,
    this.isRewardedLoaded = false,
    this.bannerAd,
    this.interstitialAd,
    this.rewardedAd,
  });

  AdsState copyWith({
    bool? isBannerLoaded,
    bool? isInterstitialLoaded,
    bool? isRewardedLoaded,
    BannerAd? bannerAd,
    InterstitialAd? interstitialAd,
    RewardedAd? rewardedAd,
  }) {
    return AdsState(
      isBannerLoaded: isBannerLoaded ?? this.isBannerLoaded,
      isInterstitialLoaded: isInterstitialLoaded ?? this.isInterstitialLoaded,
      isRewardedLoaded: isRewardedLoaded ?? this.isRewardedLoaded,
      bannerAd: bannerAd ?? this.bannerAd,
      interstitialAd: interstitialAd ?? this.interstitialAd,
      rewardedAd: rewardedAd ?? this.rewardedAd,
    );
  }
}



//
// void initializenavad()async{
//   navad = BannerAd(
//       size: AdSize.banner,
//       adUnitId:  "ca-app-pub-3940256099942544/6300978111"
//       , listener: AdManagerBannerAdListener(
//       onAdFailedToLoad: (ad,error){
//         print("Errror ${error}");
//         isnavbannerloaded.value = false;
//       },
//       onAdClosed: (ad){
//         ad.dispose();
//         isnavbannerloaded.value = false;
//       },
//       onAdLoaded: (ad){
//         isnavbannerloaded.value = true;
//         print("Nav Add loaded");
//       }
//   ),
//       request: AdRequest());
//
//   await navad.load();
// }
//
// void initializeappad()async{
//   appadd = BannerAd(
//       size: AdSize.banner,
//       adUnitId: "ca-app-pub-3940256099942544/6300978111"
//       , listener: AdManagerBannerAdListener(
//       onAdFailedToLoad: (ad,error){
//         print("Errror ${error}");
//         isappbannerloaded.value = false;
//       },
//       onAdClosed: (ad){
//         ad.dispose();
//         isappbannerloaded.value = false;
//       },
//       onAdLoaded: (ad){
//         isappbannerloaded.value = true;
//         print("Nav Add loaded");
//       }
//   ),
//       request: AdRequest());
//
//   await appadd.load();
// }
//
// void inirializebackadd()async{
//   await InterstitialAd.load(adUnitId:"ca-app-pub-3940256099942544/1033173712",
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (ads){
//             print("Back  Add loaded");
//             backadd  =ads;
//             isbackadloaded.value = true;
//             backadd?.fullScreenContentCallback = FullScreenContentCallback(
//                 onAdDismissedFullScreenContent: (ad) {
//                   ad.dispose();
//                   isbackadloaded.value = false;
//                   inirializebackadd(); // yahan dubara ad load karega
//                 });
//           },
//
//           // Jab ad close ho to dobara load kar
//           onAdFailedToLoad: (erorr){
//             isbackadloaded .value =false;
//           }
//       ));
// }
//
//



//
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:localmarket/data/adsdata/googleadsimplemensts.dart';
//
// import '../../allpaths.dart';
//
// final googleadsprovider = StateNotifierProvider<AdsNotifiers,AdsStates>((ref)=>AdsNotifiers());
//
// class AdsNotifiers extends StateNotifier<AdsStates>{
//    BannerAd?bannerAd;
//    InterstitialAd ?interstitialAd;
//    RewardedAd ?rewardedAd;
//   AdsNotifiers():super(AdsStates());
//
// void initializebnnerads()async{
//   bannerAd = BannerAd(size: AdSize.banner
//       , adUnitId: AdsHelpers.getnavads()
//       , listener: BannerAdListener(
//         onAdLoaded: (ad){
//           state  = state.copyWith(isbanneradsloaded: true);
//         },onAdClosed: (ads){
//           state  = state.copyWith(isbanneradsloaded: false);
//       },onAdFailedToLoad: (ad,error){
//         state  = state.copyWith(isbanneradsloaded: false);
//       }
//       ),
//       request: AdRequest());
//
//   await bannerAd?.load();
//   state = state.copyWith(bannerAd: bannerAd);
// }
//
//
// void initializeintesitialads()async{
//   await InterstitialAd.load(
//       adUnitId: AdsHelpers.getbackads(),
//       request: AdRequest(), adLoadCallback:InterstitialAdLoadCallback(
//       onAdLoaded: (ad){
//         interstitialAd = ad;
//         state = state.copyWith(interstitialAd: ad,isinterialadsloaded: true);
//       },
//       onAdFailedToLoad: (error){
//         state = state.copyWith(isinterialadsloaded: false);
//       })
//   );
// }
//
// void initializerewaededadd()async{
//   await RewardedAd.load(adUnitId: AdsHelpers.getrewardads(),
//       request: AdRequest(), rewardedAdLoadCallback:RewardedAdLoadCallback(
//           onAdLoaded: (ads){
//             rewardedAd = ads;
//             state = state.copyWith(rewardedAd: ads,isrewaredadsloaded: true);
//           },
//           onAdFailedToLoad: (error){
//             print(error.toString());
//             state = state.copyWith(isrewaredadsloaded: false);
//           }
//       ) );
// }
//
// }
//
// class AdsStates {
//   final bool isbanneradsloaded ;
//   final bool isinterialadsloaded;
//   final bool isrewaredadsloaded;
//  final BannerAd?bannerAd;
//  final InterstitialAd ?interstitialAd;
//  final RewardedAd ?rewardedAd;
//
//  AdsStates({
//     this.isbanneradsloaded = false,
//    this.isinterialadsloaded= false,
//    this.isrewaredadsloaded = false,
//    this.rewardedAd,
//    this.interstitialAd,
//    this.bannerAd
// });
//
//  AdsStates copyWith({
//    bool?isbanneradsloaded ,
//     bool?isinterialadsloaded,
//     bool ?isrewaredadsloaded,
//     BannerAd?bannerAd,
//     InterstitialAd ?interstitialAd,
//     RewardedAd ?rewardedAd
// }){
//    return AdsStates(
//      isbanneradsloaded: isbanneradsloaded??this.isbanneradsloaded,
//      isinterialadsloaded: isinterialadsloaded??this.isinterialadsloaded,
//      isrewaredadsloaded: isrewaredadsloaded??this.isrewaredadsloaded,
//      bannerAd: bannerAd??this.bannerAd,
//      interstitialAd: interstitialAd??this.interstitialAd,
//      rewardedAd: rewardedAd??this.rewardedAd
//    );
//  }
//
// }