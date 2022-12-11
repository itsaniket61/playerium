import 'package:get/get.dart';

class PlaylistAreaController extends GetxController {
  var isExpanded = false.obs;

  expand() {
    isExpanded.value = !isExpanded.value;
    refresh();
  }
}
