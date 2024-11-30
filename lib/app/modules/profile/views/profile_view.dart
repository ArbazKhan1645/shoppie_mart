import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              Container(
                color: Colors.black,
                height: 150,
                width: MediaQuery.of(context).size.width - 40,
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/setting_icon.png'),
                      radius: 24.0,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'My Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              _buildMenuItem(
                imagePath: 'assets/images/setting_icon.png',
                title: 'Kontoinställningar',
              ),
              const SizedBox(height: 16.0),
              _buildMenuItem(
                imagePath: 'assets/images/setting_icon.png',
                title: 'Mina betalmétoder',
              ),
              const SizedBox(height: 16.0),
              _buildMenuItem(
                imagePath: 'assets/images/setting_icon.png',
                title: 'Support',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String imagePath,
    required String title,
  }) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 24.0,
          height: 24.0,
          color: Colors.black,
        ),
        const SizedBox(width: 16.0),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
