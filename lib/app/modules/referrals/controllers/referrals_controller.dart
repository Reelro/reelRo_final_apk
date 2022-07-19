import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class ReferralsController extends GetxController {
  //TODO: Implement ReferralsController
  final _authService = Get.put(AuthService());
  String? get token => _authService.token;
  int? get profileId => _authService.profileModel?.id;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}