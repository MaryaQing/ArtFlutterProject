import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// استيرادات الصفحات - تأكد من مطابقتها لمشروعك
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistsPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/InspirationPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/WeeklyChallengePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/HomePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistHistoryPage.dart';

class CustomNavigationHeader extends StatelessWidget {
  final int currentIndex;
  final double screenWidth;
  const CustomNavigationHeader({super.key, required this.currentIndex, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Home', 'page': const Homepage()},
      {'title': 'Inspiration', 'page': const Inspirationpage()},
      {'title': 'Weekly Challenge', 'page': const Weeklychallengepage()},
      {'title': 'Artists', 'page': const Artistspage()},
      {'title': 'Artist in History', 'page': const ArtistHistoryPage()},
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: screenWidth * 0.03, // مسافة نسبية بين الروابط
          runSpacing: 10,
          children: menuItems.asMap().entries.map((entry) {
            bool isActive = currentIndex == entry.key;
            return InkWell(
              onTap: () {
                if (!isActive) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => entry.value['page']));
                }
              },
              child: Text(
                entry.value['title'],
                style: GoogleFonts.inter(
                  fontSize: screenWidth < 400 ? 12 : 15, // تصغير الخط في الجوالات الصغيرة جداً
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.amber : Colors.white,
                  decoration: isActive ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}