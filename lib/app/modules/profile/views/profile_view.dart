import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  static const double avatarRadius = 40.0;
  static const double containerPadding = 8.0;
  static const double menuItemHeight = 16.0;
  static const double titleFontSize = 24.0;
  static const double subtitleFontSize = 14.0;
  static const double textFontSizeSmall = 10.0;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(15.0);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTitle(),
              const SizedBox(height: 12.0),
              _buildProfileCard(context, screenWidth),
              SizedBox(height: screenHeight * 0.08),
              _buildMenu(context, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: defaultPadding,
      child: Text(
        'Mitt konto',
        style: GoogleFonts.poppins(
          fontSize: titleFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 150,
      width: screenWidth - 40,
      child: Padding(
        padding: const EdgeInsets.all(containerPadding),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: avatarRadius,
            ),
            const SizedBox(width: 20.0),
            _buildProfileDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'My Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'myname@gmail.com',
            style: TextStyle(
              color: Colors.grey,
              fontSize: textFontSizeSmall,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '07XXXXXXXX',
            style: TextStyle(
              color: Colors.grey,
              fontSize: textFontSizeSmall,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
      ),
      child: Column(
        children: [
          _buildMenuItem(
            imagePath: 'assets/images/setting_icon.png',
            title: 'Kontoinställningar',
          ),
          const SizedBox(height: menuItemHeight),
          _buildMenuItem(
            imagePath: 'assets/images/mina_icon.png',
            title: 'Mina betalmétoder',
          ),
          const SizedBox(height: menuItemHeight),
          _buildMenuItem(
            imagePath: 'assets/images/support_icon.png',
            title: 'Support',
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required String imagePath, required String title}) {
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
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: subtitleFontSize,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
