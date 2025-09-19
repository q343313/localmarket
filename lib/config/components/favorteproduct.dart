


import 'package:flutter/cupertino.dart';

import '../../allpaths.dart';
import 'customcchemanager.dart';

Widget buildFavorProductCard(BuildContext context, Favoritemodels userr) {
  return Consumer(builder: (context,ref,_){
    final data = ref.watch(firebasedata);
    return data.when(data: (value){
      final neuser = value.docs.where((e)=>e["useremail"] == userr.useremail).toList();

      return  InkWell(

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                product: userr.product,
                user: neuser[0],
              ),
            ),
          );
        },
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade900
              : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Image section (fixed height)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: SizedBox(
                      height: 120, // 👈 fixed height
                      width: double.infinity,
                      child: ProductImage(
                        url: userr.product["image"][0],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.black45,
                      child: Consumer(builder: (context, ref, _) {
                        return IconButton(
                          onPressed: () {
                            ref
                                .read(favoriteProvider.notifier)
                                .deleteFavorite(userr.userid!);
                          },
                          icon: const Icon(Icons.favorite, color: Colors.red),
                        );
                      }),
                    ),
                  ),
                ],
              ),

              // 🔹 Text + details section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👈 no overflow
                    children: [
                      Text(
                        userr.product["name"],
                        style: const TextStyle(
                          fontFamily: "title",
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${userr.product["price"]} PKR",
                        style: TextStyle(
                          fontFamily: "body_c",
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }, error: (errr,sta)=>Text(errr.toString()), loading: ()=>CupertinoActivityIndicator());
  });
}