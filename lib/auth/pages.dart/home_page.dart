import 'package:flutter/material.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/artists_page.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/weekly_challenge_page.dart';
import 'package:google_fonts/google_fonts.dart';
// استيرادات الصفحات
import 'package:flutterdatabaseproject/auth/pages.dart/artist_history_page.dart';
import 'package:flutterdatabaseproject/widgets/custom_footer.dart';
import 'package:flutterdatabaseproject/widgets/custom_navigation_header.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFF372414),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomNavigationHeader(currentIndex: 0, screenWidth: screenWidth),
            
            _HeroSection(
              screenWidth: screenWidth, 
              screenHeight: screenHeight, 
              isMobile: isMobile,
              isTablet: isTablet,
            ),
            
            const SizedBox(height: 40),
            MainBoxes(screenWidth: screenWidth),
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
    double sectionHeight = isMobile ? screenHeight * 0.6 : screenHeight * 0.85;

    return Container(
      width: screenWidth,
      height: sectionHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                    fontSize: 100, 
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/vinchi1.png",
              height: isMobile ? sectionHeight * 0.6 : sectionHeight * 0.7,
              fit: BoxFit.contain,
            ),
          ),

          if (!isMobile) ...[
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
                        color: const Color(0xFFA08264).withOpacity(0.3),
                        blurRadius: 40,
                        offset: const Offset(0, 30),
                      )
                    : BoxShadow(
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
          color: Colors.white70,
          fontSize: widget.screenWidth * 0.01 + 6,
        ),
      ),
    );
  }
}
/* ================= MAIN BOXES ================= */
class MainBoxes extends StatelessWidget {
  final double screenWidth;
  const MainBoxes({required this.screenWidth, super.key});

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
            height: isMobile ? 250 : 400,
          ),
          const SizedBox(height: 50),
          InfoRowCard(
            context: context,
            img: "assets/images/flower.jpeg",
            title: "Artists Around the World",
            isMobile: isMobile,
            reverse: false,
          ),
          const SizedBox(height: 50),
          InfoRowCard(
            context: context,
            img: "assets/images/flower2.jpeg",
            title: "Weekly Challenge",
            isMobile: isMobile,
            reverse: !isMobile,
          ),
        ],
      ),
    );
  }
}

/// ==================== InfoRowCard Widget ====================
class InfoRowCard extends StatelessWidget {
  final BuildContext context;
  final String img;
  final String title;
  final bool isMobile;
  final bool reverse;

  const InfoRowCard({
    required this.context,
    required this.img,
    required this.title,
    required this.isMobile,
    required this.reverse,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget clickableCard = InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (title == "Artists Around the World") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ArtistsPage()),
          );
        } else if (title == "Weekly Challenge") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WeeklyChallengePage()),
          );
        }
      },
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage("assets/images/placeholder.png"),
            image: AssetImage(img),
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[800],
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.white, size: 40),
                ),
              );
            },
          ),
        ),
      ),
    );

     List<Widget> items = [
      Expanded(flex: isMobile ? 0 : 1, child: clickableCard),
      SizedBox(width: isMobile ? 0 : 30, height: isMobile ? 20 : 0),
      Expanded(
        flex: isMobile ? 0 : 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.playfairDisplay(fontSize: 30, color: Colors.white)),
            const SizedBox(height: 10),
            Text(
              "Discover talented creators and their visions.",
              style: GoogleFonts.inter(color: Colors.white60, fontSize: 24),
            ),
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