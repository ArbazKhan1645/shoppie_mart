import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/categories_home_controller.dart';

class CategoriesHomeView extends GetView<CategoriesHomeController> {
  const CategoriesHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CategoriesHomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CategoriesHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
