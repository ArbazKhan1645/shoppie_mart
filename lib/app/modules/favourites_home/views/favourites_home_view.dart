import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/favourites_home_controller.dart';

class FavouritesHomeView extends GetView<FavouritesHomeController> {
  const FavouritesHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavouritesHomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FavouritesHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
