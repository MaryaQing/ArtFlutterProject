import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/artist_model.dart';

class ArtistService {
  // استخدام Future لجلب البيانات بشكل غير متزامن (لحماية التطبيق من التجمد)
  Future<List<Artist>> loadArtists() async {
    try {
      // محاكاة تأخير بسيط (اختياري) لجعل تجربة المستخدم واقعية (Smooth Loading)
      await Future.delayed(const Duration(milliseconds: 500));

      // 1. تحميل ملف الـ JSON
      final String response = await rootBundle.loadString('assets/data/artists.json');
      
      // 2. تحويل النص إلى قائمة
      final List<dynamic> data = json.decode(response);
      
      // 3. تحويل القائمة إلى كائنات Artist باستخدام الموديل
      return data.map((item) => Artist.fromJson(item)).toList();
    } catch (e) {
      // معالجة الأخطاء (Proper error handling)
      throw Exception("Failed to load artists data");
    }
  }
}