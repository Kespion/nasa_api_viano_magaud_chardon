import 'package:flutter/material.dart';
import '../models/manifest.dart';
import '../models/photo.dart';
import '../services/nasa_api_service.dart';

class RoverProvider extends ChangeNotifier {
  Manifest? manifest;
  List<Photo> photos = [];

  Future<void> fetchManifest(String rover) async {
    manifest = await NasaApiService.fetchManifest(rover);
    notifyListeners();
  }

  Future<void> fetchPhotos(String rover, int sol) async {
    photos = await NasaApiService.fetchPhotos(rover, sol);
    notifyListeners();
  }
}