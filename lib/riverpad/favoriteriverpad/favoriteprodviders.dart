import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localmarket/data/favoritedatabase/favoritedatabase.dart';
import 'package:localmarket/models/usermodels.dart';

import '../../allpaths.dart';

/// PROVIDER
final favoriteProvider =
StateNotifierProvider<FavoriteNotifier, FavoriteState>(
      (ref) => FavoriteNotifier(FavoriteDatabase()),
);

class FavoriteNotifier extends StateNotifier<FavoriteState> {
  final FavoriteDatabase _db;
  List<Favoritemodels>dynamiclis  = [];
  List<Favoritemodels> myownlis = [];
  String owneremail = "";

  FavoriteNotifier(this._db) : super(const FavoriteState()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final owneremailse = await SharedPreferences.getInstance();
      owneremail = owneremailse.getString("email").toString();
      final favorites = await _db.getAllFavorites();
      dynamiclis = favorites.where((e)=>e.owneremail == owneremail).toList();
      myownlis = dynamiclis;
      state = state.copyWith(favorites: dynamiclis, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> refreshFavorites() async => _loadFavorites();

  Future<void> addFavorite(dynamic product, dynamic user) async {
    state = state.copyWith(isLoading: true);
    try {

      final email = user["useremail"];

      final newjson = {
        "owneremail":owneremail,
        "useremail":email,
        "product":product
      };

      final model = Favoritemodels.fromJson(newjson);
      final exists = dynamiclis.contains(model);

      if (exists) {
        final toDelete = dynamiclis.firstWhere((e) => e == model);
        await _db.deleteFavoriteProduct(toDelete.userid!);
        await _loadFavorites();
      } else {
        await _db.addFavoriteProduct(model);
        await _loadFavorites();
      }

      await _loadFavorites();
    } catch (e) {
      state = state.copyWith(error: "Failed to toggle favorite: $e", isLoading: false);
    }
  }



  bool isExists(dynamic user, dynamic product){

    print("check exis");
    final email  = user["useremail"];

    final newjson = {
      "owneremail":owneremail,
      "useremail":email,
      "product":product
    };

    final model = Favoritemodels.fromJson(newjson);
    return state.favorites.contains(model);
  }


  /// Delete a favorite product by ID
  Future<void> deleteFavorite(int userid) async {
    try {
      await _db.deleteFavoriteProduct(userid);
      await _loadFavorites();
    } catch (e) {
      state = state.copyWith(error: "Failed to delete favorite: $e");
    }
  }


  searchvalue(String value){
    if(value.isEmpty){
      state = state.copyWith(favorites: dynamiclis);
    }else{
      myownlis = dynamiclis.where((e)=>e.product["name"].toString().toLowerCase().contains(value)).toList();
      state =state.copyWith(favorites: myownlis);
    }
  }
}

/// STATE
class FavoriteState {
  final List<Favoritemodels> favorites;
  final bool isLoading;
  final String? error;

  const FavoriteState({
    this.favorites = const [],
    this.isLoading = true,
    this.error,
  });

  FavoriteState copyWith({
    List<Favoritemodels>? favorites,
    bool? isLoading,
    String? error,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}






















//
//
//
// import 'package:flutter_riverpod/legacy.dart';
// import 'package:localmarket/allpaths.dart';
// import 'package:localmarket/data/favoritedatabase/favoritedatabase.dart';
// import 'package:localmarket/models/usermodels.dart';
//
// final favoriteProviders = StateNotifierProvider<FavoriteNotifier,FavoriteStates>((ref)=>FavoriteNotifier(getIt()));
//
// class FavoriteNotifier extends StateNotifier<FavoriteStates>{
//   final FavoriteDatabase favoriteDatabase;
//     List<Favoritemodels>dynamiclist = [];
//   FavoriteNotifier(this.favoriteDatabase):super(FavoriteStates(favoritelist: []));
//
//   getfavoritelistdata()async{
//     dynamiclist = await favoriteDatabase.getAllFavorites();
//     state = state.copyWith(favoritelist: dynamiclist);
//   }
//
//   addfavoriteproduct(dynamic product,dynamic user)async{
//
//     Map<String,dynamic> userjson = user;
//     userjson["product"] = product;
//     userjson.remove("userid");
//
//
//     Favoritemodels favoritemodels = Favoritemodels.fromJson(userjson);
//
//     await favoriteDatabase.addFavoriteProduct(favoritemodels);
//     dynamiclist= await favoriteDatabase.getAllFavorites();
//     state = state.copyWith(favoritelist: dynamiclist);
//   }
//
//
//   deletefavoriteproduct(userid)async{
//     await favoriteDatabase.deleteFavoriteProduct(userid);
//     dynamiclist = await favoriteDatabase.getAllFavorites();
//     state = state.copyWith(favoritelist: dynamiclist);
//   }
//
//
// }
//
// class FavoriteStates{
//     List<Favoritemodels>favoritelist;
//   FavoriteStates({required this.favoritelist});
//   FavoriteStates copyWith({List<Favoritemodels>?favoritelist}){
//     return FavoriteStates(favoritelist: favoritelist??this.favoritelist);
//   }
// }