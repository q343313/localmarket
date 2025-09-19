


import 'package:flutter_riverpod/legacy.dart';
import 'package:localmarket/riverpad/signupprovider/signupnotifier.dart';
import 'package:localmarket/riverpad/signupprovider/signupstates.dart';

import '../../main.dart';


final signupproviders = StateNotifierProvider<SignupNotifier,SignupStates>((ref)=>SignupNotifier(getIt()));