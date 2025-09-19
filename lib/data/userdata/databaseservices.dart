

import '../../allpaths.dart';

abstract class DatabaseServices {

  createUserProfile(ProfileModels profilemodels);
  updateUserProfile(UpdateModels updateModels);
  deleteUserProfile();
  addProduct(ProductModel productModels);
  addProfileImage(String image);
  addCraftProduct(dynamic lis);
  addNotification(RemoteMessage message);
  deleteProfileImage();
  seenNotification();
  deleteNotification(String id);
  numberUnSeenNotification();
  addFavoriteProduct(product);
  deleteValueCraft(value);
  changeUserPassword(String password);
}