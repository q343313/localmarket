


import 'package:localmarket/allpaths.dart';
//
// final firebaseproviders = StreamNotifierProvider((ref)=>FirebaseStream(getIt()));
//
// class FirebaseStream extends StreamNotifier{
//   final AddUserData addUserData ;
//   FirebaseStream(this.addUserData):super();
//
//   @override
//   Stream build() {
//     return addUserData.collection2.snapshots();
//   }
// }

final firebasedata = StreamProvider((ref){
  return AddUserData().collection2.snapshots();
});