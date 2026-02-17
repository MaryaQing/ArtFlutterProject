import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      decoration: const BoxDecoration(
        color: Color(0xFF372414),
        border: Border(
          top: BorderSide(color: Color(0xFFA08264), width: 0.5),
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _leftSection(),
                const SizedBox(height: 30),
                _centerSection(),
                const SizedBox(height: 30),
                _rightSection(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _leftSection(),
                _centerSection(),
                _rightSection(),
              ],
            ),
    );
  }

  /// ===== RIGHT (اسم الموقع) =====
  Widget _leftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ART GALLERY",
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Designed by YourName",
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  /// ===== CENTER (سوشال) =====
  Widget _centerSection() {
    return Column(
      children: [
        Text(
          "Follow Us",
          style: GoogleFonts.inter(
            color: const Color(0xFFA08264),
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _socialIcon(Icons.facebook),
            const SizedBox(width: 15),
            _socialIcon(Icons.camera_alt), // Instagram
            const SizedBox(width: 15),
            _socialIcon(Icons.alternate_email), // Twitter
          ],
        )
      ],
    );
  }

  /// ===== LEFT (الدعم الفني) =====
  Widget _rightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Support",
          style: GoogleFonts.inter(
            color: const Color(0xFFA08264),
            fontSize: 16,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "support@artgallery.com",
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  /// ===== Social Icon Style =====
  Widget _socialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFA08264)),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
