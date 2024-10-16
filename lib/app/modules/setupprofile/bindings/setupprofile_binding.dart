import 'package:get/get.dart';

import '../controllers/setupprofile_controller.dart';

class SetupprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetupprofileController>(
      () => SetupprofileController(),
    );
  }
}
