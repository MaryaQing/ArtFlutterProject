import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// استيرادات الصفحات - تأكد من مطابقتها لمشروعك
import 'package:flutterdatabaseproject/auth/pages.dart/ArtistsPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/InspirationPage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/WeeklyChallengePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/HomePage.dart';
import 'package:flutterdatabaseproject/auth/pages.dart/custom_footer.dart';


class ArtistHistoryPage extends StatefulWidget {
  const ArtistHistoryPage({super.key});

  @override
  State<ArtistHistoryPage> createState() => _ArtistHistoryPageState();
}

class _ArtistHistoryPageState extends State<ArtistHistoryPage> {
  final List<Map<String, dynamic>> artists = [
    {
      "name": "Leonardo da Vinci",
      "desc":
          "A master of the Renaissance who combined art and science in revolutionary ways.",
      "image": "assets/images/vinchi.jpeg",
      "gallery": [
        "assets/images/mona.jpeg",
        "assets/images/vinchiwork.jpg",
        "assets/images/vinchiwork2.jpg",
      ],
    },
    {
      "name": "Claude Monet",
      "desc":
          "A pioneer of impressionism who captured light and color like no other.",
      "image": "assets/images/monetpic.jpeg",
      "gallery": [
        "assets/images/monbg.jpg",
        "assets/images/monbg3.jpg",
        "assets/images/moneh2.jpeg",
      ],
    },
    {
      "name": "Van Gogh",
      "desc":
          "A Dutch Post-Impressionist painter and one of the most influential figures in Western art history.",
      "image": "assets/images/van2.jpeg",
      "gallery": [
        "assets/images/vango1.jpeg",
        "assets/images/vango2.jpeg",
        "assets/images/vango3.jpeg",
      ],
    },
    {
      "name": "Rembrandt",
      "desc":
          "A Dutch Baroque painter and master storyteller in the history of art.",
      "image": "assets/images/Rembrandt.jpeg",
      "gallery": [
        "assets/images/ramprant1.jpeg",
        "assets/images/ramprant2.jpeg",
        "assets/images/ramprant3.jpeg",
      ],
    },
    {
      "name": "Michelangelo",
      "desc":
          "An Italian Renaissance sculptor and painter known for the Sistine Chapel ceiling.",
      "image": "assets/images/michelangelo.jpeg",
      "gallery": [
        "assets/images/michel.jpg",
        "assets/images/michel2.jpg",
        "assets/images/michel3.jpg",
      ],
    },
    {
      "name": "Eugène Delacroix",
      "desc":
          " was a French Romantic artist who was regarded as the leader of the French Romantic school",
      "image": "assets/images/ojen.jpg",

      "gallery": [
        "assets/images/ojen.jpg",
        "assets/images/ojen2.jpg",
        "assets/images/ojen3.jpg",
      ],
    },
  ];

  void openGallery(List gallery) {
    int currentIndex = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            backgroundColor: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  gallery[currentIndex],
                  fit: BoxFit.contain,
                ),
                Positioned(
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.white),
                    onPressed: () {
                      setState(() {
                        currentIndex =
                            (currentIndex - 1 + gallery.length) %
                                gallery.length;
                      });
                    },
                  ),
                ),
                Positioned(
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                    onPressed: () {
                      setState(() {
                        currentIndex =
                            (currentIndex + 1) % gallery.length;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _buildHeroSection(double width) {
    return Container(
      height: width < 600 ? 220 : 350,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/artists.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Artists in History",
                style: TextStyle(
                  fontSize: width < 600 ? 26 : 48,
                  fontFamily: "Serif",
                  color: const Color(0xFFFFEBC4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Explore the legacy of those who shaped the art world across centuries.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 1000) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF2C1B14),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomNavigationHeader(
              currentIndex: 4,
              screenWidth: width,
            ),

            _buildHeroSection(width),

            const SizedBox(height: 60),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: artists.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  childAspectRatio:
                      width < 600 ? 0.75 : 0.85,
                ),
                itemBuilder: (context, index) {
                  final artist = artists[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B2615),
                      borderRadius:
                          BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFD9B47D),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.vertical(
                                    top:
                                        Radius.circular(10)),
                            child: Image.asset(
                              artist["image"],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text(
                                artist["name"],
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  height: 8),
                              Text(
                                artist["desc"],
                                textAlign:
                                    TextAlign.center,
                                style:
                                    const TextStyle(
                                  color: Colors
                                      .white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                  height: 10),
                              ElevatedButton(
                                style:
                                    ElevatedButton
                                        .styleFrom(
                                  backgroundColor:
                                      const Color(
                                          0xFFECC377),
                                ),
                                onPressed: () =>
                                    openGallery(
                                        artist[
                                            "gallery"]),
                                child:
                                    const Text(
                                  "Show Art",
                                  style: TextStyle(
                                      color: Colors
                                          .white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 80),
            /// ===== FOOTER =====
        const CustomFooter(),
          ],
        ),
      ),
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
