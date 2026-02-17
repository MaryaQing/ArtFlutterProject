import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// استيرادات الصفحات
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistsPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistHistoryPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/InspirationPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/WeeklyChallengePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/custom_footer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // Media Query لضبط كل الأبعاد بناءً على حجم الشاشة
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    // تعريف متغيرات الأحجام بناءً على العرض
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFF372414),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // الهيدر الموسط
            CustomNavigationHeader(currentIndex: 0, screenWidth: screenWidth),
            
            // قسم الهيرو (الذي يحتوي الصور الجانبية المكيّفة)
            _HeroSection(
              screenWidth: screenWidth, 
              screenHeight: screenHeight, 
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            
            const SizedBox(height: 40),
            _MainBoxes(screenWidth: screenWidth),
            const SizedBox(height: 80),
            _CardsSection(screenWidth: screenWidth),
            const SizedBox(height: 100),
           
            /// ===== FOOTER =====
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}

/* ================= HEADER ================= */

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
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  fontSize: screenWidth < 400 ? 14 : 18, // تصغير الخط في الجوالات الصغيرة جداً
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

/* ================= HERO SECTION (Full Responsive) ================= */

class _HeroSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isMobile;
  final bool isTablet;

  const _HeroSection({
    required this.screenWidth, 
    required this.screenHeight, 
    required this.isMobile,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    // ارتفاع القسم يتغير حسب الجهاز لضمان عدم خروج الصور
    double sectionHeight = isMobile ? screenHeight * 0.6 : screenHeight * 0.85;

    return Container(
      width: screenWidth,
      height: sectionHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // العنوان الرئيسي - FittedBox يضمن أن النص لا يخرج أبداً
          Positioned(
            top: 20,
            child: SizedBox(
              width: screenWidth * 0.9,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Welcome\nTo the artist world",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.w800,
                    height: 1,
                    color: Colors.white,
                    fontSize: 100, // سيتم تصغيرها تلقائياً بواسطة FittedBox
                  ),
                ),
              ),
            ),
          ),

          // صورة دافينتشي (الأساسية) - تتغير حجمها نسبياً
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/vinchi1.png",
              height: isMobile ? sectionHeight * 0.6 : sectionHeight * 0.7,
              fit: BoxFit.contain,
            ),
          ),

          // الصور الجانبية - تظهر في التابلت والديسكتوب فقط لعدم زحمة الجوال
          if (!isMobile) ...[
            // اليمين
            Positioned(
              right: screenWidth * 0.03,
              bottom: sectionHeight * 0.1,
              child: _SideImageCard(
                screenWidth: screenWidth,
                image: "assets/images/bg.jpeg",
                text: "Explore the genius\nbehind the vision",
                isTextTop: true,
              ),
            ),
            // اليسار
            Positioned(
              left: screenWidth * 0.03,
              bottom: sectionHeight * 0.25,
              child: _SideImageCard(
                screenWidth: screenWidth,
                image: "assets/images/bg.jpeg",
                text: "Explore the genius\nbehind the vision",
                isTextTop: false,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
class _SideImageCard extends StatefulWidget {
  final double screenWidth;
  final String image;
  final String text;
  final bool isTextTop;
  const _SideImageCard({
    required this.screenWidth,
    required this.image,
    required this.text,
    required this.isTextTop,
  });

  @override
  State<_SideImageCard> createState() => _SideImageCardState();
}

class _SideImageCardState extends State<_SideImageCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double cardSize = widget.screenWidth * 0.18;
    if (cardSize > 200) cardSize = 200;
    if (cardSize < 120) cardSize = 120;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isTextTop) _buildLabel(),
          AnimatedContainer(
            duration: const Duration(milliseconds: 350), // انتقال ناعم للظل
            width: cardSize,
            height: cardSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), // rounded-md
              boxShadow: [
                isHovered
                    ? BoxShadow(
                        // تأثير الهوفر: rgba(160,130,100,0.3) مع إزاحة 30px
                        color: const Color(0xFFA08264).withOpacity(0.3),
                        blurRadius: 40,
                        offset: const Offset(0, 30),
                      )
                    : BoxShadow(
                        // التأثير العادي: rgba(0,0,0,0.9) مع إزاحة 25px
                        color: Colors.black.withOpacity(0.9),
                        blurRadius: 36,
                        offset: const Offset(0, 25),
                      ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover, // object-cover
              ),
            ),
          ),
          if (!widget.isTextTop) _buildLabel(),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: GoogleFonts.robotoMono(
          color: Colors.white70, // النص يبقى ثابت كما طلبتِ
          fontSize: widget.screenWidth * 0.01 + 6,
        ),
      ),
    );
  }
}
/* ================= MAIN BOXES ================= */

class _MainBoxes extends StatelessWidget {
  final double screenWidth;
  const _MainBoxes({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    bool isMobile = screenWidth < 800;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        children: [
          HoverImageBox(
            image: "assets/images/artists.png", 
            title: "Artist in History", 
            height: isMobile ? 250 : 400
          ),
          const SizedBox(height: 50),
          _infoRow("assets/images/flower.jpeg", "Artists Around the World", isMobile, false),
          const SizedBox(height: 50),
          _infoRow("assets/images/flower2.jpeg", "Weekly Challenge", isMobile, !isMobile),
        ],
      ),
    );
  }

  Widget _infoRow(String img, String title, bool isMobile, bool reverse) {
    List<Widget> items = [
      Expanded(flex: isMobile ? 0 : 1, child: HoverImageBox(image: img, title: title, height: 220)),
      SizedBox(width: isMobile ? 0 : 30, height: isMobile ? 20 : 0),
      Expanded(
        flex: isMobile ? 0 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.playfairDisplay(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 10),
            Text("Discover talented creators and their visions.",style: GoogleFonts.inter(color: Colors.white60,fontSize:24)),
          ],
        ),
      ),
    ];
    return isMobile ? Column(children: items) : Row(children: reverse ? items.reversed.toList() : items);
  }
}

/* ================= OTHER COMPONENTS ================= */

class HoverImageBox extends StatelessWidget {
  final String image;
  final String title;
  final double height;
  const HoverImageBox({required this.image, required this.title, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(title, textAlign: TextAlign.center, style: GoogleFonts.playfairDisplay(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _CardsSection extends StatelessWidget {
  final double screenWidth;
  const _CardsSection({required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: const [
        SmallCard("Artists", "assets/images/mon.jpeg"),
        SmallCard("History", "assets/images/lilies.jpeg"),
        SmallCard("Challenge", "assets/images/monbg.jpg"),
        SmallCard("Inspiration", "assets/images/monset.jpeg"),
      ],
    );
  }
}

class SmallCard extends StatelessWidget {
  final String title;
  final String image;
  const SmallCard(this.title, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Text(title, style: GoogleFonts.inter(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}