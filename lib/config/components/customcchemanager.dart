
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCacheManager {
  static final instance = CacheManager(
    Config(
      'productCacheKey',
      stalePeriod: const Duration(days: 30), // 1 mahine tk cache valid
      maxNrOfCacheObjects: 200, // 200 images cache kr skte ho
      repo: JsonCacheInfoRepository(databaseName: 'productCache'),
      fileService: HttpFileService(),
    ),
  );
}




class ProductImage extends StatelessWidget {
  final String url;

  final double height;

  const ProductImage({super.key, required this.url,this.height = 160});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,

      cacheManager: MyCacheManager.instance,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: CupertinoColors.systemGrey4,
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      errorWidget: (context, url, error) =>
          Image.asset("assets/images/ec.png", fit: BoxFit.cover),
    );
  }
}


Future<void> precacheAllImages(List products) async {
  await Future.wait(
    products.map((product) async {
      final url = product["image"][0];
      if (url.isNotEmpty) {
        await MyCacheManager.instance.downloadFile(url);
      }
    }),
  );
}
