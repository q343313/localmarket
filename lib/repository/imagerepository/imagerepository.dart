


import 'package:image_picker/image_picker.dart';
import 'package:localmarket/repository/imagerepository/imageservics.dart';

class ImageRepository extends ImageServices{

  final _picked = ImagePicker();

  @override
  Future<XFile?> cameraimage()async{
   final XFile?imagepath= await _picked.pickImage(source: ImageSource.camera,imageQuality: 80);
    return imagepath;
  }

  @override
  Future<XFile?> galleryimage()async{
    final XFile?imagepath= await _picked.pickImage(source: ImageSource.gallery,imageQuality: 80);
    return imagepath;
  }

}