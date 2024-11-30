import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppie_mart/app/modules/dashboard/controllers/dashboard_controller.dart';

class CustomBottomNavigationBar extends GetView<DashboardController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: const BoxDecoration(color: Colors.black),
        child: Obx(() {
          return Row(
            children: [
              for (var i = 0; i < _navItems.length; i++)
                Expanded(
                  child: GestureDetector(
                      onTap: () => controller.setIndex(i),
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller.currentIndex == i
                                ? const Color(0xffF2F2F2).withOpacity(0.1)
                                : Colors.black),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(_navItems[i].icon,
                                  color: Colors.white),
                              const SizedBox(height: 5),
                              Text(_navItems[i].label,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10))
                            ]),
                      )),
                )
            ],
          );
        }));
  }
}

class NavItem {
  final String icon;
  final String label;
  const NavItem(this.icon, this.label);
}

const List<NavItem> _navItems = [
  NavItem('assets/images/product_icon.png', 'Products'),
  NavItem('assets/images/category_icon.png', 'Categories'),
  NavItem('assets/images/fav_icon.png', 'Favorites'),
  NavItem('assets/images/person_icon.png', 'Mitt Konto'),
];
