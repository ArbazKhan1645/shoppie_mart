import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) => Scaffold(body: _buildSplashScreenBody(context)),
    );
  }

  Widget _buildSplashScreenBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundImage(),
        _buildGradientOverlay(),
        _buildContentColumn(context)
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset('assets/images/splash.png', fit: BoxFit.cover);
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0C0C0C).withOpacity(0),
            const Color(0xFF0C0C0C).withOpacity(0.95)
          ],
        ),
      ),
    );
  }

  Widget _buildContentColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.08,
          left: MediaQuery.of(context).size.width * 0.10,
          right: MediaQuery.of(context).size.width * 0.10,
          bottom: MediaQuery.of(context).size.height * 0.15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildTitleText(), _buildDescriptionTexts()]),
    );
  }

  Widget _buildTitleText() {
    return Text('My Store',
        style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w400, color: Colors.black, fontSize: 50));
  }

  Widget _buildDescriptionTexts() {
    return Column(
      children: [
        Text(
          'Valkommen',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 10),
        Text(
          'Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
