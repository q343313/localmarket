


import 'package:flutter_riverpod/legacy.dart';

import '../../main.dart';
import 'loginnotifier.dart';
import 'loginstates.dart';


final loginprovider = StateNotifierProvider<Loginnotifier,Loginstates>((reg)=>Loginnotifier(getIt()));