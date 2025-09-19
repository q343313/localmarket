

import 'package:flutter_riverpod/legacy.dart';

import 'defaultstates.dart';

final defaultprovidders= StateNotifierProvider<DefaultNotifier,DefaultStates>((ref)=>DefaultNotifier());

class DefaultNotifier extends StateNotifier<DefaultStates>{
  DefaultNotifier():super(DefaultStates());

  showpassword(){
    state = state.copyWith(showpassord: !state.showpassord);
  }

showcheckbox(){
    state = state.copyWith(checkbox: !state.checkbox);
}

}