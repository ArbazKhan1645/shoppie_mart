import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoppie_mart/app/modules/dashboard/widgets/custom_navbar.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: controller.screens[controller.currentIndex],
              bottomNavigationBar: const CustomBottomNavigationBar());
        });
  }
}
