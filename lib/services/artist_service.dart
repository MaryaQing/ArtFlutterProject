import '../models/artist_model.dart';
import 'database.dart';
class ArtistService {

  static Future<List<Artist>> getAllArtists() async {
    return await Database().getData();
  }

}