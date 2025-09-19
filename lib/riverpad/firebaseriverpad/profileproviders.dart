

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localmarket/allpaths.dart';

final profileproviders = FutureProvider((ref)async{
  var pref  = await SharedPreferences.getInstance();
  final email = pref.getString("email").toString();
  return email;
});