


//
import 'package:image_picker/image_picker.dart';

abstract class ImageServices {
  Future<XFile?>galleryimage();
  Future<XFile?>cameraimage();
}