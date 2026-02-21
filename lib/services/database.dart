import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutterdatabaseproject/models/artist_model.dart';

class Database {
  final supabase = Supabase.instance.client;

  Future<List<Artist>> getData() async {
    final response = await supabase
        .from('artists')
        .select()
        .order('created_at');

    return (response as List)
        .map((item) => Artist.fromJson(item))
        .toList();
  }
}