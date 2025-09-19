


import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localmarket/main.dart';
import 'package:localmarket/repository/imagerepository/imagerepository.dart';

final imageproviders = StateNotifierProvider<ImageNotifier,ImageStates>((ref)=>ImageNotifier(getIt()));

class ImageNotifier extends StateNotifier<ImageStates>{
  final ImageRepository imageRepository;
  ImageNotifier(this.imageRepository):super(ImageStates());

  void cameraimage()async{
    final image = await imageRepository.cameraimage();
    state = state.copyWith(imagepath: image);
  }


  void galleyimage()async{
    final image = await imageRepository.galleryimage();
    state = state.copyWith(imagepath: image);
  }

  void deleteimage(){
    state = state.copyWith(imagepath: null);
  }
}

class ImageStates {
  final XFile?imagepath;
  ImageStates({this.imagepath});
  ImageStates copyWith({XFile?imagepath}){
    return ImageStates(imagepath: imagepath);
  }
}