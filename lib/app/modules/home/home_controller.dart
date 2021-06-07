import 'package:ajent/app/data/models/AjentUser.dart';
import 'package:ajent/routes/pages.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  var tabpageIndex = 0.obs;
  var isOnMain = true.obs;
  var childTabIndex = 0.obs;
  var targetPage = 0;
  var needChangeNavigator = true;
  PageController pageController = PageController();
  PanelController panelController = PanelController();
  static AjentUser mainUser;
  @override
  onInit() {
    super.onInit();
  }

  oncChildTabChanged(int index) {
    childTabIndex.value = index;
  }

  onPageChanged(int index) {
    if (index == targetPage && needChangeNavigator) {
      tabpageIndex.value = index;
    }
  }

  static checkUserUpdateInfo() {
    if (!HomeController.mainUser.isInfoUpdated()) {
      print("cc");
      Get.dialog(AlertDialog(
        title: Text('update_info_dialog_title'.tr),
        content: Text('update_info_dialog_content'.tr),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.PROFILE);
              },
              child: Text('update_info_dialog_button'.tr)),
        ],
      ));
    }
  }
}
