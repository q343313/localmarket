import 'package:cloud_firestore/cloud_firestore.dart';
import '../../allpaths.dart';

class CraftNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  CraftNotifier() : super([]);

  /// check if product already exists
  bool isExists(Map<String, dynamic> product) {
    return state.any((e) =>
    e is Map<String, dynamic> &&
        e["product"]?["name"] == product["name"]);
  }

  /// add / remove ek hi product
  Future<void> toggleFavorite(
      Map<String, dynamic> product, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString("email");
    final doc = FirebaseFirestore.instance.collection("owners").doc(email);
    final snapshot = await doc.get();

    // firestore se current craft
    final currentCraft = (snapshot.data()?["craft"] ?? [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    final productName = product["name"];

    if (isExists(product)) {
      // ✅ local se remove
      state = state
          .where((e) => e["product"]?["name"] != productName)
          .toList();

      // ✅ firestore se remove
      final updatedCraft = currentCraft
          .where((e) => e["product"]?["name"] != productName)
          .toList();

      await doc.update({"craft": updatedCraft});
    } else {
      // ✅ sirf ek product + minimal user info save karo
      final newCraftItem = {
        "product": product,
        "useremail": user["useremail"], // 👈 only email, not full user object
      };

      // local state
      state = [...state, newCraftItem];

      // firestore me add
      await doc.update({
        "craft": FieldValue.arrayUnion([newCraftItem])
      });
    }
  }
}

final craftProvider =
StateNotifierProvider<CraftNotifier, List<Map<String, dynamic>>>(
        (ref) => CraftNotifier());
