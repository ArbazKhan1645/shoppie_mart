import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitleBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;
  final double? padding;

  const CustomTitleBar(
      {super.key,
      required this.title,
      required this.onBackPressed,
      this.padding});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double defaultPadding = padding ?? 15.0;

    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.10),
        ],
      ),
    );
  }
}
