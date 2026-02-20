import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/artist_model.dart';

class ArtistService {
  static Future<List<Artist>> getAllArtists() async {
    try {
      // 1. تأكدي أن المسار هنا مطابق تماماً لما هو في pubspec.yaml
      final String response = await rootBundle.loadString('assets/images/data/artists.json');
      final List<dynamic> data = json.decode(response);
      
      // 2. تحويل البيانات إلى Model مع طباعة للتأكد
      List<Artist> artists = data.map((json) => Artist.fromJson(json)).toList();
      
      print("Successfully loaded ${artists.length} artists"); // سيظهر لك في الـ Console
      return artists;
    } catch (e) {
      print("Error loading JSON: $e");
      return []; // في حال الخطأ يعود بقائمة فارغة
    }
  }
}