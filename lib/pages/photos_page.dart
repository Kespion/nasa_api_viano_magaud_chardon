import 'package:flutter/material.dart';
import '../models/photo.dart';
import '../services/nasa_api_service.dart';
import '../providers/rover_provider.dart';
import 'package:provider/provider.dart';

class PhotosPage extends StatefulWidget {
  final int sol;
  const PhotosPage({super.key, required this.sol});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  final int _pageSize = 25;
  int _currentPage = 0;
  bool _isLoading = true;
  List<Photo> _photos = [];

  @override
  void initState() {
    super.initState();
    _fetchPhotos();
  }

  Future<void> _fetchPhotos() async {
    final roverName = Provider.of<RoverProvider>(context, listen: false).manifest?.roverName ?? 'Curiosity';
    final photos = await NasaApiService.fetchPhotos(roverName, widget.sol);

    if (!mounted) return;

    setState(() {
      _photos = photos;
      _isLoading = false;
    });
  }

  List<Photo> get _paginatedPhotos {
    final start = _currentPage * _pageSize;
    final end = (_currentPage + 1) * _pageSize;
    return _photos.sublist(start, end > _photos.length ? _photos.length : end);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_photos.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Photos du Sol ${widget.sol}")),
        body: const Center(child: Text("Aucune photo disponible pour ce sol.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Photos du Sol ${widget.sol}")),
      body: Column(
        children: [
          Text("Page ${_currentPage + 1} / ${(_photos.length / _pageSize).ceil()}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              itemCount: _paginatedPhotos.length,
              itemBuilder: (context, index) {
                final photo = _paginatedPhotos[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            photo.imgSrc ?? '',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(child: Icon(Icons.error, color: Colors.red));
                            },
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              photo.camera.name,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 0
                      ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                      : null,
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: (_currentPage + 1) * _pageSize < _photos.length
                      ? () {
                    setState(() {
                      _currentPage++;
                    });
                  }
                      : null,
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
