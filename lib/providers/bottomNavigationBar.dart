import 'package:get/get.dart';

class BottomNavAppBar extends GetxController {
  int index = 0;

  get bottomNavIndex => index;

  void changePage(int page) {
    index = page;
  }
}
