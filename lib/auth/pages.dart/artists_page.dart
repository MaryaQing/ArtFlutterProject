import 'package:flutter/material.dart';
import 'package:flutterdatabaseproject/models/artist_model.dart';
import 'package:flutterdatabaseproject/services/artist_service.dart';
import 'package:flutterdatabaseproject/widgets/custom_footer.dart';
import 'package:flutterdatabaseproject/widgets/custom_navigation_header.dart';

void main() {
  runApp(const MaterialApp(
    home: ArtistsPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({super.key});

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> with TickerProviderStateMixin {
  String activeFilter = 'all';
  
  // 1. قائمة لحفظ البيانات القادمة من JSON
  List<Artist> allArtists = [];
  List<Artist> filteredArtists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData(); 
  }

Future<void> _loadData() async {
  try {
    final data = await ArtistService.getAllArtists();
    setState(() {
allArtists = data.where((a) => a.type?.toLowerCase().trim() == 'art').toList();      // الفلترة الابتدائية (عند فتح الصفحة)
      filteredArtists = allArtists; 
      isLoading = false;
    });
  } catch (e) {
    print("Error: $e");
    setState(() => isLoading = false);
  }
}

void _filterArtists(String category) {
  setState(() {
    activeFilter = category;
    if (category == 'all') {
      filteredArtists = allArtists;
    } else {
      filteredArtists = allArtists.where((a) => a.category == category).toList();
    }
  });
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: const Color(0xFF372414),
      body: isLoading 
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFF5D79E)))
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomNavigationHeader(currentIndex: 2, screenWidth: screenWidth),
                  const SizedBox(height: 10),
                  _buildHeroSection(context),
                  const SizedBox(height: 30),
                  _buildFilterButtons(),
                  
                  // عرض القائمة المفلترة
                  Column(
                    children: filteredArtists
                        .map((artist) => _buildArtistItem(artist, isMobile))
                        .toList(),
                  ),
                  
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
    List<String> filters = ['all', 'classic', 'arab', 'digital', 'oil', 'watercolor', '3d', 'graphic'];
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      children: filters.map((f) => InkWell(
        onTap: () => _filterArtists(f), // استدعاء دالة الفلترة
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

  Widget _buildArtistItem(Artist artist, bool isMobile) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة الكبيرة
          Container(
            width: isMobile ? double.infinity : 400,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF5D79E), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset( 
                artist.mainImage ?? '', 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 40, height: 20),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(artist.name ?? '', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                Text(artist.description ?? '', style: const TextStyle(fontSize: 18, height: 1.4, color: Colors.white70)),
                const SizedBox(height: 25),
                
                if (artist.gallery != null && artist.gallery!.isNotEmpty)
                  Wrap(
                    spacing: 15,
                    children: artist.gallery!.asMap().entries.map((entry) {
                      int idx = entry.key;
                      String imgPath = entry.value;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            String? currentMain = artist.mainImage;
                            artist.mainImage = imgPath;
                            artist.gallery![idx] = currentMain!;
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

