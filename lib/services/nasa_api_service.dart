import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/manifest.dart';
import '../models/photo.dart';

class NasaApiService {
  static final String _apiKey = dotenv.env['API_KEY']!;
  static final String _baseUrl = dotenv.env['BASE_URL']!;

  static Future<Manifest> fetchManifest(String rover) async {
    final url = Uri.parse('$_baseUrl/manifests/$rover?api_key=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Manifest.fromJson(json['photo_manifest']);
    } else {
      throw Exception('Erreur de récupération du manifeste');
    }
  }

  static Future<List<Photo>> fetchPhotos(String rover, int sol) async {
    final url = Uri.parse('$_baseUrl/rovers/$rover/photos?sol=$sol&api_key=$_apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return (json['photos'] as List)
          .where((e) => e['img_src'] != null)
          .map((e) => Photo.fromJson(e))
          .toList();
    } else {
      throw Exception('Erreur de récupération des photos');
    }
  }
}