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
  final ScrollController _scrollController = ScrollController();
  final int _batchSize = 20;
  int _visibleCount = 0;
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
      _visibleCount = (_batchSize < _photos.length) ? _batchSize : _photos.length;
      _isLoading = false;
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      final nextCount = _visibleCount + _batchSize;
      final max = _photos.length;

      if (_visibleCount >= max) return;

      setState(() {
        _visibleCount = nextCount < max ? nextCount : max;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      body: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _visibleCount,
        itemBuilder: (context, index) {
          final photo = _photos[index];
          return GridTile(
            footer: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(4),
              child: Text(
                photo.camera.fullName,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            child: Image.network(photo.imgSrc, fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}