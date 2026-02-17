import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistsPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistHistoryPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/HomePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/custom_footer.dart';

class Weeklychallengepage extends StatefulWidget {
  const Weeklychallengepage({super.key});

  @override
  State<Weeklychallengepage> createState() => _WeeklyChallengePageState();
}

class _WeeklyChallengePageState extends State<Weeklychallengepage> {
 // final PageController _pageController = PageController();
/// قائمة بيانات الفنانين
final List<Map<String, String>> artists = [
  {
    "name": "Ahmed Ali",
    "handle": "@ahmed_art",
    "description": "Digital illustrator inspired by fantasy & emotion.",
    "image": "assets/images/gg3.jpg",
  },
  {
    "name": "Sara Omar",
    "handle": "@sara_art",
    "description": "Painter specialized in watercolor landscapes.",
    "image": "assets/images/ramprant3.jpeg",
  },
  {
    "name": "Mohamed Fathy",
    "handle": "@mohamed_art",
    "description": "3D artist & sculptor, exploring modern abstract forms.",
    "image": "assets/images/monset2.jpg",
  },
  {
    "name": "Lina Hassan",
    "handle": "@lina_art",
    "description": "Graphic designer focusing on minimalism & color theory.",
    "image": "assets/images/mona.jpeg",
  },
];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 700;
    final crossAxisCount =
        size.width > 1000 ? 4 : size.width > 600 ? 2 : 1;

    return Scaffold(
      backgroundColor: const Color(0xFF2B1A0F),
      body: CustomScrollView(
        slivers: [

          /// ===== NAVIGATION HEADER =====
          SliverToBoxAdapter(
            child: CustomNavigationHeader(
              currentIndex: 2,
              screenWidth: size.width,
            ),
          ),

          /// ===== HERO SECTION =====
          SliverToBoxAdapter(
            child: _buildHeroSection(size, isTablet),
          ),

          /// ===== SUBMIT SECTION =====
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  "SEND YOUR DRAWING",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA08264),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Submit Now",
                    style: TextStyle(
                      color: Color(0xFF2B1A0F),
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),

          /// ===== GRID =====
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildArtCard(index),
                childCount: 8,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
            ),
          ),

          
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
            /// ===== FOOTER =====
          SliverToBoxAdapter(
            child: const CustomFooter(),
          ),
        ],
      ),
    );
  }

  /// ================= HERO =================
  Widget _buildHeroSection(Size size, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? size.width * 0.1 : 20,
        vertical: 60,
      ),
      child: Container(
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: const Color(0xFF372414),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 50,
              offset: const Offset(0, 25),
            )
          ],
        ),
        child: isTablet
            ? Row(
                children: [
                  Expanded(child: _heroText(isTablet)),
                  const SizedBox(width: 60),
                  _heroImage(),
                ],
              )
            : Column(
                children: [
                  _heroText(isTablet),
                  const SizedBox(height: 40),
                  _heroImage(),
                ],
              ),
      ),
    );
  }

  Widget _heroText(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weekly Art Challenge",
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontSize: isTablet ? 46 : 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          "Every week we explore a new theme.\nExpress your creativity and join the challenge.",
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 16,
            height: 1.6,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _heroImage() {
    return GestureDetector(
      onTap: _showStackPopup,
      child: Container(
        height: 260,
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            "assets/images/monaframe.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /// ================= POPUP =================
  void _showStackPopup() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (_) {
        bool expanded = false;

        return StatefulBuilder(
          builder: (context, setState) {

  final size = MediaQuery.of(context).size;
  final isMobile = size.width < 600;

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Center(
                child: Stack(
                  children: [

                    /// زر اغلاق
                    Positioned(
                      top: 50,
                      right: 40,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2B1A0F),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white),
                          ),
                          child: const Center(
                            child: Text(
                              "×",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Center(
                      
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => expanded = !expanded),
                            
                       child: SizedBox(
  width: isMobile ? size.width * 0.9 : 700,
  height: isMobile ? size.height * 0.6 : 400,

                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                           AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: expanded ? 0 : (isMobile ? size.width * 0.3 : 250),
  child: _stackCard("assets/images/ramprant5.jpeg"),
),

                           AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: expanded
      ? (isMobile ? size.width * 0.3 : 250)
      : (isMobile ? size.width * 0.32 : 260),
  child: _stackCard("assets/images/gg5.jpeg"),
),

                           AnimatedPositioned(
  duration: const Duration(milliseconds: 500),
  left: expanded
      ? (isMobile ? size.width * 0.6 : 500)
      : (isMobile ? size.width * 0.34 : 270),
  child: _stackCard("assets/images/gg2.jpg"),
),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _stackCard(String image) {
     final size = MediaQuery.of(context).size;
  final isMobile = size.width < 600;
    return Container(
     width: isMobile ? size.width * 0.6 : 220,
    height: isMobile ? size.height * 0.45 : 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 25,
            offset: const Offset(0, 15),
          )
        ],
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// ================= GRID CARD =================
  Widget _buildArtCard(int index) {
  bool isHovered = false;
  final artist = artists[index % artists.length]; // لتكرار البيانات لو عدد الكاردات أكبر

  return StatefulBuilder(builder: (context, setState) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              /// صورة الفنان
              Positioned.fill(
                child: Image.asset(
                  artist['image']!,
                  fit: BoxFit.cover,
                ),
              ),

              /// خلفية عند hover
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isHovered ? 1 : 0,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),

              /// معلومات الفنان عند hover
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: isHovered ? 20 : -120,
                left: 15,
                right: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      artist['name']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      artist['handle']!,
                      style: const TextStyle(
                        color: Color(0xFFA08264),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      artist['description']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

}

class CustomNavigationHeader extends StatelessWidget {
  final int currentIndex;
  final double screenWidth;
  const CustomNavigationHeader({super.key, required this.currentIndex, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Home', 'page': const Homepage()},
      {'title': 'Weekly Challenge', 'page': const Weeklychallengepage()},
      {'title': 'Artists', 'page': const Artistspage()},
      {'title': 'Artist in History', 'page': const ArtistHistoryPage()},
    ];

    return Center(
      child: Padding(
padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: screenWidth * 0.03,
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
                  fontSize: screenWidth < 400 ? 14 : 18,
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
