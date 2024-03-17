import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PizzaController extends GetxController {
  var counter = 0.obs;
  XFile? imageFile;

  // Future getImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     imagePath.value = image.path.toString();
  //   }
  // }

  void addImage(XFile? image) {
    imageFile = image;
    update();
  }

  uuu(vv) {
    counter.value = vv;
    update();
  }

  void getFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  decrement() {
    if (counter.value > 0) {
      counter.value--;
      update();
    }
    ;
  }

  increment() {
    counter.value++;
    update();
  }
}
