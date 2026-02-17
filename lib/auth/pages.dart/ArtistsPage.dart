import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
// استيرادات الصفحات
import 'package:flutterdatabaseproject/auth/pages.dart/HomePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistHistoryPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/WeeklyChallengePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/custom_footer.dart';

void main() {
  runApp(const MaterialApp(
    home: Artistspage(),
    debugShowCheckedModeBanner: false,
  ));
}

class Artistspage extends StatefulWidget {
  const Artistspage({super.key});

  @override
  State<Artistspage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<Artistspage> with TickerProviderStateMixin {
  String activeFilter = 'all';
  late AnimationController _shimmerController;
  
  // بيانات الفنانين
  final List<Map<String, dynamic>> _artists = [
    {
      'id': 'vinc_1',
      'category': 'classic',
      'name': 'Vincent van Gogh',
      'desc': 'A Dutch post-impressionist painter known for his expressive use of color and bold brushwork. His works include "Starry Night", "Sunflowers", and many more.',
      'mainImage': 'assets/images/lilies.jpeg', 
      'thumbs': ['assets/images/vango1.jpeg', 'assets/images/vango2.jpeg', 'assets/images/vango3.jpeg']
    },
    {
      'id': 'safeya_2',
      'category': 'arab',
      'name': 'Safeya Binzagr',
      'desc': 'A Saudi artist who documented traditional Saudi life through detailed and expressive paintings rooted in local culture.',
      'mainImage': 'assets/images/monbg3.jpg',
      'thumbs': ['assets/images/moneh2.jpeg', 'assets/images/monset.jpeg', 'assets/images/monbg2.jpg']
    },
    {
      'id': 'shahad_3',
      'category': 'digital',
      'name': 'Shahad',
      'desc': 'A renowned digital artist known for her expressive characters, whimsical color palettes, and dynamic compositions in digital painting.',
      'mainImage': 'assets/images/shahad1.jpeg',
      'thumbs': ['assets/images/shahad2.jpeg', 'assets/images/shahad3.jpeg', 'assets/images/shahad4.jpeg']
    },
{
      'id': 'oil_artist_1',
      'category': 'oil', // هذا هو المهم ليعمل الفلتر
      'name': 'marya',
      'desc': 'A founder of French Impressionist painting, known for his oil on canvas masterpieces capturing light and nature.',
      'mainImage': 'assets/images/flower.jpeg', // تأكد من وجود الصورة في مجلدك
      'thumbs': [
        'assets/images/tree.jpeg',
        'assets/images/sea2.jpeg',
        'assets/images/sea.jpeg'
      ]
    },

  ];

 
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF372414),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
           // نضع currentIndex: 3 لأن ترتيب Artists في قائمة الهوم هو الرابع (0,1,2,3)
            CustomNavigationHeader(currentIndex: 3, screenWidth: screenWidth),
            
            const SizedBox(height: 10),
           
            _buildHeroSection(context),
            
            const SizedBox(height: 30),
            // أزرار الفلترة (كانت مكررة وحذفت النسخة الثانية)
            _buildFilterButtons(),
            

            // قائمة الفنانين
            Column(
              children: _artists
                  .where((a) => activeFilter == 'all' || a['category'] == activeFilter)
                  .map((artist) => _buildArtistItem(artist, isMobile))
                  .toList(),
            ),
            /// ===== FOOTER =====
            const CustomFooter(),
          ],
        ),
      ),
    );
  }


Widget _buildHeroSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isMobile = screenWidth < 700;

  return Center(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      width: isMobile ? screenWidth * 0.9 : screenWidth * 0.72,
      decoration: BoxDecoration(
        color: const Color(0xFF4A3220),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF5D79E), width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 32,
          vertical: isMobile ? 24 : 36,
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Artist All Around The World",
                    style: TextStyle(
                      color: Color(0xFFFFEBC4),
                      fontSize: 32,
                      fontFamily: 'Serif',
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Get An Inspiration And More, Discover visual journeys that spark emotion and imagination.",
                    style: TextStyle(
                      color: Color(0xFFE8CC96),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/painter.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Artist All Around The World",
                          style: TextStyle(
                            color: Color(0xFFFFEBC4),
                            fontSize: 42,
                            fontFamily: 'Serif',
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Get An Inspiration And More, Discover visual journeys that spark emotion and imagination.",
                          style: TextStyle(
                            color: Color(0xFFE8CC96),
                            fontSize: 18,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/painter.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    ),
  );
}


  Widget _buildFilterButtons() {
    List<String> filters = ['all', 'classic', 'arab', 'digital', 'oil', 'water', 'sale', 'saudi', 'student'];
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      children: filters.map((f) => InkWell(
        onTap: () => setState(() => activeFilter = f),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: activeFilter == f ? const Color(0xFF5A3822) : const Color(0xFF3B2615),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            f.toUpperCase(),
            style: const TextStyle(color: Color(0xFFF5D79E), fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
      )).toList(),
    );
  }
Widget _buildArtistItem(Map<String, dynamic> artist, bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة الكبيرة
          Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF5D79E), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                artist['mainImage'], 
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          const SizedBox(width: 40, height: 20),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(artist['name'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                Text(artist['desc'], style: const TextStyle(fontSize: 18, height: 1.4, color: Colors.white70)),
                const SizedBox(height: 25),
                // الصور المصغرة مع منطق التبديل (Swap)
                Wrap(
                  spacing: 15,
                  children: (artist['thumbs'] as List).asMap().entries.map((entry) {
                    int idx = entry.key;
                    String imgPath = entry.value;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // منطق التبديل (Swap):
                          String currentMain = artist['mainImage'];
                          artist['mainImage'] = imgPath; // الصورة الصغيرة تصبح كبيرة
                          artist['thumbs'][idx] = currentMain; // الصورة الكبيرة القديمة تذهب لمكان الصغيرة
                        });
                      },
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                       child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(imgPath, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}

class SparkleWidget extends StatefulWidget {
  const SparkleWidget({super.key});
  @override
  State<SparkleWidget> createState() => _SparkleWidgetState();
}

class _SparkleWidgetState extends State<SparkleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _scale = Tween<double>(begin: 0.5, end: 1.5).animate(_ctrl);
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_ctrl);
    _ctrl.forward().then((_) { if(mounted) _ctrl.dispose(); });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.scale(
            scale: _scale.value,
            child: Container(
              width: 10, height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF5D79E),
              ),
            ),
          ),
        );
      },
    );
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